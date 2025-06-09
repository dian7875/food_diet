import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/screens/diet_list.dart';
import 'package:food_diet/features/Dashboard/widgets/create_diet_button.dart';

class HomePage extends StatelessWidget {
  final bool hasDiet;
  final VoidCallback? onDietCreated;

  const HomePage({
    super.key,
    required this.hasDiet,
    this.onDietCreated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hasDiet ? 'Menú del día' : 'Crear dieta',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFD1D696),
        centerTitle: true,
      ),
      body: !hasDiet
          ? CreateDietButton(onFinished: onDietCreated)
          : const DietList(),
    );
  }
}