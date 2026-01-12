import 'package:khotwa/data/services/auth/login_services.dart';
import 'package:khotwa/core/storage/loacal_storage.dart';

class LoginRepo {
  final LoginServices _loginServices = LoginServices();
  final LoacalStorage _loacalStorage = LoacalStorage();

  Future<Map<String, dynamic>> login(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final response = await _loginServices.login(email, password, rememberMe);

    // Check for token in response and save it if present
    // Adjust the key 'token' based on your actual API response structure
    if (response.containsKey('token') && response['token'] != null) {
      await _loacalStorage.saveString('token', response['token']);
    }

    // Also save user data if needed, or other flags
    if (rememberMe) {
      await _loacalStorage.saveString('email', email);
    }

    return response;
  }

  Future<Map<String, dynamic>> loginWithGoogle(String idToken) async {
    final response = await _loginServices.loginWithGoogle(idToken);

    if (response.containsKey('token') && response['token'] != null) {
      await _loacalStorage.saveString('token', response['token']);
    }

    return response;
  }
}
