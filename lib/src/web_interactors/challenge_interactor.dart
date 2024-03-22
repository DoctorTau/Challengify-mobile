import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:challengify_app/src/models/DataTransferObject/challenge_creation_dto.dart';
import 'package:challengify_app/src/models/DataTransferObject/result_create_dto.dart';
import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class ChallengeInteractor {
  final String baseUrl;
  final _logger = Logger();

  ChallengeInteractor({required this.baseUrl});

  Future<Challenge> getChallengeById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/challenge/$id'));

    if (response.statusCode == 200) {
      return Challenge.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load challenge');
    }
  }

  Future<Challenge> createChallenge(ChallengeCreationDto challenge) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/challenge/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(challenge.toJson()),
    );

    if (response.statusCode == 201) {
      return Challenge.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create challenge');
    }
  }

  Future<List<Challenge>> getUserChallenges() async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');

    final response = await http.get(
      Uri.parse('$baseUrl/api/challenge/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
    );

    _logger.d('Response code: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<dynamic> challengesJson = body['\$values'];

      _logger.i('User challenges loaded successfully');
      return challengesJson.map((model) => Challenge.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load user challenges');
    }
  }

  Future<List<Result>> getChallengeResults(int id) async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');

    final response = await http.get(
      Uri.parse('$baseUrl/api/challenge/$id/results'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
    );

    _logger.d('Response code: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<dynamic> challengesJson = body['\$values'];

      _logger.i('Results loaded successfully');
      return challengesJson.map((model) => Result.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load user challenges');
    }
  }

  Future<Result> getResult(int resultId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/challenge/get-result/$resultId'));

    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load result');
    }
  }

  Future<Challenge> addParticipant(int id) async {
    final response =
        await http.put(Uri.parse('$baseUrl/api/challenge/$id/add-participant'));

    if (response.statusCode == 200) {
      return Challenge.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add participant');
    }
  }

  Future<Result> addResult(int id, ResultCreateRequestDto result) async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');

    final response = await http.put(
      Uri.parse('$baseUrl/api/challenge/$id/add-result'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(result.toJson()),
    );

    _logger.d('Response code: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');

    if (response.statusCode == 201) {
      _logger.i('Result added successfully');
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add result');
    }
  }
}
