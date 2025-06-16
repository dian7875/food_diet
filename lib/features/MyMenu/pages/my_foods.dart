import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyFoods extends StatelessWidget {
  const MyFoods({super.key});

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
    final meals = [
      {'name': 'Desayuno', 'route': '/MyFoods/breakfast', 'icon': Icons.free_breakfast},
      {'name': 'Almuerzo', 'route': '/MyFoods/lunch', 'icon': Icons.lunch_dining},
      {'name': 'Cena', 'route': '/MyFoods/dinner', 'icon': Icons.dinner_dining},
      {'name': 'Merienda', 'route': '/MyFoods/snack', 'icon': Icons.emoji_food_beverage},
    ];
   return Scaffold(
      appBar: AppBar(
        title: const Text('Tus comidas del día'),
        backgroundColor: const Color(0xFFD1D696),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
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
                separatorBuilder: (_, __) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  final name = meal['name'] as String;
                  final color = _getCategoryColor(name);

                  return GestureDetector(
                    onTap: () => context.go(meal['route'] as String),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                        border: Border(
                          left: BorderSide(color: color, width: 6),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(meal['icon'] as IconData, color: color, size: 32),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: color),
                        ],
                      ),
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
