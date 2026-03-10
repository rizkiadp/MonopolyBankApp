import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/property.dart';
import '../state/game_state.dart';

class PropertyScreen extends StatelessWidget {
  final Property property;

  const PropertyScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return Scaffold(
      backgroundColor: const Color(0xFF1FF36B), // Green bar top
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      child:
                          const Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'BOARD GAME',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Property Info',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFF1FF36B),
                    child: Text('P1',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),

            // White Content Box
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Property Image Mock
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD6EAE1),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Icon(
                            Icons.business,
                            size: 100,
                            color: const Color(0xFF1FF36B),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      Text(
                        property.name,
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF111424)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Wait for logic to show region • \${property.colorGroupId} Set',
                        style: const TextStyle(
                            color: Color(0xFF7A869A),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 48),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoColumn(
                              icon: Icons.payments,
                              iconColor: const Color(0xFF1FF36B),
                              iconBg: const Color(0xFFE4F9ED),
                              label: 'HARGA',
                              value: currencyFormat.format(property.price)),
                          Container(
                              width: 1,
                              height: 60,
                              color: Colors.grey.withValues(alpha: 0.2)),
                          _buildInfoColumn(
                              icon: Icons.receipt_long,
                              iconColor: const Color(0xFFFF8B3E),
                              iconBg: const Color(0xFFFFF0E6),
                              label: 'SEWA',
                              value: currencyFormat.format(property.baseRent)),
                        ],
                      ),

                      const SizedBox(height: 60),

                      // Actions
                      ElevatedButton(
                        onPressed: () {
                          final gameState =
                              Provider.of<GameState>(context, listen: false);
                          if (property.ownerId == null) {
                            gameState.buyProperty(property);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Berhasil membeli \${property.name}!')));
                          } else if (property.ownerId !=
                              gameState.currentPlayer.id) {
                            gameState.payRent(property);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Membayar sewa untuk \${property.name}')));
                          } else {
                            // Upgrade logic can go here later
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Fitur upgrade akan segera hadir.')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1FF36B),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Consumer<GameState>(
                            builder: (context, gameState, child) {
                          String btnText =
                              'BELI - \${currencyFormat.format(property.price)}';
                          if (property.ownerId != null) {
                            if (property.ownerId ==
                                gameState.currentPlayer.id) {
                              btnText = 'MILIKMU (UPGRADE)';
                            } else {
                              btnText = 'BAYAR SEWA - \${currencyFormat.format(property.baseRent)}';
                            }
                          }
                          return Text(btnText,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18));
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: iconBg,
          radius: 28,
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: const TextStyle(
              color: Color(0xFF7A869A),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFF111424)),
        )
      ],
    );
  }
}
