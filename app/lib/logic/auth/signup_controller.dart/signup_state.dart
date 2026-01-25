import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String accessToken;
  final String refreshToken;
  final String role;
  SignupSuccess({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, role];
}

class SignupFailure extends SignupState {
  final String errorMessage;
  SignupFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
