import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://localhost/khalesni/api';
 
  // Register API Call
  Future<Map<String, dynamic>> registerUser(String email, String password, String username) async {
    final url = Uri.parse('$baseUrl/register.php');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
        'username': username,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  // Login API Call
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/login.php');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
