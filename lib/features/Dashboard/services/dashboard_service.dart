
import 'package:food_diet/core/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodService {
  final api = ApiService();

  Future<List<Map<String, dynamic>>> generateRecipesForUser() async {
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

      return recipes;
    } catch (e) {
      print('Error al generar recetas: $e');
      return [];
    }
  }
}
