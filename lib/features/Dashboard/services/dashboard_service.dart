import 'package:food_diet/core/api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodService {
  final api = ApiService();
  final Box _box = Hive.box('recipesBox');

  Future<void> hasPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final int? userId = prefs.getInt('userId');
      if (userId == null) {
        throw Exception('User ID no encontrado');
      }
      final response = await api.dio.get('/profiles/hasPreference/$userId');
      await prefs.setBool('hasDiet', response.data == 'true');
    } catch (e) {
      print('Error al verificar preferencias: $e');
      await prefs.setBool('hasDiet', false);
    }
  }

  Future<List<Map<String, dynamic>>> generateRecipesForUser({
    bool forceRefresh = false,
  }) async {
    final String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final cachedDate = _box.get('date');
    final cachedRecipes = _box.get('recipes');

    if (!forceRefresh && cachedDate == todayStr && cachedRecipes != null) {
      final List<dynamic> listDynamic = cachedRecipes;
      final List<Map<String, dynamic>> recipes =
          List<Map<String, dynamic>>.from(
            listDynamic.map((e) => Map<String, dynamic>.from(e)),
          );
      return recipes;
    }

    final List<String> categories = [
      'desayuno',
      'almuerzo',
      'cena',
      'merienda',
    ];
    final List<Map<String, dynamic>> recipes = [];

    try {
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('userId');

      if (userId == null) {
        throw Exception('User ID no encontrado');
      }

      final futures =
          categories.map((category) async {
            final response = await api.dio.post(
              '/recipes/generate/user/$userId/$category',
            );
            return response.data as Map<String, dynamic>;
          }).toList();

      final results = await Future.wait(futures);

      recipes.addAll(results);

      await _box.put('date', todayStr);
      await _box.put('recipes', recipes);

      return recipes;
    } catch (e) {
      print('Error al generar recetas: $e');
      return [];
    }
  }
}
