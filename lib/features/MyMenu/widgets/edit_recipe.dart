import 'package:flutter/material.dart';
import 'package:food_diet/features/Diet/services/diet_service.dart';

class EditFoodDialog extends StatefulWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onRefresh;

  const EditFoodDialog({
    super.key,
    required this.recipe,
    required this.onRefresh,
  });

  @override
  State<EditFoodDialog> createState() => _EditFoodDialogState();
}

class _EditFoodDialogState extends State<EditFoodDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;
  late TextEditingController _dietaryInfoController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe['name']);
    _descriptionController = TextEditingController(
      text: widget.recipe['description'],
    );
    _ingredientsController = TextEditingController(
      text: (widget.recipe['ingredients'] as List).join(', '),
    );
    _stepsController = TextEditingController(
      text: (widget.recipe['steps'] as List).join('\n'),
    );
    _dietaryInfoController = TextEditingController(
      text: (widget.recipe['dietary_info'] as List).join(', '),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _dietaryInfoController.dispose();
    super.dispose();
  }

  void _submit() async {
    final payload = {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'ingredients':
          _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
      'steps': _stepsController.text.split('\n').map((e) => e.trim()).toList(),
      'dietary_info':
          _dietaryInfoController.text.split(',').map((e) => e.trim()).toList(),
    };

    final foodService = DietService();
    await foodService.updateRecipeById(widget.recipe['id'].toString(), payload);

    Navigator.of(context).pop();
    widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Receta'),
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
            ),
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ingredientes (separados por coma)',
              ),
            ),
            TextField(
              controller: _stepsController,
              decoration: const InputDecoration(
                labelText: 'Pasos (uno por línea)',
              ),
              maxLines: 4,
            ),
            TextField(
              controller: _dietaryInfoController,
              decoration: const InputDecoration(
                labelText: 'Info dietética (separada por coma)',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Guardar')),
      ],
    );
  }
}
