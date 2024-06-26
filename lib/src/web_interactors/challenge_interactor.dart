import 'dart:io';

import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:challengify_app/src/models/DataTransferObject/challenge_creation_dto.dart';
import 'package:challengify_app/src/models/DataTransferObject/result_create_dto.dart';
import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:path/path.dart';

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
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');
    final response = await http.post(
      Uri.parse('$baseUrl/api/challenge/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
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
    if (jwt == null) return [];

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
      throw Exception('Failed to load user challenges results');
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

  Future<Challenge> joinChallenge(String joinCode) async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');

    final response = await http.put(
      Uri.parse('$baseUrl/api/challenge/$joinCode/join'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
    );

    _logger.d('Response code: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');

    if (response.statusCode == 200) {
      _logger.i('Challenge joined successfully');
      return Challenge.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Challenge not found');
    } else {
      throw Exception('Failed to join challenge');
    }
  }

  Future<Result> addResult(int id, ResultCreateRequestDto result) async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');

    final uri = Uri.parse('$baseUrl/api/challenge/$id/add-result');
    var request = http.MultipartRequest('PUT', uri)
      ..headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      })
      // Add text fields
      ..fields['Name'] = result.name
      ..fields['Description'] = result.description;

    var response = await http.Response.fromStream(await request.send());

    _logger.d('Response code: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');

    if (response.statusCode == 201) {
      _logger.i('Result added successfully');
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add result');
    }
  }

  Future<Result> addResultWithMedia(
      int id, ResultCreateRequestDto result, File file) async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');

    // Create a multipart request
    final uri = Uri.parse('$baseUrl/api/challenge/$id/add-result');
    var request = http.MultipartRequest('PUT', uri)
      ..headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      })
      // Add text fields
      ..fields['Name'] = result.name
      ..fields['Description'] = result.description
      // Add file
      ..files.add(await http.MultipartFile.fromPath(
        'file', // This should match the name of the param in your API
        file.path,
        filename: basename(file.path), // Optional: to set a custom file name
      ));

    var response = await http.Response.fromStream(await request.send());

    _logger.d('Response code: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');

    if (response.statusCode == 201) {
      _logger.i('Result added successfully');
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add result');
    }
  }

  Future<Result?> getLastUserResult(int challengeId) async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');

    final response = await http.get(
      Uri.parse('$baseUrl/api/challenge/$challengeId/last-result'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
    );

    _logger.d('Response code: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');

    if (response.statusCode == 200) {
      _logger.i('Last result loaded successfully');
      return Result.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 204) {
      _logger.i('No result found');
      return null;
    } else {
      throw Exception('Failed to load last result');
    }
  }
}
