import 'dart:io';
import 'package:capstone_project/logic/device_access/select_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageCubit extends Cubit<SelectImageState> {
  SelectImageCubit() : super(ImageInitialState());

  final ImagePicker _picker = ImagePicker();

  Future<void> selectImageFromGallery() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      emit(ImageSelected(File(picked.path)));
    }
  }

  Future<void> selectImageFromCamera() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      emit(ImageSelected(File(picked.path)));
    }
  }
}
