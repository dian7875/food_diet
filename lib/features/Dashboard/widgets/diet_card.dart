import 'package:flutter/material.dart';

class DietCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onTap;

  const DietCard({super.key, required this.recipe, required this.onTap});

  // Un método para mapear categorías a colores
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
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
          border: Border(
            left: BorderSide(color: _getCategoryColor(category), width: 6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge de categoría arriba a la derecha
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(category).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category.toUpperCase(),
                  style: TextStyle(
                    color: _getCategoryColor(category),
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

            Text(
              recipe['description'] ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
