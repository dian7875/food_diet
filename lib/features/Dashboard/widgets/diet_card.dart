import 'package:flutter/material.dart';

class DietCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onTap;

  const DietCard({super.key, required this.recipe, required this.onTap});

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
          border: Border(left: BorderSide(color: Color(0xFFFCA838), width: 5)),
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
          ],
        ),
      ),
    );
  }
}
