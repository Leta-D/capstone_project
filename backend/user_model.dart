class UserModel {
  String id;
  String name;
  String email;
  String password;
  String role;
  String? phoneNumber;
  String? profileImageUrl;
  String badge;
  bool isActive;
  DateTime createdAt;
  DateTime lastLogin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.badge,
    required this.isActive,
    required this.createdAt,
    required this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      badge: json['badge'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: DateTime.parse(json['lastLogin'] as String),
    );
  }
}
