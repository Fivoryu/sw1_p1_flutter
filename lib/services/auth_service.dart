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
}
