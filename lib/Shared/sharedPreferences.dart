import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'token';

  // حفظ التوكن عند تسجيل الدخول أو الاشتراك
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // جلب التوكن لاستخدامه في طلبات الـ API
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // حذف التوكن عند تسجيل الخروج
  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // التأكد من أن المستخدم مسجل دخول (اختياري)
  static Future<bool> hasToken() async {
    final String? token = await getToken();
    return token != null && token.isNotEmpty;
  }
  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  // دالة لجلب حالة الدخول (تستخدم في main.dart)
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // دالة لحذف البيانات عند تسجيل الخروج
  static Future<void> clearAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('token'); // احذف التوكن أيضاً
  }
}