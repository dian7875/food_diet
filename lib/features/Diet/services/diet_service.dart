import 'package:food_diet/core/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietService {
  final api = ApiService();

  Future<String> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      final response = await api.dio.patch(
        '/profiles/user/$userId',
        data: profileData,
      );
      await prefs.setBool('hasDiet', true);

      return response.data?['message'] ?? 'Actualización completada';
    } catch (e) {
      rethrow;
    }
  }
}
