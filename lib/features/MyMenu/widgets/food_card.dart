import 'package:flutter/material.dart';
import 'package:food_diet/features/MyMenu/services/my_menu_service.dart';
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
  final foodService = MyMenuService();

  showDeleteConfirmationDialog(
    context: context,
    onConfirm: () async {
      try {
        final message = await foodService.deleteRecipeById(recipe['id'].toString());

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
          onRefresh();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al eliminar la receta')),
          );
        }
      }
    },
  );
}

void _handleEdit(BuildContext context) async {
  final message = await showDialog<String>(
    context: context,
    builder: (_) => EditFoodDialog(recipe: recipe, onRefresh: onRefresh),
  );

  if (message != null && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'desayuno':
        return Colors.orange.shade300;
      case 'almuerzo':
        return Colors.green.shade400;
      case 'cena':
        return Colors.purple.shade400;
      case 'merienda':
        return Colors.blue.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = recipe['category'] ?? 'Sin categoría';
    final categoryColor = _getCategoryColor(category);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: Border(
            left: BorderSide(color: categoryColor, width: 6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category.toUpperCase(),
                  style: TextStyle(
                    color: categoryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              recipe['name'] ?? 'Nombre no disponible',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),

            const SizedBox(height: 8),

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
