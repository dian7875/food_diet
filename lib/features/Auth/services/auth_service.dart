import 'package:dio/dio.dart';
import 'package:food_diet/core/api_service.dart';
import 'package:food_diet/features/Dashboard/services/dashboard_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final api = ApiService();
  final _dashboardService = FoodService();

  static const String _tokenKey = 'auth_token';
  static const String _userEmailKey = 'user_email';

  Future<String> login(String email, String password) async {
    try {
      final response = await api.dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        final token = response.data['access_token'];
        final userId = response.data['userId'];
        if (token != null && token is String && token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_tokenKey, token);
          await prefs.setInt('userId', userId);
          await prefs.setString(_userEmailKey, email);
          await _dashboardService.hasPreferences();
          return 'Inicio de sesión exitoso';
        } else {
          return 'Token no recibido del servidor';
        }
      } else {
        return 'Credenciales incorrectas';
      }
    } on DioException catch (dioError) {
      final response = dioError.response;
      if (response != null) {
        if (response.statusCode == 401) {
          // Credenciales inválidas
          return response.data['message'] ?? 'Credenciales inválidas';
        } else {
          // Otro tipo de error desde el servidor
          return 'Error del servidor: ${response.statusCode}';
        }
      } else {
        // Sin respuesta: probablemente es un error de red
        print('DioError sin respuesta: ${dioError.message}');
        return 'Error en la conexión: verifica tu red o intenta más tarde';
      }
    }
  }

  // Verifica si el usuario está autenticado
  Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      return token != null && token.isNotEmpty;
    } catch (e) {
      print('Error verificando autenticación: $e');
      return false;
    }
  }

  // Obtiene el email del usuario autenticado
  Future<String?> getUserEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(_userEmailKey);
      return email != null && email.isNotEmpty ? email : null;
    } catch (e) {
      print('Error obteniendo email: $e');
      return null;
    }
  }

  // Cierra la sesión del usuario
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_userEmailKey);
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  Future<String> register(String email, String password) async {
    try {
      final response = await api.dio.post(
        '/auth/register',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        return 'Registro exitoso';
      } else {
        return 'No se pudo registrar el usuario';
      }
    } on DioException catch (dioError) {
      final response = dioError.response;
      if (response != null) {
        if (response.statusCode == 409) {
          // Credenciales inválidas
          return response.data['message'] ?? 'Usuario ya existe.';
        } else {
          // Otro tipo de error desde el servidor
          return 'Error del servidor: ${response.statusCode}';
        }
      } else {
        // Sin respuesta: probablemente es un error de red
        print('DioError sin respuesta: ${dioError.message}');
        return 'Error en la conexión: verifica tu red o intenta más tarde';
      }
    }
  }

  // Restaurar contraseña - simulado
  Future<bool> resetPassword(String email) async {
    try {
      // Aquí iría la lógica para restaurar la contraseña
      // Por ahora, simularemos que se envió un correo

      if (email.contains('@') && email.contains('.')) {
        await Future.delayed(const Duration(seconds: 1));
        return true;
      }
      return false;
    } catch (e) {
      print('Error al restaurar contraseña: $e');
      return false;
    }
  }
}
