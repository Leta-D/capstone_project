import 'package:capstone_project/logic/map_controller/map_controller_cubit.dart';
import 'package:capstone_project/logic/map_controller/map_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapControllerCubit, MapControllerState>(
      builder: (context, state) {
        if (state is MapInitialState) {
          return CircularProgressIndicator();
        } else if (state is MapLoadingState) {
          return CircularProgressIndicator();
        } else if (state is MapLoadedState) {
          return FlutterMap(
            // mapController: mapController.mapController,
            options: MapOptions(
              initialCenter: state.selectedLocation,
              initialZoom: 13.0,
              onPositionChanged: (_, __) {
                // mapController.followUser = false;
              },
            ),

            children: [
              TileLayer(
                urlTemplate:
                    "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=uZDMgqkvC3iESW0OPRtc",
                userAgentPackageName: "com.kindbridge.app", // your package name
              ),

              // TileLayer(
              //   urlTemplate:
              //       "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              //   userAgentPackageName: "com.example.app",
              // ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: state.selectedLocation,
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  // for (var item in dummyDonations)
                  Marker(
                    point: LatLng(8.8858241, 38.8102253),
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
            ],
          );
        } else {
          return Center(child: Text("Error hapened!"));
        }
      },
    );
  }
}
