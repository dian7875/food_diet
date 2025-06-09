import 'package:dio/dio.dart';
import 'package:food_diet/core/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietService {
  final api = ApiService();
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://tu-api.com'));

  Future<String> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      final response = await api.dio.patch(
        '/profiles/user/$userId',
        data: profileData,
      );
      await prefs.setBool('hasDiet', true);
      print(prefs.getBool('hasDiet'));

      return response.data?['message'] ?? 'Actualización completada';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCondition(Map<String, dynamic> conditionData) async {
    await _dio.put('/condiciones', data: conditionData);
  }

  Future<void> deleteCondition(int conditionId) async {
    await _dio.delete('https://tu-api.com/conditions/$conditionId');
  }

  Future<void> deleteRecipeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print('Receta con ID $id eliminada correctamente');
  }

  Future<void> updateRecipeById(String id, Map<String, dynamic> data) async {
    print('🔄 Editando receta con ID: $id');
    print('📦 Datos enviados:');
    print(data);
  }

  Future<String> createRecipe(Map<String, dynamic> data) async {
    print('🆕 Creando receta con los siguientes datos:');
    print(data);
    return 'si';
  }
}
