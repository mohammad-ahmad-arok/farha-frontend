import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/LoginResponseModel.dart';
import '../Models/OtpResponseModel.dart';
import '../Models/registerUserModel.dart';


class authApi {

  static const String baseUrl = "https://farha.onrender.com/api/auth/";
  ///////////sing up && sign in && OTP/////////////
  static Future<LoginResponseModel?> registerUser(RegisterUserModel user) async {
    final url = Uri.parse("${baseUrl}register/");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "Accept": "application/json"},
        body: jsonEncode(user.toJson()),
      ).timeout(const Duration(seconds: 60)); // أضفنا وقت انتظار دقيقة كاملة لـ Render

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // نتحقق إذا كان الرد فعلاً JSON قبل التحويل
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("خطأ في الـ API: $e"); // هذا السطر سيخبرك في الـ Debug Console ما المشكلة
      return null;
    }
  }
  static Future<LoginResponseModel?> login(String identifier, String password) async {
    final url = Uri.parse("${baseUrl}login/");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "emailOrUsername": identifier, // تأكد أن الاسم مطابق تماماً للسيرفر
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(jsonDecode(response.body));
      } else {
        return LoginResponseModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Login Exception: $e");
      return null;
    }
  }
  Future<OtpResponseModel> sendOtp(String identifier) async {
    final response = await http.post(
      Uri.parse("${baseUrl}send-otp"), // استخدم الرابط الصحيح
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return OtpResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send OTP');
    }
  }}
