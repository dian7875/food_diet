import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/services/dashboard_service.dart';
import 'package:food_diet/features/Dashboard/widgets/diet_dialog.dart';
import 'package:food_diet/features/MyMenu/widgets/food_card.dart';

class DinnerFoodsScreen extends StatefulWidget {
  const DinnerFoodsScreen({super.key});

  @override
  State<DinnerFoodsScreen> createState() => _DinnerFoodsScreenState();
}

class _DinnerFoodsScreenState extends State<DinnerFoodsScreen> {
  final FoodService _foodService = FoodService();

  List<Map<String, dynamic>> _dinnerFoods = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDinnerFoods();
  }

  Future<void> _loadDinnerFoods() async {
    try {
      final data = await _foodService.getRecipes();
      setState(() {
        _dinnerFoods = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error cargando cenas: $e';
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
        title: const Text('Cenas'),
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
                      'Mis Recetas para cena',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _dinnerFoods.length,
                      itemBuilder: (context, index) {
                        final food = _dinnerFoods[index];
                        return FoodCard(
                          recipe: food,
                          onTap: () => _showFoodDetails(food),
                          onRefresh:
                              _loadDinnerFoods,
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
