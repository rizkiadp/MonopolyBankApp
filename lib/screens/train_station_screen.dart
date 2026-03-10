import 'package:flutter/material.dart';
import '../services/board_data.dart';
import 'destination_revealed_screen.dart';

class TrainStationScreen extends StatefulWidget {
  final bool isRandom;

  const TrainStationScreen({super.key, required this.isRandom});

  @override
  State<TrainStationScreen> createState() => _TrainStationScreenState();
}

class _TrainStationScreenState extends State<TrainStationScreen> {
  String? _selectedTileId;

  void _confirmDestination() {
    if (_selectedTileId == null) return;

    Navigator.pop(context); // Close Train Station screen first

    // Find the property
    final prop = BoardData.initialProperties.firstWhere((p) => p.id == _selectedTileId);
    
    // Show destination revealed screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DestinationRevealedScreen(destination: prop)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final properties = BoardData.initialProperties;

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
                          'STASIUN KERETA',
                          style: TextStyle(
                            color: Color(0xFF1FF36B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'Beli Tiket',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40) // Balance title spacing
                ],
              ),
            ),

            // Header Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFADF8C7),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kereta Selanjutnya',
                    style: TextStyle(
                      color: Color(0xFF111424),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Peron 9¾',
                    style: TextStyle(
                      color: Color(0xFF111424),
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pilih tujuan Anda:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111424),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Use listview for selection
            Expanded(
              child: widget.isRandom
                  ? const Center(
                      child: Text("Randomly selecting (animating...)"))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        final prop = properties[index];
                        final isSelected = _selectedTileId == prop.id;

                        // Define dynamic styling based on set matching design
                        Color bgColor;
                        Color iconColor;
                        switch (prop.colorGroupId) {
                          case 'RED':
                            bgColor = const Color(0xFFFFE5E5);
                            iconColor = const Color(0xFFFF3366);
                            break;
                          case 'BROWN':
                            bgColor = const Color(0xFFFDF0CF);
                            iconColor = const Color(0xFFD6A035);
                            break;
                          default:
                            bgColor = const Color(0xFFE5EEFF);
                            iconColor = const Color(0xFF3388FF);
                        }

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTileId = prop.id;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(40),
                              border: isSelected
                                  ? Border.all(
                                      color: const Color(0xFF1FF36B), width: 3)
                                  : Border.all(
                                      color: Colors.transparent, width: 3),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: iconColor,
                                  child: const Icon(Icons.business,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        prop.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF111424),
                                        ),
                                      ),
                                      Text(
                                        '\${prop.colorGroupId} Set',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: iconColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: Icon(Icons.check_circle,
                                        color: Color(0xFF1FF36B), size: 32),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Confirm Button
            if (!widget.isRandom)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed:
                      _selectedTileId != null ? _confirmDestination : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1FF36B),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('KONFIRMASI TUJUAN',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18)),
                      SizedBox(width: 8),
                      Icon(Icons.chevron_right, size: 28),
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
