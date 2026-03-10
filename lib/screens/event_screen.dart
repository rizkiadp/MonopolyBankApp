import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final String cardText;
  final bool isChance;

  const EventScreen(
      {super.key, required this.cardText, required this.isChance});

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isChance ? const Color(0xFF1FF36B) : const Color(0xFFFF8B3E);
    final title = isChance ? 'CHANCE CARD' : 'COMMUNITY';

    return Scaffold(
      backgroundColor:
          const Color(0xFF111424).withValues(alpha: 0.9), // Dark semi-transparent
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withValues(alpha: 0.3),
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
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Icon(
                isChance ? Icons.help_outline : Icons.people_outline,
                size: 80,
                color: bgColor,
              ),
              const SizedBox(height: 32),
              Text(
                cardText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111424),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111424),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('OKAY',
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
