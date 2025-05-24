import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/services/dashboard_service.dart';
import 'package:food_diet/features/Dashboard/widgets/diet_dialog.dart';
import 'package:food_diet/features/MyMenu/widgets/add_recipe_btn.dart';
import 'package:food_diet/features/MyMenu/widgets/food_card.dart';

class BreakfastFoodsScreen extends StatefulWidget {
  const BreakfastFoodsScreen({super.key});

  @override
  State<BreakfastFoodsScreen> createState() => _BreakfastFoodsScreenState();
}

class _BreakfastFoodsScreenState extends State<BreakfastFoodsScreen> {
  final FoodService _foodService = FoodService();

  List<Map<String, dynamic>> _breakfastFoods = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBreakfastFoods();
  }

  Future<void> _loadBreakfastFoods() async {
    try {
      final data = await _foodService.getRecipes();
      setState(() {
        _breakfastFoods = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error cargando desayunos: $e';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Desayunos'),
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
                      'Mis Recetas para desayuno',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _breakfastFoods.length,
                      itemBuilder: (context, index) {
                        final food = _breakfastFoods[index];
                        return FoodCard(
                          recipe: food,
                          onTap: () => _showFoodDetails(food),
                          onRefresh: _loadBreakfastFoods,
                        );
                      },
                    ),
                  ),
                ],
              ),
      floatingActionButton: AddRecipeButton(
        onRefresh: _loadBreakfastFoods,
        mealType: 'breackfast',
      ),
    );
  }
}
