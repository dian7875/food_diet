import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyFoods extends StatelessWidget {
  const MyFoods({super.key});

  @override
  Widget build(BuildContext context) {
    final meals = [
      {'name': 'Desayuno', 'route': '/breakfast', 'icon': Icons.free_breakfast},
      {'name': 'Almuerzo', 'route': '/lunch', 'icon': Icons.lunch_dining},
      {'name': 'Cena', 'route': '/dinner', 'icon': Icons.dinner_dining},
      {'name': 'Merienda', 'route': '/snack', 'icon': Icons.emoji_food_beverage},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus comidas del día'),
        backgroundColor: const Color(0xFFD1D696),
        centerTitle: true,
      ),
           body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comidas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5B4A1F),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: meals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 30),
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEAD1),
                      borderRadius: BorderRadius.circular(12),
                      border: const Border(
                        left: BorderSide(color: Color(0xFFFCA838), width: 6),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: Icon(meal['icon'] as IconData, color: Color(0xFFFCA838), size: 32),
                      title: Text(
                        meal['name'] as String,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Color(0xFFFCA838)),
                      onTap: () => context.go(meal['route'] as String),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}