import 'package:flutter/material.dart';
import 'package:food_diet/features/Diet/services/diet_service.dart';
import 'package:food_diet/features/MyMenu/widgets/delete_recipe.dart';
import 'package:food_diet/features/MyMenu/widgets/edit_recipe.dart';

class FoodCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onRefresh;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.recipe,
    required this.onRefresh,
    required this.onTap,
  });

  void _handleDelete(BuildContext context) {
    final foodService = DietService();

    showDeleteConfirmationDialog(
      context: context,
      onConfirm: () async {
        await foodService.deleteRecipeById(
          '2',
        ); //AQUI IRIA algo como recipe['id'] o el identificador unico de la receta
        onRefresh();
      },
    );
  }

  void _handleEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => EditFoodDialog(recipe: recipe, onRefresh: onRefresh),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border(
            bottom: BorderSide(color: const Color(0xFFFCA838), width: 5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe['name'] ?? 'Nombre no disponible',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: List<Widget>.from(
                (recipe['dietary_info'] as List<dynamic>).map(
                  (info) => Chip(
                    label: Text(info),
                    backgroundColor: Colors.green.shade100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _handleEdit(context),
                  tooltip: 'Editar',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _handleDelete(context),
                  tooltip: 'Borrar',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
