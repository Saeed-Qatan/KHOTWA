import 'dart:io';
import 'package:flutter/material.dart'; // 1. تمت إضافة هذا السطر
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class RegisterDataModel with ChangeNotifier {
  // 2. تمت إضافة "with ChangeNotifier"
  String firstName;
  String fatherName;
  String familyName;
  String email;
  String phone;
  String password;
  File? profileImage;
  File? cvFile;
  List<String> skills;
  String? fieldOfInterest;

  RegisterDataModel({
    this.firstName = '',
    this.fatherName = '',
    this.familyName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.profileImage,
    this.cvFile,
    List<String>? skills,
    this.fieldOfInterest,
  }) : skills = skills ?? [];

  Future<http.MultipartRequest> toMultipartRequest(String apiUri) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUri));

    request.fields['firstName'] = firstName;
    request.fields['fatherName'] = fatherName;
    request.fields['lastName'] = familyName;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['password'] = password;

    for (int i = 0; i < skills.length; i++) {
      request.fields['skills[$i]'] = skills[i];
    }

    if (fieldOfInterest != null) {
      request.fields['fieldOfInterest'] = fieldOfInterest!;
    }

    if (profileImage != null) {
      var stream = http.ByteStream(profileImage!.openRead());
      var length = await profileImage!.length();
      var multipartFile = http.MultipartFile(
        'profileImage',
        stream,
        length,
        filename: path.basename(profileImage!.path),
      );
      request.files.add(multipartFile);
    }

    if (cvFile != null) {
      var stream = http.ByteStream(cvFile!.openRead());
      var length = await cvFile!.length();
      var multipartFile = http.MultipartFile(
        'cvFile',
        stream,
        length,
        filename: path.basename(cvFile!.path),
      );
      request.files.add(multipartFile);
    }

    return request;
  }

  void updateBasicInfo({
    required String firstName,
    required String fatherName,
    required String familyName,
    required String email,
    required String phone,
    required String password,
  }) {
    this.firstName = firstName;
    this.fatherName = fatherName;
    this.familyName = familyName;
    this.email = email;
    this.phone = phone;
    this.password = password;
  }

  void setProfileImage(File? image) {
    profileImage = image;
    notifyListeners();
  }

  void setCVFile(File? file) {
    cvFile = file;
    notifyListeners();
  }

  void addSkill(String skill) {
    skills.add(skill);
    notifyListeners();
  }

  void removeSkill(String skill) {
    skills.remove(skill);
    notifyListeners();
  }

  void setFieldOfInterest(String? field) {
    fieldOfInterest = field;
    notifyListeners();
  }
}
