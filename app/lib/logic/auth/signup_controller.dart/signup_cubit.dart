import 'package:capstone_project/backend/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final AuthRepository _authRepository = AuthRepository();

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());

    try {
      final response = await _authRepository.signup(
        name: name,
        email: email,
        password: password,
        role: 'user',
      );

      // If successful
      emit(
        SignupSuccess(
          accessToken: response["accessToken"]!,
          refreshToken: response["refreshToken"]!,
          role: "donor", // user == donor
        ),
      );
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
