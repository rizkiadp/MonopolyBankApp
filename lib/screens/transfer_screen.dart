import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/game_state.dart';
import '../models/player.dart';

class TransferScreen extends StatefulWidget {
  final Player targetPlayer;

  const TransferScreen({super.key, required this.targetPlayer});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _amountController = TextEditingController();
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _confirmTransfer() {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) return;

    final amount = int.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah yang valid (Valid amount required)')),
      );
      return;
    }

    final gameState = Provider.of<GameState>(context, listen: false);

    if (gameState.currentPlayer.balance < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saldo tidak mencukupi (Insufficient balance)')),
      );
      return;
    }

    gameState.transferMoney(widget.targetPlayer, amount);
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil transfer \${currencyFormat.format(amount)} ke \${widget.targetPlayer.name}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'TRANSFER PEMAIN',
                          style: TextStyle(
                            color: Color(0xFF3388FF),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'Kirim Uang',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40)
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFFE5EEFF),
                    child: const Icon(Icons.person, size: 40, color: Color(0xFF3388FF)),
                  ),
                  const SizedBox(height: 16),
                  const Text('MENGIRIM KE:', style: TextStyle(color: Color(0xFF7A869A), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  Text(
                    widget.targetPlayer.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF111424)),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF3388FF)),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '0',
                      prefixText: 'Rp ',
                      filled: true,
                      fillColor: const Color(0xFFF4F6F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _confirmTransfer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3388FF),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('KONFIRMASI TRANSFER',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18)),
                    SizedBox(width: 8),
                    Icon(Icons.send, size: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
