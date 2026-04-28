import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService({required this.baseUrl});

  final String baseUrl;

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode >= 400) {
      throw Exception('Credenciales inválidas');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> forgotPassword({
    required String identifier,
    String? empresa,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/password/forgot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': identifier,
        'empresa': (empresa == null || empresa.trim().isEmpty) ? null : empresa.trim(),
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception('No se pudo generar el token');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> registerClient({
    required String username,
    required String email,
    required String password,
    required String empresa,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/register-client'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'empresa': empresa,
      }),
    );

    if (response.statusCode >= 400) {
      final body = jsonDecode(response.body);
      throw Exception(body is Map && body['message'] != null
          ? body['message'].toString()
          : 'No se pudo crear la cuenta');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/password/reset'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'newPassword': newPassword}),
    );

    if (response.statusCode >= 400) {
      final body = jsonDecode(response.body);
      throw Exception(body is Map && body['message'] != null
          ? body['message'].toString()
          : 'No se pudo actualizar la contraseña');
    }
  }
}
