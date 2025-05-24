import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/services/dashboard_service.dart';
import 'package:food_diet/features/Dashboard/widgets/diet_dialog.dart';
import 'package:food_diet/features/MyMenu/widgets/add_recipe_btn.dart';
import 'package:food_diet/features/MyMenu/widgets/food_card.dart';

class SnacksScreen extends StatefulWidget {
  const SnacksScreen({super.key});

  @override
  State<SnacksScreen> createState() => _SnacksScreenState();
}

class _SnacksScreenState extends State<SnacksScreen> {
  final FoodService _foodService = FoodService();

  List<Map<String, dynamic>> _snacks = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSnacks();
  }

  Future<void> _loadSnacks() async {
    try {
      final data = await _foodService.getRecipes();
      setState(() {
        _snacks = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error cargando snacks: $e';
        _isLoading = false;
      });
    }
  }

  void _showFoodDetails(Map<String, dynamic> food) {
    showDialog(context: context, builder: (_) => DietDialog(recipe: food));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snacks'),
        backgroundColor: const Color(0xFFD1D696),
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      'Mis Recetas para snacks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _snacks.length,
                      itemBuilder: (context, index) {
                        final food = _snacks[index];
                        return FoodCard(
                          recipe: food,
                          onTap: () => _showFoodDetails(food),
                          onRefresh: _loadSnacks,
                        );
                      },
                    ),
                  ),
                ],
              ),
      floatingActionButton: AddRecipeButton(
        onRefresh: _loadSnacks,
        mealType: 'snacks',
      ),
    );
  }
}
