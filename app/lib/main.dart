import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/app_routes/routes_generator.dart';
import 'package:capstone_project/logic/auth/auth_bloc.dart';
import 'package:capstone_project/logic/auth/auth_state.dart';
import 'package:capstone_project/logic/auth/login_controller/login_cubit.dart';
import 'package:capstone_project/logic/auth/signup_controller.dart/signup_cubit.dart';
import 'package:capstone_project/logic/device_access/device_location_cubit.dart';
import 'package:capstone_project/logic/device_access/select_image_cubit.dart';
import 'package:capstone_project/logic/donated_item_controller/donated_item_cubit.dart';
import 'package:capstone_project/logic/donation_controller/item_donation_controller_cubit.dart';
import 'package:capstone_project/logic/map_controller/map_controller_cubit.dart';
import 'package:capstone_project/logic/page_controller/page_controller_cubit.dart';
import 'package:capstone_project/logic/permission_handler.dart/permission_handler_cubit.dart';
import 'package:capstone_project/logic/profile_controller/profile_controller_cubit.dart';
import 'package:capstone_project/ui/authen/login_page.dart';
import 'package:capstone_project/ui/authen/signup_page.dart';
import 'package:capstone_project/ui/landing_pages/actor_selection.dart';
import 'package:capstone_project/ui/landing_pages/splash_screen.dart';
import 'package:capstone_project/ui/main/common/main_page.dart';
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
        BlocProvider(create: (_) => MapControllerCubit()),
        BlocProvider(create: (_) => PageControllerCubit()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => SignupCubit()),
        BlocProvider(create: (_) => DonatedItemCubit()),
        BlocProvider(create: (_) => ItemDonationControllerCubit()),
        BlocProvider(create: (_) => ProfileControllerCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: RoutesGenerator.generateRoute,
        // home: BlocBuilder<AuthBloc, AuthState>(
        //   builder: (context, state) {
        //     if (state is AuthLoading || state is AuthInitial) {
        //       return SplashScreen();
        //     } else if (state is AuthAuthenticated) {
        //       return MainPage();
        //     } else if (state is AuthUnauthenticated) {
        //       return ActorSelection();
        //     } else {
        //       return ActorSelection();
        //     }
        //   },
        // ),
      ),
    );
  }
}
