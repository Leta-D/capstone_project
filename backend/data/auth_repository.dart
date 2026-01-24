import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://capstone-api-dwzu.onrender.com",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  /// Login API
  Future<Map<String, String>> login({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _dio.post(
        "/users/login",
        data: {"email": email, "password": password},
      );

      final data = response.data;
      if (data["accessToken"] != null && data["refreshToken"] != null) {
        String role = Jwt.parseJwt(data["accessToken"])["role"] ?? "user";
        return {
          "accessToken": data["accessToken"],
          "refreshToken": data["refreshToken"],
          "role": role,
        };
      } else {
        throw "Invalid response from server";
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        throw e.response!.statusCode ?? "Login failed please try again";
        // if (e.response!.statusCode == 401) {
        //   throw "Invalid password";
        // } else if (e.response!.statusCode == 404) {
        //   // throw "USER NOT FOUND please create Account";
        // } else {
        //   throw "Login failed please try again";
        // }
      }
      throw "402"; // network error
    } catch (_) {
      throw "Unexpected error occurred";
    }
  }

  /// Signup API
  Future<Map<String, String>> signup({
    required String name,
    required String email,
    required String password,
    required String role, // user == donor
  }) async {
    try {
      final response = await _dio.post(
        "/users/signup",
        data: {"name": name, "email": email, "password": password},
      );

      final data = response.data;

      if (data["accessToken"] != null && data["refreshToken"] != null) {
        return {
          "accessToken": data["accessToken"],
          "refreshToken": data["refreshToken"],
          "role": role,
        };
      }

      // If backend returns success without tokens
      return {"message": data["message"] ?? "Signup successful"};
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        rethrow;
        // if (e.response!.statusCode == 400) {
        //   throw "Email already in use";
        // } else {
        //   // throw "Validation Or Creation Error";
        // }
      }
      throw "402"; // network error
    } catch (_) {
      throw "Unexpected error occurred";
    }
  }

  // Check if JWT has expiration then use Jwt.isExpired(token);
  bool hasExpiration(String token) {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      return payload.containsKey('exp'); // true if exp exists
    } catch (e) {
      return false; // if token is invalid or not JWT
    }
  }
}
