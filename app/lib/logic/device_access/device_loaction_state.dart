import 'package:geolocator/geolocator.dart';

abstract class DeviceLoactionState {}

class LocationInitialState extends DeviceLoactionState {}

class LocationLoadingState extends DeviceLoactionState {}

class LocatedState extends DeviceLoactionState {
  Position? position;

  LocatedState(this.position);
}

// class ImageSelectionError extends DeviceLoactionState{}
