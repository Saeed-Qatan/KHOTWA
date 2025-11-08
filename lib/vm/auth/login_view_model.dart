import 'package:flutter/material.dart';
import 'package:khotwa/data/services/auth/login_services.dart';
import 'package:khotwa/model/auth/login_model.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginModel loginData = LoginModel(email: '', password: '', rememberMe: false);

  final LoginServices _loginServices = LoginServices();
  bool isLoaded = false;
  bool obscurePassword = true;

  String errorMessage = '';

  bool get canLogin =>
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      !isLoaded;

  bool get _isLoaded => isLoaded;

  void toggleRememberMe(bool value) {
    loginData.rememberMe = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "حقل البريد الإلكتروني مطلوب";
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return "الرجاء إدخال بريد إلكتروني صحيح";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "حقل كلمة المرور مطلوب";
    if (value.length < 6) return "يجب أن تكون كلمة المرور 6 أحرف على الأقل";
    return null;
  }

  Future<bool> login() async {
    loginData.email = emailController.text.trim();
    loginData.password = passwordController.text.trim();

    // Validation
    if (emailValidator(loginData.email) != null) {
      errorMessage = emailValidator(loginData.email)!;
      notifyListeners();
      return false;
    }
    if (passwordValidator(loginData.password) != null) {
      errorMessage = 'Password must be at least 6 characters';
      notifyListeners();
      return false;
    }

    isLoaded = true;
    errorMessage = '';
    notifyListeners();

    try {
      // The service returns a Map<String, dynamic>, so capture it and interpret the result.
      final Map<String, dynamic> response = await _loginServices.login(
        loginData.email,
        loginData.password,
        loginData.rememberMe,
      );

      // Determine success from common response patterns: 'success' or 'status' or presence of 'token'
      final bool success =
          (response['success'] == true) ||
          (response['status'] == true) ||
          (response['token'] != null);

      if (success) {
        errorMessage = '';
      } else {
        errorMessage =
            response['message']?.toString() ??
            'Login failed. Check your credentials.';
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoaded = false;
      notifyListeners();
    }

    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
