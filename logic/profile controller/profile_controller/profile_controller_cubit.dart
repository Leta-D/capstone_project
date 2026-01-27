import 'package:capstone_project/backend/data/profile_repository.dart';
import 'package:capstone_project/logic/profile_controller/profile_controller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class ProfileControllerCubit extends Cubit<ProfileControllerState> {
  final ProfileRepository repository = ProfileRepository();

  ProfileControllerCubit() : super(ProfileControllerInitialState());

  /// Fetch profile
  Future<void> fetchProfile() async {
    emit(ProfileControllerLoadingState());

    try {
      final data = await repository.fetchProfile();

      emit(
        ProfileControllerLoadedState(
          name: data["name"],
          email: data["email"],
          role: data["role"],
          createdAt: data["createdAt"],
          updatedAt: data["updatedAt"],
          avatarUrl: data["avatarUrl"],
        ),
      );
    } catch (e) {
      emit(ProfileControllerErrorState(e.toString()));
    }
  }

  /// Update profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatarPath,
  }) async {
    emit(ProfileControllerLoadingState());

    try {
      final data = await repository.updateProfile(
        name: name,
        email: email,
        avatarPath: avatarPath,
      );
      print("=======================================");
      print(data['role']);

      emit(
        ProfileControllerLoadedState(
          name: data["name"],
          email: data["email"],
          role: data["role"],
          createdAt: data["createdAt"],
          updatedAt: data["updatedAt"],
          avatarUrl: data["avatarUrl"],
        ),
      );
    } catch (e) {
      emit(ProfileControllerErrorState(e.toString()));
    }
  }
}
