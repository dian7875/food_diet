import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.5,
            width: double.infinity,
            child: Image.asset(
              'assets/images/HomeBG.png',
              fit: BoxFit.fitHeight
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Food Diet',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Alcanza tu objetivo de una manera sana y personalizada.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Iniciar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: () => context.go('/about'),
                  style: TextButton.styleFrom(  foregroundColor: Colors.black,),
                  child: const Text('Obten más Información aquí '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
