import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class AuthInteractor {
  final String baseUrl;

  final logger = Logger();

  AuthInteractor({required this.baseUrl});

  Future<String> register(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Username': username,
        'Email': email,
        'Password': password,
      }),
    );

    logger.d(response.body);

    if (response.statusCode == 201) {
      logger.i('Registration successful');
      return login(email, password);
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': email,
        'Password': password,
      }),
    );

    logger.d(response.body);

    if (response.statusCode == 200) {
      logger.i('Login successful');
      return response.body;
    } else {
      throw Exception('Failed to login');
    }
  }
}
