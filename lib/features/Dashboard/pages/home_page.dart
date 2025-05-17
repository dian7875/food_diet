import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/screens/diet_list.dart';
import 'package:food_diet/features/Dashboard/widgets/create_diet_button.dart';

class HomePage extends StatefulWidget {
  final bool hasDiet;

  const HomePage({super.key, required this.hasDiet});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _hasDiet;

  @override
  void initState() {
    super.initState();
    _hasDiet = widget.hasDiet;
  }

  void _onDietCreated() {
    setState(() {
      _hasDiet = true; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          !_hasDiet ? 'Menú del día' : 'Crear dieta',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFD1D696),
        centerTitle: true,
      ),
      body: !_hasDiet
          ? CreateDietButton(onFinished: _onDietCreated) 
          : const DietList(),
    );
  }
}
