// supplier_model.dart
class Supplier {
  final String id;
  final String arName;
  final String enName;
  final String mobile;
  final String address;
  final String email;
  final String website;
  final String facebookAcc;
  final String xAcc;
  final String instagramAcc;
  final String whatsappAcc;
  final String telegramAcc;
  final String picture;
  final String logo;
  final String statue;

  Supplier({
    required this.id,
    required this.arName,
    required this.enName,
    required this.mobile,
    required this.address,
    required this.email,
    required this.website,
    required this.facebookAcc,
    required this.xAcc,
    required this.instagramAcc,
    required this.whatsappAcc,
    required this.telegramAcc,
    required this.picture,
    required this.logo,
    required this.statue,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'].toString(),
      arName: json['arName'] ?? '',
      enName: json['enName'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      facebookAcc: json['facebookAcc'] ?? '',
      xAcc: json['xAcc'] ?? '',
      instagramAcc: json['instagramAcc'] ?? '',
      whatsappAcc: json['whatsappAcc'] ?? '',
      telegramAcc: json['telegramAcc'] ?? '',
      picture: json['picture'] ?? '',
      logo: json['logo'] ?? '',
      statue: json['statue'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arName': arName,
      'enName': enName,
      'mobile': mobile,
      'address': address,
      'email': email,
      'website': website,
      'facebookAcc': facebookAcc,
      'xAcc': xAcc,
      'instagramAcc': instagramAcc,
      'whatsappAcc': whatsappAcc,
      'telegramAcc': telegramAcc,
      'picture': picture,
      'logo': logo,
      'statue': statue,
    };
  }
}

// إضافة SupplierResponse
class SupplierResponse {
  final bool success;
  final String message;
  final List<Supplier> data;

  SupplierResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SupplierResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<Supplier> suppliers = list.map((i) => Supplier.fromJson(i)).toList();

    return SupplierResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: suppliers,
    );
  }
}