import 'package:capstone_project/backend/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  final AuthRepository _authRepository = AuthRepository();

  Future<void> login({
    required String email,
    required String password,
    required String role,
  }) async {
    emit(LoginLoadingState());

    try {
      role = (role == 'donor') ? 'user' : 'ngo';
      final result = await _authRepository.login(
        email: email,
        password: password,
        role: role,
      );

      role = (result["role"] == 'user') ? 'donor' : 'ngo';
      // call AuthBloc after this in UI
      emit(
        LoginSuccessState(
          accessToken: result["accessToken"]!,
          refreshToken: result["refreshToken"]!,
          role: role,
        ),
      );
    } catch (e) {
      emit(LoginFailState(errorMessage: "Error: $e"));
    }
  }
}
