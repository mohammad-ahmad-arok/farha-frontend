import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ProfileResponseModel.dart';
import '../Models/ResetPasswordRequest.dart';
import '../Shared/sharedPreferences.dart';

class ProfileApi {
  static const String baseUrl = "https://farha.onrender.com/api/auth/";

  static Future<Map<String, String>> _getHeaders() async {
    String? token = await StorageService.getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  static Future<ProfileResponseModel?> getProfile() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('${baseUrl}profile'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return ProfileResponseModel.fromJson(jsonResponse);
      } else {
        print("❌ فشل جلب البروفايل: ${response.statusCode}");
        print("الرد: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ خطأ في الاتصال: $e");
      return null;
    }
  }
  static Future<ProfileResponseModel?> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    String? gender,
    String? mobilePhone,
    String? birthdate,
    String? username,
  }) async {
    try {
      final headers = await _getHeaders();
      // 💡 هذان السطران هما مفتاح الحل
      headers['Content-Type'] = 'application/json';
      headers['Accept'] = 'application/json';

      Map<String, dynamic> body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'gender': gender,
        'mobile_phone': mobilePhone,
        'birthdate': birthdate,
        'username': username,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/profile'),
        headers: headers,
        body: json.encode(body), // تشفير البيانات كـ JSON
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProfileResponseModel.fromJson(json.decode(response.body));
      } else {
        // إذا لم ينجح، سيطبع السيرفر هنا سبب الرفض (مثلاً الإيميل مستخدم)
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
  static Future<ProfileResponseModel?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // الحصول على التوكن من StorageService
      final token = await StorageService.getToken();
      if (token == null) {
        print('❌ لم يتم العثور على توكن');
        return null;
      }

      final url = Uri.parse('$baseUrl/change-password'); // تأكد من صحة المسار
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,  // تم التعديل هنا
          'newPassword': newPassword,          // تم التعديل هنا
        }),
      );

      print('🔵 Request body: ${jsonEncode({'currentPassword': currentPassword, 'newPassword': newPassword})}');
      print('🔵 Response status: ${response.statusCode}');
      print('🔵 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProfileResponseModel.fromJson(jsonDecode(response.body));
      } else {
        print('❌ خطأ: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('🔥 استثناء: $e');
      return null;
    }
  }
  static Future<ProfileResponseModel?> uploadProfileImage(File imageFile) async {
    try {
      // أنشئ طلب متعدد الأجزاء
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload-profile-picture'), // عدل المسار حسب API الخاص بك
      );

      // أضف ملف الصورة
      request.files.add(
        await http.MultipartFile.fromPath(
          'picture', // اسم الحقل الذي يتوقعه السيرفر
          imageFile.path,
        ),
      );

      String? token = await StorageService.getToken(); // استدع دالة لجلب التوكن
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // أرسل الطلب
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // حول الاستجابة إلى JSON
        var jsonData = jsonDecode(response.body);
        return ProfileResponseModel.fromJson(jsonData);
      } else {
        print('خطأ في رفع الصورة: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('استثناء في رفع الصورة: $e');
      return null;
    }
  }
}


final profileApi = ProfileApi(); // كائن واحد للاستخدام في كل مكان