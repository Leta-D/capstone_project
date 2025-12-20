import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

abstract class MapControllerState {}

class MapInitialState extends MapControllerState {}

class MapLoadingState extends MapControllerState {}

class MapLoadedState extends MapControllerState {
  final LatLng center;
  final List<LatLng> markers;
  final bool followUser;

  MapLoadedState({
    required this.center,
    required this.markers,
    required this.followUser,
  });

  // MapLoadedState copyWith({
  //   LatLng? center,
  //   List<Marker>? markers,
  //   bool? followUser,
  // }) {
  //   return MapLoadedState(
  //     center: center ?? this.center,
  //     markers: markers ?? this.markers,
  //     followUser: followUser ?? this.followUser,
  //   );
  // }
}

class MapErrorState extends MapControllerState {
  final String message;

  MapErrorState({required this.message});

  @override
  String toString() {
    return 'MapErrorState{message: $message}';
  }
}
