import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/services/dashboard_service.dart';
import 'package:food_diet/features/MyMenu/services/my_menu_service.dart';
import '../widgets/diet_card.dart';
import '../widgets/diet_dialog.dart';

class DietList extends StatefulWidget {
  const DietList({super.key});

  @override
  State<DietList> createState() => _DietListState();
}

class _DietListState extends State<DietList> {
  final FoodService _foodService = FoodService();
  final MyMenuService _menuService = MyMenuService();
  List<Map<String, dynamic>> _recipes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes({bool force = false}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _foodService.generateRecipesForUser(
        forceRefresh: force,
      );
      setState(() {
        _recipes = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _openDialog(BuildContext context, Map<String, dynamic> recipe) {
    showDialog(context: context, builder: (_) => DietDialog(recipe: recipe));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No se pudieron cargar las recetas.\nPor favor, intente de nuevo.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _loadRecipes(force: true),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            final recipe = _recipes[index];
            return DietCard(
              recipe: recipe,
              onTap: () => _openDialog(context, recipe),
              isFavorite: _menuService.isFavorite(recipe['name']),
              onToggleFavorite: () async {
                await _menuService.toggleFavorite(recipe);
                setState(() {});
              },
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            onPressed: () => _loadRecipes(force: true),
            backgroundColor: Colors.blue,
            child: const Icon(Icons.find_replace_outlined),
          ),
        ),
      ],
    );
  }
}
