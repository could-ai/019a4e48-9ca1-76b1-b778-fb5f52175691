import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// Represents the different stages of the game
enum GameState { intro, level1, level1End }

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameState _gameState = GameState.intro;
  int _dialogueIndex = 0;
  String _currentText = '';
  bool _showCollectibles = false;

  // Store all dialogue in a structured way
  static const Map<GameState, List<String>> _dialogues = {
    GameState.intro: [
      "The storm came without warning. It ripped us apart... but it couldn't touch the thread between our hearts.",
      "I remember your hand slipping from mine. I remember your name: Babi. Now, I must find my way back.",
    ],
    GameState.level1: [
      "This is where it all began... a quiet corner of the world, just waiting for us.",
      "I didn’t know that one 'hello' would change my life forever.",
      "Every conversation was a late-night adventure. We used to stay up until the sun rose.",
      "You made ordinary days feel special, like everything had a purpose.",
      "That sudden, terrifying moment when you realize... this person is your future.",
    ],
    GameState.level1End: [
      "The journey of love has just begun. Keep going.",
    ],
  };

  // Track collected items for Level 1
  final List<bool> _lightsCollected = List.generate(5, (_) => false);
  final List<Point<double>> _lightPositions = [];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _generateLightPositions();
    _startIntro();
  }

  // Generate random positions for the memory lights
  void _generateLightPositions() {
    for (int i = 0; i < 5; i++) {
      // Distribute lights across the screen, avoiding edges.
      _lightPositions.add(Point(
        _random.nextDouble() * 0.7 + 0.15, // x: 15% to 85% of width
        _random.nextDouble() * 0.6 + 0.2,  // y: 20% to 80% of height
      ));
    }
  }

  void _startIntro() {
    final introDialogue = _dialogues[GameState.intro]!;
    if (_dialogueIndex < introDialogue.length) {
      _showText(introDialogue[_dialogueIndex], duration: const Duration(seconds: 4), onComplete: () {
        _dialogueIndex++;
        if (_dialogueIndex >= introDialogue.length) {
          // End of intro, transition to Level 1
          _dialogueIndex = 0;
          _transitionToLevel1();
        } else {
          _startIntro();
        }
      });
    }
  }

  void _transitionToLevel1() {
    setState(() {
      _gameState = GameState.level1;
      _currentText = "Level 1 – The Beginning\nCollect 5 Floating Memory Lights";
    });

    // After showing the level title, show the collectibles
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _currentText = '';
          _showCollectibles = true;
        });
      }
    });
  }

  void _onLightCollected(int index) {
    if (_lightsCollected[index] || _currentText.isNotEmpty) return; // Already collected or dialogue is showing

    setState(() {
      _lightsCollected[index] = true;
    });

    final level1Dialogue = _dialogues[GameState.level1]!;
    _showText(level1Dialogue[index], duration: const Duration(seconds: 4), onComplete: () {
      // Check if all lights are collected
      if (_lightsCollected.every((collected) => collected)) {
        _endLevel1();
      }
    });
  }

  void _endLevel1() {
    setState(() {
      _showCollectibles = false;
      _gameState = GameState.level1End;
    });
    final endDialogue = _dialogues[GameState.level1End]!;
    _showText(endDialogue[0], duration: const Duration(seconds: 4), onComplete: () {
      // Here you would transition to Level 2
      if (mounted) {
        setState(() {
          _currentText = "The next chapter of our story is coming soon...";
        });
      }
    });
  }

  // Helper to show text for a duration and then execute a callback
  void _showText(String text, {required Duration duration, required VoidCallback onComplete}) {
    if (!mounted) return;
    setState(() {
      _currentText = text;
    });
    Timer(duration, () {
      if (mounted) {
        setState(() {
          _currentText = '';
        });
        // Wait for fade out before calling onComplete
        Timer(const Duration(milliseconds: 500), onComplete);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Dialogue Text
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedOpacity(
                opacity: _currentText.isEmpty ? 0.0 : 1.0,
                duration: const Duration(seconds: 1),
                child: Text(
                  _currentText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
              ),
            ),
          ),
          // Level 1 Collectibles
          if (_showCollectibles)
            ..._buildMemoryLights(context),
        ],
      ),
    );
  }

  List<Widget> _buildMemoryLights(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return List.generate(5, (index) {
      return Positioned(
        left: size.width * _lightPositions[index].x - 20, // Center icon
        top: size.height * _lightPositions[index].y - 20, // Center icon
        child: AnimatedOpacity(
          opacity: _lightsCollected[index] ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 500),
          child: GestureDetector(
            onTap: () => _onLightCollected(index),
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.2),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: const Icon(
                Icons.lightbulb,
                color: Colors.yellowAccent,
                size: 40,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.yellowAccent,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
