import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import '../Controllers/profileController.dart';
import '../Models/LoginResponseModel.dart';
import '../Models/OtpResponseModel.dart';
import '../Models/ProfileResponseModel.dart';
import '../Models/registerUserModel.dart';


class authApi {
  var registeredUser = Rxn<ProfileResponseModel>(); // مودل المستخدم
  static const String baseUrl = "https://farha.onrender.com/api/auth/";
  ///////////sing up && sign in && OTP/////////////
  static Future<LoginResponseModel?> registerUser(RegisterUserModel user) async {
    final url = Uri.parse("${baseUrl}register/");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "Accept": "application/json"},
        body: jsonEncode(user.toJson()),
      ).timeout(const Duration(seconds: 60));

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // 1. استخراج بيانات المستخدم وتحديث الكنترولر المسؤول عن البروفايل فوراً
        if (responseData['user'] != null) {
          final userData = ProfileData.fromJson(responseData['user']);
          // تحديث الـ ProfileController بالبيانات الجديدة
          Get.find<ProfileController>().profile.value = userData;
        }

        // 2. إرجاع مودل اللوغ إن (الذي يحتوي عادةً على التوكن)
        return LoginResponseModel.fromJson(responseData);
      } else {
        return null;
      }
    } catch (e) {
      print("خطأ في الـ API: $e");
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
  }
}
