import 'package:capstone_project/logic/map_controller/map_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapControllerCubit extends Cubit<MapControllerState> {
  MapControllerCubit() : super(MapInitialState());

  Future<void> getCurrentUserPosition() async {
    // final status = await Permission.location.request();

    // if (!status.isGranted) {
    //   emit(MapErrorState(message: "locaton Permission denied"));
    //   return;
    // }
    emit(MapLoadingState());
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    LatLng userLocation = LatLng(position.latitude, position.longitude);
    emit(MapLoadedState(center: userLocation, markers: [], followUser: true));
    print(
      "Map done ============================= $position =================${userLocation.toString()}",
    );
  }
}
