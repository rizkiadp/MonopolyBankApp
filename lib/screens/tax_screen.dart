import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/game_state.dart';

class TaxScreen extends StatelessWidget {
  final String taxId;

  const TaxScreen({super.key, required this.taxId});

  @override
  Widget build(BuildContext context) {
    // Map tax ID to human readable data
    String taxName = 'Pajak';
    int taxAmount = 2000000; // default
    
    if (taxId == 'TAX_INCOME') {
      taxName = 'Pajak Penghasilan';
      taxAmount = 2000000;
    } else if (taxId == 'TAX_LUXURY') {
      taxName = 'Pajak Barang Mewah';
      taxAmount = 1000000;
    } else {
      // For random or generic tax
      final amountStr = taxId.replaceAll(RegExp(r'[^0-9]'), '');
      if (amountStr.isNotEmpty) {
        taxAmount = int.tryParse(amountStr) ?? 200;
      }
    }

    final NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      backgroundColor: const Color(0xFF111424).withValues(alpha: 0.9), // Dark semi-transparent
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5252).withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  taxName.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFFFF5252),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              const Icon(
                Icons.account_balance,
                size: 80,
                color: Color(0xFFFF5252),
              ),
              const SizedBox(height: 32),
              const Text(
                'Anda berada di petak pajak. Anda harus membayar:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A869A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                currencyFormat.format(taxAmount),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFF5252),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  final gameState = Provider.of<GameState>(context, listen: false);
                  if (gameState.currentPlayer.balance < taxAmount) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saldo tidak cukup! Tindakan diperlukan.')),
                    );
                    return;
                  }
                  gameState.payTax(taxAmount, taxName);
                  Navigator.pop(context); // Close tax screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5252),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('BAYAR PAJAK',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
