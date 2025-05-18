import 'package:dio/dio.dart';

class DietService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://tu-api.com'));

  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    print('Enviando perfil:');
    print(profileData);
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
  
    Future<void> createRecipe(Map<String, dynamic> data) async {
    print('🆕 Creando receta con los siguientes datos:');
    print(data);
  }

}
