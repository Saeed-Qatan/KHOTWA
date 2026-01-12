import 'package:khotwa/core/constants/api_constants.dart';
import 'package:khotwa/core/storage/api_storage.dart';

class LoginServices {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> login(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final response = await _apiClient.post(ApiConstants.login, {
      'email': email,
      'password': password,
    });
    return response;
  }

  Future<Map<String, dynamic>> loginWithGoogle(String idToken) async {
    final response = await _apiClient.post(ApiConstants.loginWithGoogle, {
      'idToken': idToken,
    });
    return response;
  }
}
