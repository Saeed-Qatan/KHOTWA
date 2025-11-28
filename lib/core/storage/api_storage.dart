import 'dart:convert';
import 'package:khotwa/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiClient {
  final String baseUrl = ApiConstants.baseUrl;

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final r = await http.get(
      url,
      headers: {'Content-Type': 'application/json', ...?headers},
    );

    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final r = await http.post(
      url,
      headers: {'Content-Type': 'application/json', ...?headers},
      body: jsonEncode(body),
    );

    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final r = await http.put(
      url,
      headers: {'Content-Type': 'application/json', ...?headers},
      body: jsonEncode(body),
    );

    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final r = await http.delete(
      url,
      headers: {'Content-Type': 'application/json', ...?headers},
    );

    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> uploadFile(
    String endpoint,
    File file, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final request = http.MultipartRequest('POST', url);

    request.headers.addAll({...?headers});

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final streamed = await request.send();
    final r = await http.Response.fromStream(streamed);

    return jsonDecode(r.body);
  }
}
