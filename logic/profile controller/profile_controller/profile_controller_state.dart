import 'package:equatable/equatable.dart';

abstract class ProfileControllerState extends Equatable {
  const ProfileControllerState();

  @override
  List<Object?> get props => [];
}

class ProfileControllerInitialState extends ProfileControllerState {}

class ProfileControllerLoadingState extends ProfileControllerState {}

class ProfileControllerLoadedState extends ProfileControllerState {
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;

  final String? avatarUrl;

  const ProfileControllerLoadedState({
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, email, avatarUrl];
}

// Error state
class ProfileControllerErrorState extends ProfileControllerState {
  final String message;

  const ProfileControllerErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
