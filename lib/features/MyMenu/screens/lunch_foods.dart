import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/widgets/diet_dialog.dart';
import 'package:food_diet/features/MyMenu/services/my_menu_service.dart';
import 'package:food_diet/features/MyMenu/widgets/add_recipe_btn.dart';
import 'package:food_diet/features/MyMenu/widgets/food_card.dart';

class LunchFoodsScreen extends StatefulWidget {
  const LunchFoodsScreen({super.key});

  @override
  State<LunchFoodsScreen> createState() => _LunchFoodsScreenState();
}

class _LunchFoodsScreenState extends State<LunchFoodsScreen> {
  final MyMenuService _foodService = MyMenuService();

  List<Map<String, dynamic>> _lunchFoods = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadLunchFoods();
  }

  Future<void> _loadLunchFoods() async {
    try {
      final data = await _foodService.getSavedFoods('almuerzo');
      setState(() {
        _lunchFoods = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error cargando almuerzos: $e';
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
        title: const Text('Almuerzos'),
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
                      'Mis Recetas para almuerzo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _lunchFoods.length,
                      itemBuilder: (context, index) {
                        final food = _lunchFoods[index];
                        return FoodCard(
                          recipe: food,
                          onTap: () => _showFoodDetails(food),
                          onRefresh: _loadLunchFoods,
                        );
                      },
                    ),
                  ),
                ],
              ),
      floatingActionButton: AddRecipeButton(
        onRefresh: _loadLunchFoods,
        mealType: 'almuerzo',
      ),
    );
  }
}
