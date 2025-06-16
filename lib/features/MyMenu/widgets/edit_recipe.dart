import 'package:flutter/material.dart';
import 'package:food_diet/features/MyMenu/services/my_menu_service.dart';

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
    _nameController = TextEditingController(text: widget.recipe['name'] ?? '');
    _descriptionController = TextEditingController(
      text: widget.recipe['description'] ?? '',
    );

    final ingredients =
        (widget.recipe['ingredients'] as List?)?.cast<String>() ?? [];
    final steps = (widget.recipe['steps'] as List?)?.cast<String>() ?? [];
    final dietaryInfo =
        (widget.recipe['dietary_info'] as List?)?.cast<String>() ?? [];

    _ingredientsController = TextEditingController(
      text: ingredients.join(', '),
    );
    _stepsController = TextEditingController(text: steps.join('\n'));
    _dietaryInfoController = TextEditingController(
      text: dietaryInfo.join(', '),
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
      'ingredients':
          _ingredientsController.text
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
      'steps':
          _stepsController.text
              .split('\n')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
    };

    final foodService = MyMenuService();

  try {
    final message = await foodService.updateRecipeById(
      widget.recipe['id'].toString(),
      payload,
    );

    if (context.mounted) {
      Navigator.of(context).pop(message);
      widget.onRefresh();
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar: $e')),
      );
    }
  }
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
