import 'dart:convert';
import 'dart:typed_data';

class JwtDecoder {
  static Map<String, dynamic> decode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String normalized = base64Url.normalize(str);
    Uint8List bytes = base64Url.decode(normalized);
    return utf8.decode(bytes);
  }
}
