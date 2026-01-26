import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/auth/auth_bloc.dart';
import 'package:capstone_project/logic/auth/auth_event.dart';
import 'package:capstone_project/logic/auth/auth_state.dart';
import 'package:capstone_project/logic/page_controller/page_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check token when splash loads
    context.read<AuthBloc>().add(AppStarted());

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            context.read<AuthBloc>().add(AppStarted());
          }

          if (state is AuthAuthenticated) {
            if (state.role == "donor") {
              context.read<PageControllerCubit>().setDonor();
            } else {
              context.read<PageControllerCubit>().setNgo();
            }
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainPage,
              (route) => false,
              arguments: {
                "animation": AppRouteAnimationType.rotation,
                "duration": 500,
              },
            );
          }

          if (state is AuthUnauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.actorSelection,
              (route) => false,
              arguments: {
                "animation": AppRouteAnimationType.scale,
                "duration": 500,
              },
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Authentication Error: ${state.message}")),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.actorSelection,
              (route) => false,
              arguments: {
                "animation": AppRouteAnimationType.scale,
                "duration": 500,
              },
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/kindBridge_logo.png",
                  width: 130,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(color: AppColors.green(1)),
              SizedBox(height: 10),
              Text("Checking session...", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
