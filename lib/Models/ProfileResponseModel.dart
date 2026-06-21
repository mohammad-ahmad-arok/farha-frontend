class ProfileResponseModel {
  final bool success;
  final String message;
  final ProfileData? data;

  ProfileResponseModel({required this.success, required this.message, this.data});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }
}

class ProfileData {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String mobilePhone;
  final String email;
  final String? picture;
  final String username;
  final String birthdate;
  final String registerDatetime;
  final String? emailVerifiedAt;
  final int? additionUserId;
  final String role;
  final String createdAt;
  final String updatedAt;

  ProfileData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.mobilePhone,
    required this.email,
    this.picture,
    required this.username,
    required this.birthdate,
    required this.registerDatetime,
    this.emailVerifiedAt,
    this.additionUserId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      gender: json['gender'] ?? "",
      mobilePhone: json['mobile_phone'] ?? "",
      email: json['email'] ?? "",
      picture: json['picture'],
      username: json['username'] ?? "",
      birthdate: json['birthdate'] ?? "",
      registerDatetime: json['register_datetime'] ?? "",
      emailVerifiedAt: json['email_verified_at'],
      additionUserId: json['addtion_user_id'],
      role: json['role'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
  ProfileData copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? gender,
    String? mobilePhone,
    String? email,
    String? picture,
    String? username,
    String? birthdate,
    String? registerDatetime,
    String? emailVerifiedAt,
    int? additionUserId,
    String? role,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProfileData(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      email: email ?? this.email,
      picture: picture ?? this.picture,
      username: username ?? this.username,
      birthdate: birthdate ?? this.birthdate,
      registerDatetime: registerDatetime ?? this.registerDatetime,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      additionUserId: additionUserId ?? this.additionUserId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}