import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userEmailKey = 'user_email';

  // Simula un login - En un entorno real, esto se conectaría a un API
  Future<bool> login(String email, String password) async {
    try {
      // Aquí iría la lógica de autenticación real con un servicio backend
      // Por ahora, simularemos una autenticación exitosa con cualquier email válido
      // y contraseña de más de 6 caracteres
      
      if (email.contains('@') && email.contains('.') && password.length >= 6) {
        // Simulamos un delay de red
        await Future.delayed(const Duration(seconds: 1));
        
        // Guardamos el token ficticio y el email del usuario
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, 'fake_token_${DateTime.now().millisecondsSinceEpoch}');
        await prefs.setString(_userEmailKey, email);
        
        return true;
      }
      return false;
    } catch (e) {
      print('Error de autenticación: $e');
      return false;
    }
  }

  // Verifica si el usuario está autenticado
  Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      return token != null;
    } catch (e) {
      return false;
    }
  }

  // Obtiene el email del usuario autenticado
  Future<String?> getUserEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userEmailKey);
    } catch (e) {
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

  // Registrar un nuevo usuario - simulado
  Future<bool> register(String email, String password) async {
    try {
      // Aquí iría la lógica de registro real
      // Por ahora, simularemos un registro exitoso
      
      if (email.contains('@') && email.contains('.') && password.length >= 6) {
        await Future.delayed(const Duration(seconds: 1));
        
        // Simulamos el registro guardando directamente las credenciales
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, 'fake_token_${DateTime.now().millisecondsSinceEpoch}');
        await prefs.setString(_userEmailKey, email);
        
        return true;
      }
      return false;
    } catch (e) {
      print('Error de registro: $e');
      return false;
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
