import 'dart:convert';

List<LoginModel> LoginModelFromJson(String str) =>
    List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String LoginModelsToJson(List<LoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  String? email;
  String? password;

  LoginModel({this.email, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(email: map['email'], password: map['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
