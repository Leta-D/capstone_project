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
}
