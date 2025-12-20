import 'package:capstone_project/logic/device_access/device_loaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class DeviceLocationCubit extends Cubit<DeviceLoactionState> {
  DeviceLocationCubit() : super(LocationInitialState());

  Future<void> getCurrentLocation() async {
    emit(LocationLoadingState());
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    emit(LocatedState(position));
  }
}
