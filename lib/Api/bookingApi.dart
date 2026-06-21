import 'dart:convert';
import 'package:http/http.dart' as http;

// 1. استيراد الموديل (تأكد من صحة المسار لديك)
import '../Models/BookingModel.dart';
import '../Shared/sharedPreferences.dart';
// 2. استيراد ملف التخزين لجلب التوكن

class EventService {
  final String baseUrl = "https://farha.onrender.com";

  Future<bool> sendEventItem(EventItemModel item) async {
    try {
      // 3. جلب التوكن من الشيرد بريفرنسز عبر السيرفس الخاصة بك
      String? token = await StorageService.getToken();

      // 4. التحقق من وجود التوكن قبل إرسال الطلب
      if (token == null || token.isEmpty) {
        print("خطأ: لم يتم العثور على توكن. يجب تسجيل الدخول أولاً.");
        return false;
      }

      final response = await http.post(
        Uri.parse("$baseUrl/api/bookings"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          // 5. إرسال التوكن بصيغة Bearer Token
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(item.toJson()),
      );

      // طباعة النتيجة للمساعدة في التصحيح (Debugging)
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // إرجاع نجاح العملية إذا كان الكود 200 أو 201
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Exception Error in sendEventItem: $e");
      return false;
    }
  }
}