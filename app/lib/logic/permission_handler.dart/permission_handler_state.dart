abstract class PermissionHandlerState {}

class PermissionInitial extends PermissionHandlerState {}

class PermissionGranted extends PermissionHandlerState {
  final String permission;
  PermissionGranted(this.permission);
}

class PermissionDenied extends PermissionHandlerState {
  final String permission;
  PermissionDenied(this.permission);
}

class PermissionPermanentlyDenied extends PermissionHandlerState {
  final String permission;
  PermissionPermanentlyDenied(this.permission);
}
