import 'dart:io';

import 'package:khotwa/core/constants/api_constants.dart';
import 'package:khotwa/core/storage/api_storage.dart';

class RegisterServices {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> register_info(
  String firstName,
  String fatherName,
  String familyName,
  String email,
  String phone,
  String password,
  String confirmPassword,
    File? profileImage,
  File? cvFile,
  List<String> skills,
  

  ) async {
    final response = await _apiClient.post(ApiConstants.register, {
      'email': email,
      'password': password,
      "confirmPassword": confirmPassword,
      'firstName': firstName,
      'fatherName': fatherName,
      'familyName': familyName,
      'phoneNumber': phone,
      'profileImage': profileImage,
      'cvFile': cvFile,
      'skills': skills,
      
    });
    return response;
  }
  Future<Map<String, dynamic>> register_info_delete(
   String firstName,
  String fatherName,
  String familyName,
  String email,
  String phone,
  String password,
  String confirmPassword,
    File? profileImage,
  File? cvFile,
  List<String> skills,
  ) async {
    final response = await _apiClient.delete(ApiConstants.register);
    return response;
  }
  Future<Map<String, dynamic>> register_info_update(
    String firstName,
  String fatherName,
  String familyName,
  String email,
  String phone,
  String password,
  String confirmPassword,
    File? profileImage,
  File? cvFile,
  List<String> skills,
  ) async {
    final response = await _apiClient.put(ApiConstants.register, {
        'email': email,
      'password': password,
      "confirmPassword": confirmPassword,
      'firstName': firstName,
      'fatherName': fatherName,
      'familyName': familyName,
      'phoneNumber': phone,
      'profileImage': profileImage,
      'cvFile': cvFile,
      'skills': skills,
    });
    return response;
  }
}
