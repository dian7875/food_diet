import 'package:flutter/material.dart';
import 'package:food_diet/features/MyMenu/widgets/new_recipe.dart';

class AddRecipeButton extends StatelessWidget {
  final VoidCallback onRefresh;
  final String mealType; 

  const AddRecipeButton({
    super.key,
    required this.onRefresh,
    required this.mealType,
  });

  void _openCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CreateFoodDialog(
        onRefresh: onRefresh,
        mealType: mealType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _openCreateDialog(context),
      tooltip: 'Agregar receta',
      child: const Icon(Icons.add),
    );
  }
}
