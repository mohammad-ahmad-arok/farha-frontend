// موديل الطلب
class ResetPasswordRequest {
  final String identifier;
  final String code;
  final String newPassword;

  ResetPasswordRequest({
    required this.identifier,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'code': code,
    'newPassword': newPassword,
  };
}

// موديل الاستجابة
class ResetPasswordResponse {
  final bool success;
  final String message;
  final dynamic data; // يمكن أن يكون null أو أي شيء

  ResetPasswordResponse({required this.success, required this.message, this.data});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}