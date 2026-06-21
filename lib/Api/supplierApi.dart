import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/SupplierModel.dart';

class SupplierApi {
  static const String baseUrl = 'https://your-api.com/api'; // غيّر حسب الرابط الحقيقي

  static Future<List<Supplier>> getSuppliers() async {
    final response = await http.get(Uri.parse('$baseUrl/suppliers'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final supplierResponse = SupplierResponse.fromJson(jsonResponse);
      return supplierResponse.data;
    } else {
      throw Exception('Failed to load suppliers');
    }
  }
}