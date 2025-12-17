import 'package:bloc/bloc.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class PermissionHandlerCubit extends Cubit<PermissionHandlerState> {
  PermissionHandlerCubit() : super(PermissionInitial());

  Future<void> requestGallery() async {
    final status = await Permission.photos.request();
    _emitStatus(status, 'Gallery');
  }

  Future<void> requestCamera() async {
    final status = await Permission.camera.request();
    _emitStatus(status, 'Camera');
  }

  Future<void> requestLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      emit(PermissionPermanentlyDenied('Location'));
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      emit(PermissionGranted('Location'));
    } else {
      emit(PermissionDenied('Location'));
    }
  }

  void _emitStatus(PermissionStatus status, String name) {
    if (status.isGranted) {
      emit(PermissionGranted(name));
    } else if (status.isPermanentlyDenied) {
      emit(PermissionPermanentlyDenied(name));
    } else {
      emit(PermissionDenied(name));
    }
  }
}
