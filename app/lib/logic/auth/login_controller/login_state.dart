import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String accessToken;
  final String refreshToken;
  final String role;
  LoginSuccessState({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, role];
}

class LoginFailState extends LoginState {
  final String errorMessage;
  LoginFailState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
