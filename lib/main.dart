import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'state/game_state.dart';
import 'services/hive_service.dart';
import 'screens/setup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameState()),
      ],
      child: const MonopoliBankApp(),
    ),
  );
}

class MonopoliBankApp extends StatelessWidget {
  const MonopoliBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monopoli Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1FF36B)),
        scaffoldBackgroundColor:
            const Color(0xFFF6F8F6), // Light grayish-white from design
        textTheme:
            GoogleFonts.outfitTextTheme(Theme.of(context).textTheme).copyWith(
          displayLarge: GoogleFonts.outfit(
              fontWeight: FontWeight.bold, color: const Color(0xFF111424)),
          displayMedium: GoogleFonts.outfit(
              fontWeight: FontWeight.w700, color: const Color(0xFF111424)),
          displaySmall: GoogleFonts.outfit(
              fontWeight: FontWeight.w700, color: const Color(0xFF111424)),
          headlineMedium: GoogleFonts.outfit(
              fontWeight: FontWeight.w700, color: const Color(0xFF111424)),
          titleLarge: GoogleFonts.outfit(
              fontWeight: FontWeight.w600, color: const Color(0xFF111424)),
          bodyLarge: GoogleFonts.outfit(
              fontWeight: FontWeight.w500, color: const Color(0xFF111424)),
          bodyMedium: GoogleFonts.outfit(
              fontWeight: FontWeight.w400, color: const Color(0xFF6A6B74)),
        ),
        useMaterial3: true,
      ),
      home: const SetupScreen(),
    );
  }
}
