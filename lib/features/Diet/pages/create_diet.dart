import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateDiet extends StatefulWidget {
  const CreateDiet({super.key});

  @override
  _CreateDietState createState() => _CreateDietState();
}

class _CreateDietState extends State<CreateDiet> {
  TextEditingController dietNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _saveDietData(String dietName, String description) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasDiet', true); 
    await prefs.setString('dietName', dietName);
    await prefs.setString('description', description);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Dieta'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Crea tu dieta', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              controller: dietNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la dieta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveDietData(dietNameController.text, descriptionController.text);
              },
              child: const Text('Guardar Dieta'),
            ),
          ],
        ),
      ),
    );
  }
}
