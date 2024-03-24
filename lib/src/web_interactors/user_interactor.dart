import 'package:challengify_app/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class UserInteractor {
  final String baseUrl;
  final Logger logger = Logger();

  UserInteractor({required this.baseUrl});

  Future<User?> getUser(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/user/$id'));

      logger.i('HTTP response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        logger.d(response.body);
        return User.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      logger.e('Exception caught: $e');
      rethrow;
    }
  }

  Future<void> updateUser(int id, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update user');
    }
  }
}
