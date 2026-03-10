import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/game_state.dart';
import '../models/player.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleBankTransaction(BuildContext context, bool isReceiving) {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) return;

    final amount = int.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah yang valid')),
      );
      return;
    }

    final gameState = Provider.of<GameState>(context, listen: false);
    final player = gameState.currentPlayer;

    if (!isReceiving && player.balance < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saldo tidak mencukupi')),
      );
      return;
    }

    if (isReceiving) {
      // Add a method to GameState to handle direct bank transactions if you prefer,
      // or just adjust balance here directly if State allows. For now, we will
      // use a custom transaction block.
      _performBankTransaction(gameState, player, amount, true);
    } else {
      _performBankTransaction(gameState, player, amount, false);
    }

    _amountController.clear();
    Navigator.pop(context); // Close dialog
  }

  void _performBankTransaction(
      GameState gameState, Player player, int amount, bool isReceiving) {
    // Note: Since _addBalance / _deductBalance are private in GameState,
    // we assume the user might want us to add a public method,
    // but we can manipulate it if we create a public method or just call payRent equivalent.
    // For now, let's assume we will add `bankTransaction(amount, isReceiving)` to GameState.
    gameState.bankTransaction(amount, isReceiving: isReceiving);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isReceiving
              ? 'Berhasil menerima \${currencyFormat.format(amount)} dari Bank'
              : 'Berhasil membayar \${currencyFormat.format(amount)} ke Bank',
        ),
      ),
    );
  }

  void _showTransactionDialog(BuildContext context, bool isReceiving) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(isReceiving ? 'Terima dari Bank' : 'Bayar ke Bank',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Masukkan nominal',
              filled: true,
              fillColor: const Color(0xFFF4F6F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.attach_money),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () => _handleBankTransaction(context, isReceiving),
              style: ElevatedButton.styleFrom(
                backgroundColor: isReceiving
                    ? const Color(0xFF1FF36B)
                    : const Color(0xFFFF5252),
                foregroundColor: isReceiving ? Colors.black : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        final current = gameState.currentPlayer;
        
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Bank Central',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.account_balance,
                        size: 64,
                        color: Color(0xFF1FF36B),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        current.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currencyFormat.format(current.balance),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1FF36B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _buildTransactionButton(
                        context: context,
                        icon: Icons.arrow_downward,
                        label: 'Terima Kas',
                        color: const Color(0xFF1FF36B),
                        textColor: Colors.black,
                        isReceiving: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTransactionButton(
                        context: context,
                        icon: Icons.arrow_upward,
                        label: 'Bayar Bank',
                        color: const Color(0xFFFF5252),
                        textColor: Colors.white,
                        isReceiving: false,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    required bool isReceiving,
  }) {
    return ElevatedButton(
      onPressed: () => _showTransactionDialog(context, isReceiving),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
