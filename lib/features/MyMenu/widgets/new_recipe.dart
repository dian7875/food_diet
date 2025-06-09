import 'package:flutter/material.dart';
import 'package:food_diet/features/MyMenu/services/my_menu_service.dart';

class CreateFoodDialog extends StatefulWidget {
  final VoidCallback onRefresh;
  final String mealType;

  const CreateFoodDialog({
    super.key,
    required this.onRefresh,
    required this.mealType,
  });

  @override
  State<CreateFoodDialog> createState() => _CreateFoodDialogState();
}

class _CreateFoodDialogState extends State<CreateFoodDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();

void _submit() async {
  if (_nameController.text.trim().isEmpty ||
      _ingredientsController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nombre e ingredientes son obligatorios')),
    );
    return;
  }

  final payload = {
    'name': _nameController.text.trim(),
    'description': _descriptionController.text.trim(),
    'ingredients': _ingredientsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(),
    'steps': _stepsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(),
    'category': widget.mealType,
  };

  final foodService = MyMenuService();

  try {
    final message = await foodService.createRecipe(payload);

    if (context.mounted) {
      Navigator.of(context).pop(message);
      widget.onRefresh();
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear receta: $e')),
      );
    }
  }
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Crear')),
      ],
    );
  }
}
