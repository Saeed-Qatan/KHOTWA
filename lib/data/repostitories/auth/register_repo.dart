import 'dart:io';

import 'package:khotwa/data/services/auth/register_services.dart';
import 'package:khotwa/core/storage/loacal_storage.dart';

class RegisterRepo {
  final RegisterServices _registerServices = RegisterServices();
  final LoacalStorage _loacalStorage = LoacalStorage();

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String confirmPassword,
    String firstName,
    String fatherName,
    String familyName,
    String phoneNumber,
  ) async {
    final response = await _registerServices.register_info(
      firstName,
      fatherName,
      familyName,
      email,
      phoneNumber,
      password,
      confirmPassword,
      null,
      null,
      [],
      
    );
    // Adjust the key 'token' based on your actual API response structure
    if (response.containsKey('token') && response['token'] != null) {
      await _loacalStorage.saveString('token', response['token']);
    }
    return response;
  }
}
