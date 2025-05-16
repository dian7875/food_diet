import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/services/dashboard_service.dart';
import '../widgets/diet_card.dart';
import '../widgets/diet_dialog.dart';

class DietList extends StatefulWidget {
  const DietList({super.key});

  @override
  State<DietList> createState() => _DietListState();
}

class _DietListState extends State<DietList> {
  final FoodService _foodService = FoodService();

  List<Map<String, dynamic>> _recipes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final data = await _foodService.getRecipes();
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
    showDialog(
      context: context,
      builder: (_) => DietDialog(recipe: recipe),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        final recipe = _recipes[index];
        return DietCard(
          recipe: recipe,
          onTap: () => _openDialog(context, recipe),
        );
      },
    );
  }
}
