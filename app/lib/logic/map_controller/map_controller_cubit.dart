import 'package:capstone_project/logic/map_controller/map_controller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapControllerCubit extends Cubit<MapControllerState> {
  MapControllerCubit() : super(MapInitialState());

  void updateLocation(LatLng location) {
    emit(MapLoadedState(location));
  }

  final mapController = MapController();

  // final commonController = Get.put(CommonController());
  LatLng? currentPosition;

  LatLng? previousLocation;

  bool followUser = true;

  Future<void> _determinePosition(Position position) async {
    currentPosition = LatLng(position.latitude, position.longitude);
  }

  void _startTracking() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      previousLocation = currentPosition;
      currentPosition = LatLng(position.latitude, position.longitude);

      if (followUser) {
        _animateToLocation(currentPosition!);
      }
    });
  }

  void _animateToLocation(LatLng target) {
    const duration = Duration(milliseconds: 600);
    const steps = 30;
    if (previousLocation == null) {
      mapController.move(target, mapController.camera.zoom);
      return;
    }

    double latStep = (target.latitude - previousLocation!.latitude) / steps;
    double lngStep = (target.longitude - previousLocation!.longitude) / steps;

    for (int i = 0; i < steps; i++) {
      Future.delayed(
        Duration(milliseconds: (duration.inMilliseconds ~/ steps) * i),
        () {
          final stepLat = previousLocation!.latitude + latStep * i;
          final stepLng = previousLocation!.longitude + lngStep * i;
          mapController.move(
            LatLng(stepLat, stepLng),
            mapController.camera.zoom,
          );
        },
      );
    }
  }

  void toggleFollow() {
    followUser = !followUser;
  }

  /// Centers the map on the current location
  void centerMapOnUser() {
    if (currentPosition != null) {
      mapController.move(currentPosition!, 16); // 16 = zoom level
    }
  }
}

// var currentPosition = Rx<LatLng?>(null);
//   final mapController = MapController();

//   final commonController = Get.put(CommonController());

//   LatLng? previousLocation;

//   bool followUser = true;

//   Future<void> _determinePosition() async {
//     Position position = await commonController.getCurrentLocation();
//     currentPosition.value = LatLng(position.latitude, position.longitude);
//   }

//   void _startTracking() {
//     Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 5,
//       ),
//     ).listen((Position position) {
//       previousLocation = currentPosition.value;
//       currentPosition.value = LatLng(position.latitude, position.longitude);

//       if (followUser) {
//         _animateToLocation(currentPosition.value!);
//       }
//     });
//   }

//   void _animateToLocation(LatLng target) {
//     const duration = Duration(milliseconds: 600);
//     const steps = 30;
//     if (previousLocation == null) {
//       mapController.move(target, mapController.camera.zoom);
//       return;
//     }

//     double latStep = (target.latitude - previousLocation!.latitude) / steps;
//     double lngStep = (target.longitude - previousLocation!.longitude) / steps;

//     for (int i = 0; i < steps; i++) {
//       Future.delayed(
//         Duration(milliseconds: (duration.inMilliseconds ~/ steps) * i),
//         () {
//           final stepLat = previousLocation!.latitude + latStep * i;
//           final stepLng = previousLocation!.longitude + lngStep * i;
//           mapController.move(
//             LatLng(stepLat, stepLng),
//             mapController.camera.zoom,
//           );
//         },
//       );
//     }
//   }

//   void toggleFollow() {
//     followUser = !followUser;
//   }

//   /// Centers the map on the current location
//   void centerMapOnUser() {
//     if (currentPosition.value != null) {
//       mapController.move(currentPosition.value!, 16); // 16 = zoom level
//     }
//   }
