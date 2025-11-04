import 'package:flutter/material.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> _dialogue = [
    "The storm came without warning. It ripped us apart... but it couldn't touch the thread between our hearts.",
    "I remember your hand slipping from mine. I remember your name: Babi. Now, I must find my way back.",
  ];
  int _dialogueIndex = 0;
  String _currentText = '';

  @override
  void initState() {
    super.initState();
    _startDialogue();
  }

  void _startDialogue() {
    if (_dialogueIndex < _dialogue.length) {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          _currentText = _dialogue[_dialogueIndex];
        });
        // Automatically advance dialogue for this simple intro
        Timer(const Duration(seconds: 5), () {
           if (mounted) {
            setState(() {
              _currentText = ''; // Fade out
            });
            _dialogueIndex++;
            _startDialogue();
           }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
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
    );
  }
}
