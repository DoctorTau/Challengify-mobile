import 'dart:io';
import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

class FileInteractor {
  final String baseUrl;
  final _logger = Logger();

  FileInteractor({required this.baseUrl});

  Future<void> uploadFile(File file) async {
    final String? jwt = await Storage.readJwt();
    if (jwt == null) throw Exception('No JWT token found');
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/api/FilesController/upload'))
        ..headers.addAll({
          'Authorization': 'Bearer $jwt',
        })
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('image', 'jpeg'),
        ));

      var response = await request.send();

      if (response.statusCode == 200) {
        _logger.i('File uploaded successfully');
      } else {
        _logger.e('Failed to upload file');
      }
    } catch (e) {
      _logger.e('Exception caught: $e');
    }
  }
}
