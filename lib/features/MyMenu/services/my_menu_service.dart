import 'package:food_diet/core/api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMenuService {
  final api = ApiService();
  static final _box = Hive.box('favorites');
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

  bool isFavorite(String name) {
    return _box.get(name) == true;
  }

  Future<void> addHiveFavorite(String name) async {
    await _box.put(name, true);
  }

  Future<void> removeHiveFavorite(String name) async {
    await _box.delete(name);
  }

  Future<String> addFavorite(Map<String, dynamic> recipe) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('userId');

      if (userId == null) {
        throw Exception('User ID no encontrado');
      }

      final response = await api.dio.post(
        '/recipes',
        data: {...recipe, 'userId': userId},
      );

      await addHiveFavorite(recipe['name']);

      return response.data?['message'] ?? 'Añadido a favoritos';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(Map<String, dynamic> recipe) async {  
    final name = recipe['name'] as String;

    if (isFavorite(name)) {
      await removeHiveFavorite(name);
    } else {
      await addFavorite(recipe);
    }
  }

  List<String> getAllFavorites() {
    return _box.keys.cast<String>().toList();
  }
}
