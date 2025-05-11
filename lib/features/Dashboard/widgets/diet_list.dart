import 'package:flutter/material.dart';

class DietList extends StatelessWidget {
  const DietList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Lista de comidas para tu dieta:',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          const Text('Comida 1', style: TextStyle(fontSize: 16)),
          const Text('Comida 2', style: TextStyle(fontSize: 16)),
          const Text('Comida 3', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
