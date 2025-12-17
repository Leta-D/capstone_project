import 'package:latlong2/latlong.dart';

abstract class MapControllerState {}

class MapInitialState extends MapControllerState {}

class MapLoadingState extends MapControllerState {}

class MapLoadedState extends MapControllerState {
  final LatLng selectedLocation;

  MapLoadedState(this.selectedLocation);
}

class MapErrorState extends MapControllerState {}
