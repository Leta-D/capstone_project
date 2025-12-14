import 'dart:io';

import 'package:geolocator/geolocator.dart';

abstract class DeviceAccessState {}

class InitialState extends DeviceAccessState {}

class ImageSelected extends DeviceAccessState {
  final File? image;

  ImageSelected(this.image);
}

class LocationSelected extends DeviceAccessState {
  Position position;

  LocationSelected(this.position);
}
