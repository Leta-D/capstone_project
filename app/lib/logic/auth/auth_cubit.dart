import 'package:bloc/bloc.dart';
import 'package:capstone_project/logic/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Loading());

  void authenticateUser(String email, String password) {}
}
