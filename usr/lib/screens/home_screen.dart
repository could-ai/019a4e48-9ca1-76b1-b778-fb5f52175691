import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1a1a2e),
              Colors.pinkAccent.withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Finding Us Again',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 40,
                  shadows: [
                    const Shadow(
                      blurRadius: 10.0,
                      color: Colors.pinkAccent,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'A Love Story',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/game');
                },
                child: const Text('Begin Our Journey'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/gallery');
                },
                child: const Text('Our Love Gallery'),
              ),
               const SizedBox(height: 150),
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Text(
                  '“Happy 9 Months and 2 Years, Babi 💞”\n— From your love, who will always choose you.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
