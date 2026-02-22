class UserModel {
  final String personName;
  final String phoneNumber;
  final String token;
  final String expiration;

  UserModel({
    required this.personName,
    required this.phoneNumber,
    required this.token,
    required this.expiration,
  });

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      personName: json['personName']??'',
      phoneNumber: json['phoneNumber'] ?? '',
      token: json['token'] ?? '',
      expiration: json['expiration'] ?? '',
    );
  }
}
