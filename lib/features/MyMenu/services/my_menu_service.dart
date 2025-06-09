import 'package:food_diet/core/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMenuService {
  final api = ApiService();

  Future<List<Map<String, dynamic>>> getSavedFoods(String category) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('userId');

      if (userId == null) {
        throw Exception('User ID no encontrado');
      }

      final response = await api.dio.get('/recipes/category/$userId/$category');

      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      print('Error al generar recetas: $e');
      return [];
    }
  }

  Future<String> deleteRecipeById(String id) async {
    try {
      final response = await api.dio.delete('/recipes/$id');
      return response.data?['message'] ?? 'Eliminado ';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateRecipeById(String id, Map<String, dynamic> data) async {
    try {
      final response = await api.dio.patch('/recipes/$id', data: data);
      return response.data?['message'] ?? 'Editado ';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createRecipe(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('userId');

      if (userId == null) {
        throw Exception('User ID no encontrado');
      }
      final response = await api.dio.post(
        '/recipes',
        data: {...data, 'userId': userId},
      );
      return response.data?['message'] ?? 'Editado ';
    } catch (e) {
      rethrow;
    }
  }
}
