
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'token';

  // حفظ التوكن
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // جلب التوكن
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // حذف التوكن (تسجيل خروج)
  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}