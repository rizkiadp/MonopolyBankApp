import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import '../models/scan_result.dart';
import 'event_screen.dart';
import 'property_screen.dart';
import 'train_station_screen.dart';
import 'transfer_screen.dart';
import 'tax_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  bool _isScanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanned) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      final code = barcodes.first.rawValue!;
      setState(() {
        _isScanned = true;
      });

      // Pass down logic to game state
      final gameState = Provider.of<GameState>(context, listen: false);
      final result = gameState.handleScan(code);

      if (mounted) {
        Navigator.pop(context); // Close scanner first

        if (result != null) {
          switch (result.type) {
            case ScanType.playerTransfer:
              final playerId = result.payload;
              if (playerId != null) {
                try {
                  final targetPlayer = gameState.players.firstWhere((p) => p.id == playerId);
                  if (targetPlayer.id == gameState.currentPlayer.id) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cannot transfer to yourself!')),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TransferScreen(targetPlayer: targetPlayer)),
                    );
                  }
                } catch (e) {
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Player not found')),
                   );
                }
              }
              break;
            case ScanType.chance:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventScreen(
                      cardText: result.payload ?? '', isChance: true),
                ),
              );
              break;
            case ScanType.community:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventScreen(
                      cardText: result.payload ?? '', isChance: false),
                ),
              );
              break;
            case ScanType.property:
              final propId = result.payload;
              if (propId != null) {
                try {
                  final prop =
                      gameState.properties.firstWhere((p) => p.id == propId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PropertyScreen(property: prop),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Property not found: $propId')),
                  );
                }
              }
              break;
            case ScanType.trainRandom:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TrainStationScreen(isRandom: true),
                ),
              );
              break;
            case ScanType.trainFree:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TrainStationScreen(isRandom: false),
                ),
              );
              break;
            case ScanType.tax:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaxScreen(taxId: result.payload ?? 'TAX_GENERIC'),
                ),
              );
              break;
            case ScanType.unhandled:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result.message ?? 'Scanned: $code')),
              );
              break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            const Color(0xFF111424), // Dark background matching design
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    Text(
                      'Pindai Kode QR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'Arahkan kamera ke kode QR pemain atau kartu untuk melakukan transaksi atau melihat detailnya!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border:
                          Border.all(color: const Color(0xFF1FF36B), width: 4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MobileScanner(
                        controller: controller,
                        onDetect: _onDetect,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 32.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF111424),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 12),
                      Text(
                        'Kembali',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
