import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/device_access/device_loaction_state.dart';
import 'package:capstone_project/logic/device_access/device_location_cubit.dart';
import 'package:capstone_project/logic/map_controller/map_controller_cubit.dart';
import 'package:capstone_project/logic/map_controller/map_controller_state.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_cubit.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  bool _permissionDenied = false;
  @override
  void initState() {
    context.read<PermissionHandlerCubit>().requestLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: BlocListener<PermissionHandlerCubit, PermissionHandlerState>(
        listener: (context, state) {
          if (state is PermissionInitial) {
            context.read<PermissionHandlerCubit>().requestLocation();
          } else if (state is PermissionDenied) {
            state.permission == "Location"
                ? showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text("Location permission denied"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _permissionDenied = true;
                            });
                          },
                          child: Text("cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context
                                .read<PermissionHandlerCubit>()
                                .requestLocation();
                          },
                          child: Text("ask"),
                        ),
                      ],
                    ),
                  )
                : context.read<PermissionHandlerCubit>().requestLocation();
          } else if (state is PermissionGranted) {
            if (state.permission == "Location") {
              (context).read<MapControllerCubit>().getCurrentUserPosition();
              _permissionDenied = false;
            } else {
              context.read<PermissionHandlerCubit>().requestLocation();
            }
          } else if (state is PermissionPermanentlyDenied) {
            state.permission == "Location"
                ? showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text("Location permission denied"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _permissionDenied = true;
                            });
                          },
                          child: Text("cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            openAppSettings();
                          },
                          child: Text("settings"),
                        ),
                      ],
                    ),
                  )
                : context.read<PermissionHandlerCubit>().requestLocation();
          } else {
            context.read<PermissionHandlerCubit>().requestLocation();
          }
        },
        child: !_permissionDenied
            ? BlocBuilder<MapControllerCubit, MapControllerState>(
                builder: (context, state) {
                  if (state is MapInitialState || state is MapLoadingState) {
                    // if (state is MapInitialState) {
                    // (context)
                    //     .read<MapControllerCubit>()
                    //     .getCurrentUserPosition();
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.green(0.7),
                            backgroundColor: AppColors.lightGreen(0.4),
                          ),
                          Text("Initializing...."),
                        ],
                      ),
                    );
                  } else if (state is MapLoadedState) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          children: [
                            FlutterMap(
                              mapController: mapController,
                              options: MapOptions(
                                initialCenter: state.center,
                                initialZoom: 15,

                                // onPositionChanged: (_, __) {
                                //   mapController.followUser = false;
                                // },
                              ),

                              children: [
                                TileLayer(
                                  urlTemplate:
                                      "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  userAgentPackageName:
                                      "com.example.capstone_project", // your package name
                                ),
                                // TileLayer(
                                //   urlTemplate:
                                //       "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=uZDMgqkvC3iESW0OPRtc",
                                //   userAgentPackageName: "com.kindbridge.app",
                                //   // "com.example.capstone_project", // your package name
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    print("object");
                                  },
                                  child: MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: state.center,
                                        width: 40,
                                        height: 40,
                                        // rotate: true,
                                        child: Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                      for (var item in state.markers)
                                        Marker(
                                          point: item,
                                          width: 40,
                                          height: 40,
                                          child: GestureDetector(
                                            onTap: () {
                                              // Handle marker tap
                                              // Get.to(() => DonatedItemFullView(item: item));
                                            },
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.blue,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    mapController.move(state.center, 15);
                                  },
                                  backgroundColor: AppColors.green(
                                    1,
                                  ).withBlue(100),
                                  elevation: 5,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  tooltip: "Locate Me",
                                  splashColor: AppColors.lightGreen(0.7),
                                  child: Icon(
                                    Icons.location_searching_rounded,
                                    size: 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white(1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text("Map Error");
                  }
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Location Access is Permanently denied.",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Go to settings and allow location access to use the map.",
                      style: TextStyle(color: AppColors.grey(0.8)),
                    ),
                    SizedBox(height: 30),
                    TextButton(
                      onPressed: () => openAppSettings(),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.lightGreen(0.2),
                        ),
                        shape: WidgetStatePropertyAll(
                          BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(
                        "Open Settings",
                        style: TextStyle(color: AppColors.green(0.8)),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
