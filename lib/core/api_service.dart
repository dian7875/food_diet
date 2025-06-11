import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio dio;

  factory ApiService() {
    return _instance;
  }
  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.100.107:3000',
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }
}
