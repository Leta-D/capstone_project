import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/app_routes/routes_generator.dart';
import 'package:capstone_project/logic/device_access/device_location_cubit.dart';
import 'package:capstone_project/logic/device_access/select_image_cubit.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_cubit.dart';
import 'package:capstone_project/ui/authen/login_page.dart';
import 'package:capstone_project/ui/authen/signup_page.dart';
import 'package:capstone_project/ui/landing_pages/actor_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PermissionHandlerCubit()),
        BlocProvider(create: (_) => SelectImageCubit()),
        BlocProvider(create: (_) => DeviceLocationCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.mainPage,
        onGenerateRoute: RoutesGenerator.generateRoute,
      ),
    );
  }
}
