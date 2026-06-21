import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/EventModel.dart'; // تأكد أن هذا الملف يحتوي على كلاس EventResponse أيضاً

class EventApi {
  static const String baseUrl = "http://farha.onrender.com/api";

  // تغيير النوع المرتجع هنا إلى EventResponse
  Future<EventResponse?> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/events"));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // هنا نقوم بتحويل الـ JSON كاملاً إلى كائن EventResponse
        return EventResponse.fromJson(jsonResponse);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}