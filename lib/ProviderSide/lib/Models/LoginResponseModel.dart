class LoginResponseModel {
  final bool success;
  final String message;
  final LoginData? data;

  LoginResponseModel({required this.success, required this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final UserLoginModel? user;
  final String? token;
  final String? code;  // ✅ add this line

  LoginData({this.user, this.token, this.code}); // ✅ update constructor

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: json['user'] != null ? UserLoginModel.fromJson(json['user']) : null,
      token: json['token'],
      code: json['code'], // ✅ parse the code
    );
  }
}
class UserLoginModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String? role;

  UserLoginModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.role,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      id: json['id'],
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email'] ?? "",
      username: json['username'] ?? "",
      role: json['role'],
    );
  }
}