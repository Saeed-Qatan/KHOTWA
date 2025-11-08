import 'dart:convert';

List<LoginModel> LoginModelFromJson(String str) =>
    List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String LoginModelsToJson(List<LoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  String email;
  String password;
  bool rememberMe;

  LoginModel({required this.email, required this.password, required this.rememberMe});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
      rememberMe: json['rememberMe'] ?? false,
    );
  }
 

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'rememberMe': rememberMe,
    };
  }
}
