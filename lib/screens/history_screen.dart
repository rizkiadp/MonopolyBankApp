import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/game_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        title: const Text('Transaction History',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          final history = gameState.history.reversed.toList();

          if (history.isEmpty) {
            return const Center(
                child: Text("No transactions yet.",
                    style: TextStyle(color: Colors.grey)));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final tx = history[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFE5EEFF),
                      child: Icon(
                        tx.fromPlayerName == 'BANK'
                            ? Icons.account_balance
                            : tx.toPlayerName == 'BANK'
                                ? Icons.payment
                                : Icons.swap_horiz,
                        color: const Color(0xFF3388FF),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.reason,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF111424)),
                          ),
                          Text(
                            '\${tx.fromPlayerName} → \${tx.toPlayerName}',
                            style: const TextStyle(
                                color: Color(0xFF7A869A), fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Text(
                      currencyFormat.format(tx.amount),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: tx.fromPlayerName == 'BANK'
                            ? const Color(0xFF1FF36B)
                            : const Color(0xFFFF3366),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
