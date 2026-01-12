import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khotwa/data/repostitories/auth/login_repo.dart';
import 'package:khotwa/model/auth/login_model.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginModel loginData = LoginModel(email: '', password: "", rememberMe: false);

  final LoginRepo _loginRepo = LoginRepo();
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool isLoaded = false;
  bool obscurePassword = true;

  String errorMessage = '';

  bool get canLogin =>
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      !isLoaded;

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
      final Map<String, dynamic> response = await _loginRepo.login(
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

  Future<bool> loginWithGoogle() async {
    _setLoading(true);
    errorMessage = '';
    notifyListeners();

    try {
      // Initialize Google Sign-In (required in v7.2.0+)
      await _googleSignIn.initialize(
        serverClientId:
            "590747616886-qb27mgf3l29bg3iojv7921vra3d7rp6u.apps.googleusercontent.com",
      );

      // Authenticate with Google (replaces signIn() in v7.x)
      final GoogleSignInAccount? account = await _googleSignIn.authenticate();

      if (account == null) {
        // User cancelled the sign-in
        errorMessage = 'تم إلغاء تسجيل الدخول';
        _setLoading(false);
        return false;
      }

      // Get authentication tokens
      final GoogleSignInAuthentication auth = await account.authentication;

      // Get the ID token for backend authentication
      final String? idToken = auth.idToken;

      if (idToken == null) {
        errorMessage = 'فشل الحصول على رمز المصادقة';
        _setLoading(false);
        return false;
      }

      // Send the idToken to your backend for verification and user creation/login
      final Map<String, dynamic> response = await _loginRepo.loginWithGoogle(
        idToken,
      );

      // Determine success from common response patterns
      final bool success =
          (response['success'] == true) ||
          (response['status'] == true) ||
          (response['token'] != null);

      if (success) {
        errorMessage = '';
        debugPrint('Backend Google Sign-In successful!');
      } else {
        errorMessage =
            response['message']?.toString() ?? 'فشل تسجيل الدخول عبر الخادم';
        _setLoading(false);
        return false;
      }

      _setLoading(false);
      return true;
    } catch (e) {
      errorMessage = 'فشل تسجيل الدخول بواسطة Google: ${e.toString()}';
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    isLoaded = value;
    notifyListeners();
  }

  /// Sign out from Google
  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.disconnect();
      debugPrint('Google Sign-Out successful');
    } catch (e) {
      debugPrint('Error signing out from Google: $e');
    }
  }

  /// Attempt silent/lightweight authentication
  Future<GoogleSignInAccount?> attemptSilentGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      return await _googleSignIn.attemptLightweightAuthentication();
    } catch (e) {
      debugPrint('Silent sign-in failed: $e');
      return null;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
