// lib/vm/forget_view_model.dart
import 'package:flutter/material.dart';
import 'package:khotwa/data/repostitories/auth/forget_repo.dart';
import 'package:khotwa/model/auth/forget_model.dart';

enum ForgetState { idle, loading, success, error }

class ForgetViewModel extends ChangeNotifier {
  final ForgetRepo _repo = ForgetRepo();
  final emailController = TextEditingController();

  ForgetViewModel() {
    emailController.addListener(notifyListeners);
  }

  ForgetState state = ForgetState.idle;
  String? error;

  bool get isLoading => state == ForgetState.loading;
  bool get canSubmit => emailController.text.trim().isNotEmpty && !isLoading;

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'حقل البريد الإلكتروني مطلوب';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  Future<void> submit() async {
    final email = emailController.text.trim();
    final validationError = _validateEmail(email);

    if (validationError != null) {
      error = validationError;
      state = ForgetState.error;
      notifyListeners();
      return;
    }

    state = ForgetState.loading;
    error = null;
    notifyListeners();

    try {
      await _repo.forgetPassword(ForgetModel(email: email));
      state = ForgetState.success;
    } catch (e) {
      error = e.toString();
      state = ForgetState.error;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    emailController.removeListener(notifyListeners);
    emailController.dispose();
    super.dispose();
  }
}
