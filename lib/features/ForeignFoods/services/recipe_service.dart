import 'package:food_diet/core/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe.dart';
import '../repository/recipe_repository.dart';

class RecipeService {
  final api = ApiService();

  Future<List<Map<String, dynamic>>> generateForeingRecipes(
    String country,
  ) async {
    final List<String> iterations = ['1', '2', '3'];
    final List<Map<String, dynamic>> recipes = [];

    try {
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('userId');

      if (userId == null) {
        throw Exception('User ID no encontrado');
      }

      final futures =
          iterations.map((_) async {
            final response = await api.dio.post(
              '/recipes/generate/user/$userId/$country',
            );
            return response.data as Map<String, dynamic>;
          }).toList();

      final results = await Future.wait(futures);

      recipes.addAll(results);

      return recipes;
    } catch (e) {
      print('Error al generar recetas: $e');
      return [];
    }
  }

  Future<List<String>> getCountries() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return RecipeRepository.getCountries();
    } catch (e) {
      throw Exception('Error al cargar los países: $e');
    }
  }

  Future<List<Recipe>> getRecipesByCountry(String country) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      return RecipeRepository.getRecipesByCountry(country);
    } catch (e) {
      throw Exception('Error al cargar las recetas del país: $e');
    }
  }
}
