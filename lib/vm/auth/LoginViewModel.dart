import 'package:flutter/material.dart';
import 'package:khotwa/view/HomeSreen.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool isLoading = false;
  bool rememberMe = false;
  String? errorMessage;

  bool get canLogin =>
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      !isLoading;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
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

  Future<void> onLoginPressed(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email == emailController.text.trim() && password == passwordController.text) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ تسجيل الدخول ناجح!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      }
    }
    
    else {
      errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }

    isLoading = false;
    notifyListeners();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }
}
