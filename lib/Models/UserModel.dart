class UserModel {
  final int idUser;
  final String firstname;
  final String lastname;
  final String gender;
  final String mobilePhone;
  final String email;
  final String picture;
  final String username;
  final String password;
  final DateTime birthdate;
  final DateTime registerDatetime;
  final int additionUserId;

  UserModel({
    required this.idUser,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.mobilePhone,
    required this.email,
    required this.picture,
    required this.username,
    required this.password,
    required this.birthdate,
    required this.registerDatetime,
    required this.additionUserId,
  });

  /// From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['IdUser'],
      firstname: json['Firstname'],
      lastname: json['Lastname'],
      gender: json['gender'],
      mobilePhone: json['Mobilephone'],
      email: json['Email'],
      picture: json['Picture'],
      username: json['Username'],
      password: json['Password'],
      birthdate: DateTime.parse(json['Birthdate']),
      registerDatetime: DateTime.parse(json['registerDatetime']),
      additionUserId: json['addtionuserId'],
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'IdUser': idUser,
      'Firstname': firstname,
      'Lastname': lastname,
      'gender': gender,
      'Mobilephone': mobilePhone,
      'Email': email,
      'Picture': picture,
      'Username': username,
      'Password': password,
      'Birthdate': birthdate.toIso8601String(),
      'registerDatetime': registerDatetime.toIso8601String(),
      'addtionuserId': additionUserId,
    };
  }
}
