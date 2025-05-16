import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/widgets/create_diet_button.dart';
import 'package:food_diet/features/Dashboard/screens/diet_list.dart';

class HomePage extends StatelessWidget {
  final bool hasDiet;

  const HomePage({super.key, required this.hasDiet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          !hasDiet ? 'Menu del dia' : 'Crear dieta',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
         backgroundColor: const Color(0xFFD1D696),
         centerTitle: true,
      ),
      body: !hasDiet ?  DietList() : const CreateDietButton(),
    );
  }
}
