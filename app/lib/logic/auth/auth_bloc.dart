import 'package:capstone_project/logic/auth/auth_event.dart';
import 'package:capstone_project/logic/auth/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoading());

      String? accessToken = await storage.read(key: 'accessToken');
      String? refreshToken = await storage.read(key: 'refreshToken');

      print("============================================");
      print("Access Token: $accessToken");
      String? role = await storage.read(key: 'role');

      if (accessToken != null && role != null) {
        if (!isTokenExpired(accessToken)) {
          emit(AuthAuthenticated(role));
        } else if (refreshToken != null && !isTokenExpired(refreshToken)) {
          String? newAccessToken = await refreshAccessToken(refreshToken);
          await storage.write(key: 'accessToken', value: newAccessToken);
          emit(AuthAuthenticated(role));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await storage.write(key: 'accessToken', value: event.accessToken);
      await storage.write(key: 'refreshToken', value: event.refreshToken);
      await storage.write(key: 'role', value: event.role);

      print("Token saved to device");

      emit(AuthAuthenticated(event.role));
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await storage.deleteAll(); // clear tokens + role
      emit(AuthUnauthenticated());
    });
  }

  bool isTokenExpired(String token) {
    try {
      return Jwt.isExpired(token);
    } catch (e) {
      return true;
    }
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://capstone-api-dwzu.onrender.com",
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {"Content-Type": "application/json"},
      ),
    );

    try {
      final response = await dio.post(
        "/auth/refresh",
        data: {"refreshToken": refreshToken},
      );

      // ✅ Adjust key name based on backend response
      final String? newAccessToken = response.data["accessToken"];

      return newAccessToken;
    } on DioException catch (e) {
      print("Refresh token failed");
      print("Status: ${e.response?.statusCode}");
      print("Message: ${e.response?.data}");
      return null;
    }
  }
}
