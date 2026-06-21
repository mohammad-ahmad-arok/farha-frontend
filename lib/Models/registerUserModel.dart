import 'dart:convert';

class RegisterUserModel {
  String first_name;
  String last_name;
  String email;
  String username;
  String password;
  String mobile_phone;
  String gender;
  String birthdate;

  RegisterUserModel({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.username,
    required this.password,
    required this.mobile_phone,
    required this.gender,
    required this.birthdate,
  });

  // تحويل من Object إلى Map لإرساله في طلب الـ POST للـ API
  Map<String, dynamic> toJson() => {
    "first_name": first_name,
    "last_name": last_name,
    "email": email,
    "username": username,
    "password": password,
    "mobile_phone": mobile_phone,
    "gender": gender,
    "birthdate": birthdate,
  };

  // ملاحظة: عادة في موديلات الـ Register لا نحتاج factory fromJson
  // لأننا نحن من ننشئ الكائن ونرسله، لكن تركته لك في حال أردت استخدامه لاحقاً.
  factory RegisterUserModel.fromJson(Map<String, dynamic> json) => RegisterUserModel(
    first_name: json["first_name"] ?? "",
    last_name: json["last_name"] ?? "",
    email: json["email"] ?? "",
    username: json["username"] ?? "",
    password: json["password"] ?? "",
    mobile_phone: json["mobile_phone"] ?? "",
    gender: json["gender"] ?? "",
    birthdate: json["birthdate"] ?? "",
  );
}