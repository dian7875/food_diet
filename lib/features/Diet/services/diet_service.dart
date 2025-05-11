import 'package:dio/dio.dart';

class DietService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://tu-api.com'));

  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    await _dio.patch('/perfil', data: profileData);
  }

  Future<void> addCondition(Map<String, dynamic> conditionData) async {
    await _dio.put('/condiciones', data: conditionData);
  }

  Future<void> deleteCondition(int conditionId) async {
    await _dio.delete('https://tu-api.com/conditions/$conditionId');
  }
}
