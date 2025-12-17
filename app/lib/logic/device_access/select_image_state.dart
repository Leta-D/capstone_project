import 'dart:io';

abstract class SelectImageState {}

class ImageInitialState extends SelectImageState {}

class ImageLoadingState extends SelectImageState {}

class ImageSelected extends SelectImageState {
  final File? image;

  ImageSelected(this.image);
}
