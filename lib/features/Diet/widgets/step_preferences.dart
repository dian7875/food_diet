import 'package:flutter/material.dart';
import 'preference_card.dart';

class StepPreferences extends StatefulWidget {
  final List<String> selectedPreferences;
  final void Function(List<String>) onPreferencesChanged;

  const StepPreferences({
    super.key,
    required this.selectedPreferences,
    required this.onPreferencesChanged,
  });

  @override
  State<StepPreferences> createState() => _StepPreferencesState();
}

class _StepPreferencesState extends State<StepPreferences> {
  late List<String> selected;

  // Define las opciones agrupadas
  final Map<String, List<Map<String, dynamic>>> groupedFoodOptions = {
    'Frutas': [
      {'name': 'Manzana', 'icon': Icons.apple},
      {'name': 'Banana', 'icon': Icons.food_bank}, 
      {'name': 'Naranja', 'icon': Icons.circle},
    ],
    'Verduras y vegetales': [
      {'name': 'Lechuga', 'icon': Icons.spa},
      {'name': 'Tomate', 'icon': Icons.local_florist},
      {'name': 'Zanahoria', 'icon': Icons.emoji_food_beverage},
    ],
    'Granos y carbohidratos': [
      {'name': 'Arroz', 'icon': Icons.rice_bowl},
      {'name': 'Pan', 'icon': Icons.bakery_dining},
      {'name': 'Pasta', 'icon': Icons.restaurant},
    ],
    'Proteínas y grasas': [
      {'name': 'Pollo', 'icon': Icons.set_meal},
      {'name': 'Carne', 'icon': Icons.restaurant},
      {'name': 'Pescado', 'icon': Icons.food_bank},
      {'name': 'Aguacate', 'icon': Icons.eco},
    ],
  };

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.selectedPreferences);
  }

  void toggleSelection(String food) {
    setState(() {
      if (selected.contains(food)) {
        selected.remove(food);
      } else {
        selected.add(food);
      }
      widget.onPreferencesChanged(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedFoodOptions.entries.map((group) {
          final groupName = group.key;
          final options = group.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecciona las $groupName de tu preferencia',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: options.map((item) {
                    final name = item['name'] as String;
                    final icon = item['icon'] as IconData;
                    final isSelected = selected.contains(name);

                    return PreferenceCard(
                      name: name,
                      iconData: icon,
                      selected: isSelected,
                      onTap: () => toggleSelection(name),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
