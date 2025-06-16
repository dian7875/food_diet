import 'package:food_diet/core/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final api = ApiService();

Future<Map<String, dynamic>> getProfile() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final response = await api.dio.get('/profiles/user/$userId');
    return response.data; 
  } catch (e) {
    rethrow;
  }
}


}
