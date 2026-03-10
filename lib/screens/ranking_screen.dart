import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/game_state.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        title: const Text('Top Players',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          final sortedPlayers = List.from(gameState.players);
          sortedPlayers.sort((a, b) => b.balance.compareTo(a.balance));

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: sortedPlayers.length,
            itemBuilder: (context, index) {
              final player = sortedPlayers[index];
              final isFirst = index == 0;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: isFirst ? const Color(0xFF1FF36B) : Colors.white,
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
                      radius: 24,
                      backgroundColor:
                          isFirst ? Colors.white : const Color(0xFFE5EEFF),
                      child: Text(
                        '#\${index + 1}',
                        style: TextStyle(
                            color: isFirst
                                ? const Color(0xFF111424)
                                : const Color(0xFF3388FF),
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: isFirst
                                    ? Colors.black87
                                    : const Color(0xFF111424)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      currencyFormat.format(player.balance),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color:
                            isFirst ? Colors.black87 : const Color(0xFF1FF36B),
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
