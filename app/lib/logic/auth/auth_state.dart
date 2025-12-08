import 'package:capstone_project/backend/model/user_model.dart';

abstract class AuthState {}

class Loading extends AuthState {}

class Success extends AuthState {
  UserModel user;

  Success(this.user);
}

class Failure extends AuthState {
  String error;

  Failure(this.error);
}

class Logout extends AuthState {}
