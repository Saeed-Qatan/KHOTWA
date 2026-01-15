// lib/repository/forget_repo.dart


import 'package:khotwa/data/services/auth/forget_service.dart';
import 'package:khotwa/model/auth/forget_model.dart';

class ForgetRepo {
  final ForgetService _service = ForgetService();

  Future<void> forgetPassword(ForgetModel model) async {
    await _service.forgetPassword(model);
  }
}
