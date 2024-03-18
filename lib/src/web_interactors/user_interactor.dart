import 'package:challengify_app/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInteractor {
  final String baseUrl;

  UserInteractor({required this.baseUrl});

  Future<User> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/user/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
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