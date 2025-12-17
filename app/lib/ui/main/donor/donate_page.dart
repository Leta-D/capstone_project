import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/device_access/device_loaction_state.dart';
import 'package:capstone_project/logic/device_access/device_location_cubit.dart';
import 'package:capstone_project/logic/device_access/select_image_cubit.dart';
import 'package:capstone_project/logic/device_access/select_image_state.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_cubit.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});
  @override
  createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  // File? _image;
  // final ImagePicker _picker = ImagePicker();

  // Future<void> pickImage(ImageSource source) async {
  //   // bool granted = await requestGalleryPermission(
  //   //   source == ImageSource.camera ? 'camera' : 'gallery',
  //   // );
  //   // if (granted) {
  //   final XFile? picked = await _picker.pickImage(source: source);

  //   if (picked != null) {
  //     setState(() {
  //       _image = File(picked.path);
  //     });
  //     // }
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: const Text('Permission Denied'),
  //         content: const Text(
  //           'Gallery access is required to upload images. '
  //           'Please enable the permission to continue.',
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // Future<Position?> getCurrentLocation() async {
  //   // bool hasPermission = await requestLocationPermission();

  //   // if (!hasPermission) return null;

  //   return await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }

  // Future<bool> requestGalleryPermission(String type) async {
  //   PermissionStatus status = (type == 'camera')
  //       ? await Permission.camera.request()
  //       : await Permission.photos.request();

  //   if (status.isGranted) {
  //     return true;
  //   } else if (status.isDenied) {
  //     return false;
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //     return false;
  //   }
  //   return false;
  // }

  // Future<bool> requestLocationPermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return false;
  //   }

  //   return permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always;
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return BlocListener<PermissionHandlerCubit, PermissionHandlerState>(
      listener: (context, state) {
        if (state is PermissionInitial) {
          context.read<PermissionHandlerCubit>().requestCamera();
          context.read<PermissionHandlerCubit>().requestGallery();
          context.read<PermissionHandlerCubit>().requestLocation();
        } else if (state is PermissionDenied) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('${state.permission} Permission Denied'),
              content: const Text(
                'Required access is denied. '
                'Please enable the permission to continue.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    openAppSettings();
                  },
                  child: const Text('setting'),
                ),
              ],
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                elevation: 0.3,
                shadowColor: AppColors.white(1),
                color: AppColors.lightGreen(0.31),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BlocConsumer<SelectImageCubit, SelectImageState>(
                  builder: (contect, state) => InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        barrierLabel: "Select Image From",
                        elevation: 2,
                        useSafeArea: true,
                        barrierColor: AppColors.grey(0.71),
                        builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.camera_alt,
                                color: AppColors.green(0.7),
                              ),
                              splashColor: AppColors.lightGreen(0.3),
                              title: Text('Camera'),
                              onTap: () {
                                (context)
                                    .read<SelectImageCubit>()
                                    .selectImageFromCamera();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.photo,
                                color: AppColors.green(0.7),
                              ),
                              splashColor: AppColors.lightGreen(0.3),
                              title: Text('Gallery'),
                              onTap: () {
                                (context)
                                    .read<SelectImageCubit>()
                                    .selectImageFromGallery();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    splashColor: AppColors.lightGreen(0.5),
                    child: Center(
                      child: Column(
                        children: [
                          if (state is ImageInitialState)
                            CircularProgressIndicator(),
                          if (state is ImageSelected)
                            Image.file(
                              state.image!,
                              height: 250,
                              width: 320,
                              fit: BoxFit.contain,
                            ),

                          Text(
                            'Tap to select image',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  listener: (contex, state) {
                    (context, state) {
                      if (state is ImageSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarAnimationStyle: AnimationStyle(
                            curve: Curves.easeInOut,
                          ),
                          SnackBar(
                            content: Text(
                              "Image Selected"
                              "${state.image!.path}",
                              style: TextStyle(color: AppColors.black(1)),
                            ),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.white(1),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only(
                              bottom: screenSize.height - 120,
                              left: 16,
                              right: 16,
                            ),
                          ),
                        );
                      }
                    };
                  },
                ),
              ),
              SizedBox(height: 27),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text("Item Name", style: TextStyle(fontSize: 18)),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightGreen(0.8)),
                  ),
                ),
              ),
              SizedBox(height: 27),
              DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(15),
                items: ["food", "cloth", "book"]
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (value) {},
                initialValue: null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightGreen(0.8)),
                  ),
                  label: Text(
                    "Select item type",
                    style: TextStyle(color: AppColors.green(1)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightGreen(0.6)),
                  ),
                ),
              ),
              SizedBox(height: 27),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 180,
                    child:
                        BlocConsumer<DeviceLocationCubit, DeviceLoactionState>(
                          builder: (context, state) => ListTile(
                            onTap: () async {
                              // Position? position = await getCurrentLocation();
                              BlocProvider.of<PermissionHandlerCubit>(
                                context,
                              ).requestLocation();
                              BlocProvider.of<DeviceLocationCubit>(
                                context,
                              ).getCurrentLocation();
                              state is LocatedState
                                  ? print(state.position)
                                  : print("not located");
                            },
                            leading: Icon(Icons.pin_drop_outlined),
                            title: Text("Location"),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: AppColors.black(0.6),
                                width: 0.5,
                              ),
                            ),
                          ),
                          listener: (context, state) {
                            if (state is LocatedState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarAnimationStyle: AnimationStyle(
                                  curve: Curves.easeInOut,
                                ),
                                SnackBar(
                                  content: Text(
                                    "Location Selected"
                                    "${state.position}",
                                    style: TextStyle(color: AppColors.black(1)),
                                  ),
                                  duration: Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.white(1),
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: screenSize.height - 120,
                                    left: 16,
                                    right: 16,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                  ),
                  SizedBox(
                    width: 160,
                    child: ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text("Date"),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: AppColors.black(0.6),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 27),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text("Description", style: TextStyle(fontSize: 18)),
              ),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightGreen(0.8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // child: BlocConsumer<DeviceAccessCubit, DeviceAccessState>(
      //   listener: (context, state) {
      //     if (state is ImageSelected) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         snackBarAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
      //         SnackBar(
      //           content: Text(
      //             "Image Selected"
      //             "${state.image!.path}",
      //             style: TextStyle(color: AppColors.black(1)),
      //           ),
      //           duration: Duration(seconds: 1),
      //           behavior: SnackBarBehavior.floating,
      //           backgroundColor: AppColors.white(1),
      //           shape: BeveledRectangleBorder(
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           margin: EdgeInsets.only(
      //             bottom: screenSize.height - 120,
      //             left: 16,
      //             right: 16,
      //           ),
      //         ),
      //       );
      //     } else if (state is LocationSelected) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         snackBarAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
      //         SnackBar(
      //           content: Text(
      //             "Location Selected"
      //             "${state.position}",
      //             style: TextStyle(color: AppColors.black(1)),
      //           ),
      //           duration: Duration(seconds: 1),
      //           behavior: SnackBarBehavior.floating,
      //           backgroundColor: AppColors.white(1),
      //           shape: BeveledRectangleBorder(
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           margin: EdgeInsets.only(
      //             bottom: screenSize.height - 120,
      //             left: 16,
      //             right: 16,
      //           ),
      //         ),
      //       );
      //     }
      //   },
      //   builder: (context, state) =>
      // ),
    );
  }
}
