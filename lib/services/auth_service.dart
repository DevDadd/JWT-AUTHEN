import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService(_);

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000',
      contentType: 'application/json',
    ),
  );

  static Future<Response> signup(String email, String password) async {
    try {
      final respond = await _dio.post('/todo/register/', data: {
        'username': email,
        'password': password,
      });
      print(respond.data);
      return respond;
    } catch (e) {
      print(e);
      throw Exception("Cannot signup: $e");
    }
  }

  static Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post('/api/token/', data: {
        'username': email,
        'password': password,
      });
      if (response.statusCode == 200 && response.data['access'] != null) {
        final accessToken = response.data['access'];
        final refreshToken = response.data['refresh'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        return response;
      } else {
        throw Exception("Invalid credentials");
      }
    } catch (e) {
      print(e);
      throw Exception("Cannot login: $e");
    }
  }

  static Future<void> setAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token == null) return false;

    try {
      await setAuthToken();
      final res = await _dio.get('/todo/protected/');
      return res.statusCode == 200;
    } catch (e) {
      print('Login check failed: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    _dio.options.headers.remove('Authorization');
  }
}
