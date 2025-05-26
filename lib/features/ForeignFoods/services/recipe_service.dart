import 'package:dio/dio.dart';
import '../models/recipe.dart';
import '../repository/recipe_repository.dart';

class RecipeService {
  final Dio _dio = Dio();

  // En el futuro, esto se conectará a una API real
  Future<List<Recipe>> getRecipes() async {
    try {
      // Simulando una llamada a API
      await Future.delayed(const Duration(milliseconds: 800));
      return RecipeRepository.recipes;

      // Cuando tengas una API real, usarías algo como:
      // final response = await _dio.get('tu-api-url/recipes');
      // return (response.data as List)
      //     .map((json) => Recipe.fromJson(json))
      //     .toList();
    } catch (e) {
      throw Exception('Error al cargar las recetas: $e');
    }
  }

  Future<List<String>> getCountries() async {
    try {
      // Simulando una llamada a API
      await Future.delayed(const Duration(milliseconds: 500));
      return RecipeRepository.getCountries();

      // Cuando tengas una API real:
      // final response = await _dio.get('tu-api-url/countries');
      // return List<String>.from(response.data);
    } catch (e) {
      throw Exception('Error al cargar los países: $e');
    }
  }

  Future<List<Recipe>> getRecipesByCountry(String country) async {
    try {
      // Simulando una llamada a API
      await Future.delayed(const Duration(milliseconds: 600));
      return RecipeRepository.getRecipesByCountry(country);

      // Cuando tengas una API real:
      // final response = await _dio.get('tu-api-url/recipes',
      //   queryParameters: {'country': country}
      // );
      // return (response.data as List)
      //     .map((json) => Recipe.fromJson(json))
      //     .toList();
    } catch (e) {
      throw Exception('Error al cargar las recetas del país: $e');
    }
  }
}
