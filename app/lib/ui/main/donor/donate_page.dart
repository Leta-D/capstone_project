import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc/bloc.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/auth/auth_state.dart';
import 'package:capstone_project/logic/device_access/device_loaction_state.dart';
import 'package:capstone_project/logic/device_access/device_location_cubit.dart';
import 'package:capstone_project/logic/device_access/select_image_cubit.dart';
import 'package:capstone_project/logic/device_access/select_image_state.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_cubit.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});
  @override
  createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final List<String> _motivationalQuotes = [
    "Your donation can change a life today.",
    "No one should sleep hungry when we can help.",
    "Your clothes can bring warmth to those in need.",
    "A single dose can bring hope to someone in need.",
    "Books shared today shape minds for tomorrow.",
    "Your generosity helps turn empty houses into homes.",
    "Your small act of kindness can create a big change.",
  ];
  int _currentQuoteIndex = 0;

  final _donationItemTypes = [
    "food",
    "cloth",
    "medicine",
    "book",
    "household",
    "other",
  ];

  DateTime _postDate = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

  String? _itemType;

  bool _isNameError = false;

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
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    _motivationalQuotes[_currentQuoteIndex],
                    speed: Duration(milliseconds: 110),
                    textStyle: GoogleFonts.bonheurRoyale(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green(0.8),
                      backgroundColor: AppColors.lightGreen(0.1),
                    ),
                  ),
                ],
                displayFullTextOnTap: true,
                repeatForever: true,
                isRepeatingAnimation: true,
              ),
              SizedBox(height: 20),
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
                            Image.asset(
                              "assets/kindBridge_logo.png",
                              height: 250,
                              width: 320,
                              fit: BoxFit.contain,
                            ),
                          if (state is ImageSelected)
                            Image.file(
                              state.image!,
                              height: 250,
                              width: 320,
                              fit: BoxFit.contain,
                            ),

                          Text(
                            state is ImageSelected
                                ? "Tap to Change Image"
                                : 'Tap to select image',
                            style: TextStyle(
                              fontSize: 17,
                              color: AppColors.white(1),
                              fontWeight: FontWeight.bold,
                            ),
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
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightGreen(0.8)),
                  ),
                  errorText: _isNameError ? "Item Name Can't be Empty!" : null,
                ),
              ),
              SizedBox(height: 27),
              DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(15),
                items: _donationItemTypes
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (value) {
                  _itemType = value;
                  setState(() {
                    _currentQuoteIndex = _donationItemTypes.indexOf(value!) + 1;
                  });
                },
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
                            onTap: () {
                              // Position? position = await getCurrentLocation();
                              BlocProvider.of<PermissionHandlerCubit>(
                                context,
                              ).requestLocation();
                              BlocProvider.of<DeviceLocationCubit>(
                                context,
                              ).getCurrentLocation();
                            },
                            leading: Icon(Icons.pin_drop_outlined),
                            title: state is LocationLoadingState
                                ? CircularProgressIndicator(
                                    color: AppColors.green(0.7),
                                    strokeWidth: 1.5,
                                  )
                                : Text(
                                    state is LocatedState
                                        ? "${state.position}"
                                        : "Location",
                                  ),
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
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(
                            DateTime.now().year + 1,
                            DateTime.now().month,
                          ),
                          builder: (context, child) => Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: AppColors.green(0.67),
                                onSecondary: AppColors.white(1),
                              ),
                            ),
                            child: child!,
                          ),
                        );
                        if (pickedDate != null) {
                          setState(() => _postDate = pickedDate);
                        }
                      },
                      leading: Icon(Icons.date_range),
                      title: Text(
                        "${_postDate.month}-${_postDate.day}-${_postDate.year}",
                      ),
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
                controller: discriptionController,
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
              SizedBox(height: 25),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isNameError = nameController.text.isEmpty;
                    });

                    (context.read<DeviceLocationCubit>().state is LocatedState)
                        ? null
                        : showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                color: AppColors.red(1),
                              ),
                              content: Text("Item Location must be filled!"),
                            ),
                          );
                    _itemType != null
                        ? null
                        : showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                color: AppColors.red(1),
                              ),
                              content: Text("Item Type must be selected!"),
                            ),
                          );
                    if (!_isNameError &&
                        _itemType != null &&
                        (context.read<DeviceLocationCubit>().state
                            is LocatedState)) {
                      showDialog(
                        context: context,
                        builder: (_) => _itemPostPreveiw(),
                        barrierDismissible: false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.green(0.7),
                  ),
                  child: Text(
                    "Preveiw",
                    style: TextStyle(color: AppColors.white(1), fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemPostPreveiw() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (context.read<SelectImageCubit>().state is ImageSelected)
              ? Image.file(
                  (context.read<SelectImageCubit>().state as ImageSelected)
                      .image!,
                  height: 250,
                  width: 320,
                  fit: BoxFit.contain,
                )
              : Column(
                  children: [
                    Image.asset(
                      "assets/kindBridge_logo.png",
                      height: 250,
                      width: 320,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "No Image Selected! \n Is recommended to add Item image",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red(1),
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 20),
          Text(
            "Item Name: ${nameController.text}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Item Type: $_itemType", style: TextStyle(fontSize: 15)),
          Text(
            "Description: ${discriptionController.text.isEmpty ? "No description" : discriptionController.text}",
            style: TextStyle(fontSize: 14),
          ),
          Text(
            "Post Date: ${_postDate.month}-${_postDate.day}-${_postDate.year}",
            style: TextStyle(fontSize: 14),
          ),
          Text(
            "Location: ${(context.read<DeviceLocationCubit>().state as LocatedState).position!.latitude} , ${(context.read<DeviceLocationCubit>().state as LocatedState).position!.longitude}",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.red(0.8),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // Implement post submission logic here

            Navigator.pop(context);
          },
          child: Text(
            'Post',
            style: TextStyle(
              color: AppColors.green(0.8),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
