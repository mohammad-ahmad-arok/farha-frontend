class OtpResponseModel {
  final bool success;
  final String message;
  final OtpData? data;

  OtpResponseModel({required this.success, required this.message, this.data});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? OtpData.fromJson(json['data']) : null,
    );
  }
}

class OtpData {
  final String? code;

  OtpData({this.code});

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      code: json['code'],
    );
  }
}