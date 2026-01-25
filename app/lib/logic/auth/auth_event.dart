abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String accessToken;
  final String refreshToken;
  final String role;

  LoggedIn({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });
}

class LoggedOut extends AuthEvent {}

class TokenRefreshed extends AuthEvent {
  final String accessToken;
  final String refreshToken;

  TokenRefreshed({required this.accessToken, required this.refreshToken});
}

class AuthErrorOccurred extends AuthEvent {
  final String message;

  AuthErrorOccurred(this.message);
}
