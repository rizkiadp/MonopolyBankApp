import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/game_state.dart';
import 'scanner_screen.dart';
import 'history_screen.dart';
import 'ranking_screen.dart';
import 'bank_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMainView(GameState gameState) {
    final current = gameState.currentPlayer;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            // App Bar Area
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFC1F6D5),
                  radius: 24,
                  child: Icon(Icons.menu, color: Colors.green[800]),
                ),
                const Text(
                  'Bank Monopoly',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xFFC1F6D5),
                  radius: 24,
                  child: Icon(Icons.settings, color: Colors.green[800]),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Main Player Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1FF36B).withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ]),
              child: Column(
                children: [
                  const Text(
                    'SEKARANG GILIRAN',
                    style: TextStyle(
                      color: Color(0xFF7A869A),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        current.name,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('🎲', style: TextStyle(fontSize: 28)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Saldo Kamu',
                          style: TextStyle(
                            color: Color(0xFF7A869A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currencyFormat.format(current.balance),
                          style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1FF36B),
                              height: 1.1),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Scan Button
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ScannerScreen()),
                  );
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1FF36B),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1FF36B).withValues(alpha: 0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        )
                      ],
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.qr_code_scanner,
                          size: 64, color: Colors.black87),
                      SizedBox(height: 12),
                      Text(
                        'BAYAR / TERIMA',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: 1.2),
                      )
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            // End Turn Button
            ElevatedButton(
              onPressed: () {
                gameState.nextTurn();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF111424),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Selesai Giliran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right, size: 24),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              _buildMainView(gameState),
              const HistoryScreen(),
              const BankScreen(),
              const RankingScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF1FF36B),
            unselectedItemColor: const Color(0xFF7A869A),
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Main'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded), label: 'Riwayat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_rounded), label: 'Bank'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events_rounded), label: 'Peringkat'),
            ],
          ),
        );
      },
    );
  }
}
