import 'package:flutter/material.dart';

class DietDialog extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const DietDialog({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(recipe['description'], style: const TextStyle(fontSize: 16)),
            const Divider(height: 24),
            Text("Ingredientes:", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ...List<Widget>.from(
              (recipe['ingredients'] as List<dynamic>).map((i) => Text("- $i")),
            ),
            const SizedBox(height: 16),
            Text("Pasos:", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ...List<Widget>.from(
              (recipe['steps'] as List<dynamic>).asMap().entries.map(
                    (entry) => Text("${entry.key + 1}. ${entry.value}"),
                  ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
