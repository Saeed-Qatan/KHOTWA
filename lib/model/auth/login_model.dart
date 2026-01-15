class LoginModel {
  String email;
  String password;
  bool rememberMe;

  LoginModel({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
      rememberMe: json['rememberMe'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'rememberMe': rememberMe};
  }
}
