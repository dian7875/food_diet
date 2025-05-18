import 'package:flutter/material.dart';
import 'package:food_diet/features/Diet/services/diet_service.dart';

class CreateFoodDialog extends StatefulWidget {
  final VoidCallback onRefresh;

  const CreateFoodDialog({super.key, required this.onRefresh});

  @override
  State<CreateFoodDialog> createState() => _CreateFoodDialogState();
}

class _CreateFoodDialogState extends State<CreateFoodDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _dietaryInfoController = TextEditingController();

  void _submit() async {
    final payload = {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'ingredients': _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
      'steps': _stepsController.text.split('\n').map((e) => e.trim()).toList(),
      'dietary_info': _dietaryInfoController.text.split(',').map((e) => e.trim()).toList(),
    };

    final foodService = DietService();
    await foodService.createRecipe(payload);

    Navigator.of(context).pop();
    widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear nueva receta'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 2,
            ),
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ingredientes (separados por coma)',
              ),
              maxLines: 2,
            ),
            TextField(
              controller: _stepsController,
              decoration: const InputDecoration(
                labelText: 'Pasos (separados por salto de línea)',
              ),
              maxLines: 4,
            ),
            TextField(
              controller: _dietaryInfoController,
              decoration: const InputDecoration(
                labelText: 'Información dietética (separada por coma)',
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Crear'),
        ),
      ],
    );
  }
}
