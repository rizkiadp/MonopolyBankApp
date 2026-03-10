import 'package:flutter/material.dart';
import '../models/property.dart';

class DestinationRevealedScreen extends StatelessWidget {
  final Property destination;

  const DestinationRevealedScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back, color: Colors.black87),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Stasiun Kereta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40) // Balance title spacing
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFADF8C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'TUJUAN DITETAPKAN!',
                  style: TextStyle(
                    color: Color(0xFF111424),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kereta akan berhenti di...',
                style: TextStyle(color: Color(0xFF7A869A), fontSize: 16),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFF1FF36B),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1FF36B).withValues(alpha: 0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        )
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.train,
                                color: Colors.black87, size: 32),
                            const Text('KARTU TUJUAN',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    letterSpacing: 1.5)),
                            const Icon(Icons.confirmation_num,
                                color: Colors.black87, size: 32),
                          ],
                        ),
                      ),

                      // Map Background Mock
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFFE5EEFF), // Light blue mock map bg
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://maps.googleapis.com/maps/api/staticmap?center=-6.914744,107.609810&zoom=13&size=400x400&maptype=roadmap'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Text(
                                  destination.name,
                                  style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black45,
                                            blurRadius: 10,
                                            offset: Offset(0, 5))
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 32),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              )),
                          child: Column(
                            children: [
                              Text(
                                  'Mohon perhatian! Pindahkan pion Anda ke \${destination.name} sekarang.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF111424),
                                      height: 1.3)),
                              const SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                      backgroundColor: Color(0xFF1FF36B),
                                      radius: 20,
                                      child: Icon(Icons.person,
                                          color: Colors.white)),
                                  Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child: const CircleAvatar(
                                        backgroundColor: Color(0xFF4A90E2),
                                        radius: 20,
                                        child: Icon(Icons.person,
                                            color: Colors.white)),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('+ Terima Rp2.000.000',
                                      style: TextStyle(
                                          color: Color(0xFF7A869A),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))
                                ],
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1FF36B),
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(double.infinity, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text('OKE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
