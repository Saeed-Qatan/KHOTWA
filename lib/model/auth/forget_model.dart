// lib/model/forget_model.dart
class ForgetModel {
  final String email;

  ForgetModel({required this.email});

  factory ForgetModel.fromJson(Map<String, dynamic> json) {
    return ForgetModel(email: json['email']);
  }

  Map<String, dynamic> toJson() => {'email': email};
}
