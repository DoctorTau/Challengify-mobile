import 'package:challengify_app/src/models/DataTransferObject/challenge_creation_dto.dart';
import 'package:challengify_app/src/models/DataTransferObject/result_create_dto.dart';
import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChallengeInteractor {
  final String baseUrl;

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
    final response = await http.get(Uri.parse('$baseUrl/api/challenge/user'));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Challenge.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load user challenges');
    }
  }

  Future<List<Result>> getChallengeResults(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/challenge/$id/results'));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Result.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load challenge results');
    }
  }

  Future<Result> getResult(int resultId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/challenge/get-result/$resultId'));

    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load result');
    }
  }

  Future<Challenge> addParticipant(int id) async {
    final response = await http.put(Uri.parse('$baseUrl/api/challenge/$id/add-participant'));

    if (response.statusCode == 200) {
      return Challenge.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add participant');
    }
  }

  Future<Result> addResult(int id, ResultCreateRequestDto result) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/challenge/$id/add-result'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(result.toJson()),
    );

    if (response.statusCode == 201) {
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add result');
    }
  }
}