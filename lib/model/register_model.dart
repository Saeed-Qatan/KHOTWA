import 'dart:convert';

List<RegisterModel> AuthModelFromJson(String str) =>
    List<RegisterModel>.from(json.decode(str).map((x) => RegisterModel.fromJson(x)));

String AuthModelsToJson(List<RegisterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterModel {
  
  final String email;
  final int password;
  final int confirmPassword;
  final String firstName;
  final String fatherName;
  final String familyName;
  final int phoneNumber;

  RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.fatherName,
    required this.familyName,
    required this.phoneNumber,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
    firstName: json["firstName"],
    fatherName: json["fatherName"],
    familyName: json["familyName"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {"email": email, "password": password,
    "confirmPassword": confirmPassword,
    "firstName": firstName,
    "fatherName": fatherName,
    "familyName": familyName,
    "phoneNumber": phoneNumber,
  };
}
