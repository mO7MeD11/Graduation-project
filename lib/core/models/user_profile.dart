class UserProfile {
  final String name;
  final String email;
  final String? profileImageUrl;
  final String nationalId;
  final String phone;
  final String role;

  const UserProfile({
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.nationalId,
    required this.phone,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String? ?? 'غير معروف',
      email: json['email'] as String? ?? '',
      profileImageUrl: json['profile_image_url'] as String?,
      nationalId: json['national_id'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: json['role'] as String? ?? 'راكب',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profile_image_url': profileImageUrl,
      'national_id': nationalId,
      'phone': phone,
      'role': role,
    };
  }

  UserProfile copyWith({
    String? name,
    String? email,
    String? profileImageUrl,
    String? nationalId,
    String? phone,
    String? role,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      nationalId: nationalId ?? this.nationalId,
      phone: phone ?? this.phone,
      role: role ?? this.role,
    );
  }
}