import 'dart:convert';

import 'package:khotwa/core/constants/api_constants.dart';

import 'package:http/http.dart' as http;


class LoginServices {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
    final response = await http.post(
      url,
      body: {
        jsonEncode({'email': email, 'password': password}),
      },
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
