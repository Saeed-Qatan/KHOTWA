// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:khotwa/core/navigations/navigations.dart';
import 'package:khotwa/model/auth/register_data_model.dart';
import 'package:provider/provider.dart';
import 'package:khotwa/view/auth/register_photo_page.dart';
import 'package:khotwa/view/auth/login_page.dart';


class RegisterInfoViewModel with ChangeNotifier {
  // --- Controllers ---
  final TextEditingController firstName_controller = TextEditingController();
  final TextEditingController fatherName_controller = TextEditingController();
  final TextEditingController familyName_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController phone_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();
  final TextEditingController confirm_password_controller =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obscure_password = true;
  bool _obscure_confirm_password = true;
  bool _isLoading = false;
  String? _errorMessage;

  bool get obscure_password => _obscure_password;
  bool get obscure_confirm_password => _obscure_confirm_password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String? notEmptyValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "حقل $fieldName مطلوب";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "حقل البريد الإلكتروني مطلوب";
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return "الرجاء إدخال بريد إلكتروني صحيح";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "حقل كلمة المرور مطلوب";
    }
    if (value.length < 6) {
      return "يجب أن تكون كلمة المرور 6 أحرف على الأقل";
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "حقل تأكيد كلمة المرور مطلوب";
    }
    if (value != password_controller.text) {
      return "كلمتا المرور غير متطابقتين";
    }
    return null;
  }

  void togglePasswordVisibility() {
    _obscure_password = !_obscure_password;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscure_confirm_password = !_obscure_confirm_password;
    notifyListeners();
  }

  Future<void> onContinuePressed(BuildContext context) async {
    _errorMessage = null;
    notifyListeners();

    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final registerData = Provider.of<RegisterDataModel>(context, listen: false);

    registerData.updateBasicInfo(
      firstName: firstName_controller.text.trim(),
      fatherName: fatherName_controller.text.trim(),
      familyName: familyName_controller.text.trim(),
      email: email_controller.text.trim(),
      phone: phone_controller.text.trim(),
      password: password_controller.text,
    );

    _isLoading = false;
    notifyListeners();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (newContext) => ChangeNotifierProvider.value(
              value: registerData,
              child: const RegisterPhotoPage(),
            ),
      ),
    );
  }

  void onLoginPressed(BuildContext context) {
    AppNavigation.push(context, const LoginPage());
  }

  @override
  void dispose() {
    firstName_controller.dispose();
    fatherName_controller.dispose();
    familyName_controller.dispose();
    email_controller.dispose();
    phone_controller.dispose();
    password_controller.dispose();
    confirm_password_controller.dispose();
    super.dispose();
  }
}
