import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/screens/game_screen.dart';
import 'package:couldai_user_app/screens/gallery_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finding Us Again',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
          brightness: Brightness.dark,
          background: const Color(0xFF1a1a2e),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Serif', fontSize: 18.0, color: Colors.white),
          bodyMedium: TextStyle(fontFamily: 'Serif', fontSize: 16.0, color: Colors.white70),
          headlineLarge: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Colors.pinkAccent),
          headlineMedium: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Colors.white),
          titleLarge: TextStyle(fontFamily: 'Serif', fontStyle: FontStyle.italic, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent.withOpacity(0.8),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/game': (context) => const GameScreen(),
        '/gallery': (context) => const GalleryScreen(),
      },
    );
  }
}
