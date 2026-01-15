// lib/services/forget_service.dart
import 'package:khotwa/core/constants/api_constants.dart';
import 'package:khotwa/core/storage/api_storage.dart';
import 'package:khotwa/model/auth/forget_model.dart';


class ForgetService {
  final ApiClient _apiClient = ApiClient();

  Future<void> forgetPassword(ForgetModel model) async {
    final response = await _apiClient.post(
      ApiConstants.forgetPassword,
      model.toJson(),
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'فشل إرسال رابط استعادة كلمة المرور');
    }
  }
}
