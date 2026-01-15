import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khotwa/data/repostitories/auth/login_repo.dart';
import 'package:khotwa/model/auth/login_model.dart';

enum LoginState { idle, loading, success, error }

class LoginViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginState state = LoginState.idle;
  LoginModel loginData = LoginModel(email: '', password: "", rememberMe: false);

  final LoginRepo _loginRepo = LoginRepo();
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool obscurePassword = true;
  String? errorMessage;

  bool get isLoading => state == LoginState.loading;

  bool get canLogin =>
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      !isLoading;

  LoginViewModel() {
    emailController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
  }

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

  Future<void> submit() async {
    loginData.email = emailController.text.trim();
    loginData.password = passwordController.text.trim();

    // Validation
    final emailError = emailValidator(loginData.email);
    if (emailError != null) {
      errorMessage = emailError;
      state = LoginState.error;
      notifyListeners();
      return;
    }

    final passwordError = passwordValidator(loginData.password);
    if (passwordError != null) {
      errorMessage = passwordError;
      state = LoginState.error;
      notifyListeners();
      return;
    }

    state = LoginState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final Map<String, dynamic> response = await _loginRepo.login(
        loginData.email,
        loginData.password,
        loginData.rememberMe,
      );

      final bool success =
          (response['success'] == true) ||
          (response['status'] == true) ||
          (response['token'] != null);

      if (success) {
        state = LoginState.success;
      } else {
        errorMessage =
            response['message']?.toString() ??
            'فشل تسجيل الدخول. تحقق من بيانات الاعتماد.';
        state = LoginState.error;
      }
    } catch (e) {
      errorMessage = e.toString();
      state = LoginState.error;
    }

    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    state = LoginState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _googleSignIn.initialize(
        serverClientId:
            "590747616886-qb27mgf3l29bg3iojv7921vra3d7rp6u.apps.googleusercontent.com",
      );

      final GoogleSignInAccount? account = await _googleSignIn.authenticate();

      if (account == null) {
        errorMessage = 'تم إلغاء تسجيل الدخول';
        state = LoginState.error;
        notifyListeners();
        return;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;

      if (idToken == null) {
        errorMessage = 'فشل الحصول على رمز المصادقة';
        state = LoginState.error;
        notifyListeners();
        return;
      }

      final Map<String, dynamic> response = await _loginRepo.loginWithGoogle(
        idToken,
      );

      final bool success =
          (response['success'] == true) ||
          (response['status'] == true) ||
          (response['token'] != null);

      if (success) {
        state = LoginState.success;
        debugPrint('Backend Google Sign-In successful!');
      } else {
        errorMessage =
            response['message']?.toString() ?? 'فشل تسجيل الدخول عبر الخادم';
        state = LoginState.error;
      }
    } catch (e) {
      errorMessage = 'فشل تسجيل الدخول بواسطة Google: ${e.toString()}';
      state = LoginState.error;
    }

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
    emailController.removeListener(notifyListeners);
    passwordController.removeListener(notifyListeners);
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
