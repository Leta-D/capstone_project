import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ProfileRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://capstone-api-dwzu.onrender.com",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );
  final FlutterSecureStorage storage = FlutterSecureStorage();

  /// Helper: Get user ID from access token
  Future<String> _getUserIdFromToken() async {
    final token = await storage.read(key: "accessToken");
    if (token == null) throw Exception("Access token not found");

    final payload = Jwt.parseJwt(token);
    final userId = payload["sub"] ?? payload["id"];
    if (userId == null) throw Exception("User ID not found in token");

    return userId.toString();
  }

  /// Fetch user profile
  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await storage.read(key: "accessToken");
    if (token == null) throw Exception("Access token not found");

    final userId = await _getUserIdFromToken();

    final response = await dio.get(
      "/users/$userId",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    print(response.data);

    return response.data;
  }

  /// Update user profile
  /// avatarPath is optional (local file path)
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? email,
    String? avatarPath,
  }) async {
    final token = await storage.read(key: "accessToken");
    if (token == null) throw Exception("Access token not found");

    final userId = await _getUserIdFromToken();

    final formMap = <String, dynamic>{};
    if (name != null) formMap["name"] = name;
    if (email != null) formMap["email"] = email;
    if (avatarPath != null && avatarPath.isNotEmpty) {
      formMap["avatar"] = await MultipartFile.fromFile(
        avatarPath,
        filename: avatarPath.split("/").last,
      );
    }

    final response = await dio.put(
      "/users/$userId",
      data: FormData.fromMap(formMap),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response.data;
  }
}
