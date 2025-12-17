import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/ui/authen/login_page.dart';
import 'package:capstone_project/ui/authen/signup_page.dart';
import 'package:capstone_project/ui/landing_pages/actor_selection.dart';
import 'package:capstone_project/ui/main/common/main_page.dart';
import 'package:flutter/material.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case AppRoutes.actorSelection:
        return _animatedRoute(
          ActorSelection(),
          args?["anim"],
          args?["duration"],
        );

      case AppRoutes.login:
        return _animatedRoute(LoginPage(), args?["anim"], args?["duration"]);

      case AppRoutes.signup:
        return _animatedRoute(SignupPage(), args?["anim"], args?["duration"]);

      case AppRoutes.mainPage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.donorHomePage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.ngoHomePage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.profilePage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.mapPage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.donatePage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.myDonationPage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.findDonationsPage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      case AppRoutes.notificationPage:
        return _animatedRoute(MainPage(), args?["anim"], args?["duration"]);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text("Error", style: TextStyle(color: AppColors.red(1))),
            ),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static _animatedRoute(
    Widget page,
    AppRouteAnimationType? type,
    int? duration,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, __) => page,
      transitionDuration: Duration(milliseconds: duration ?? 300),
      transitionsBuilder: (context, animation, __, child) {
        switch (type) {
          case AppRouteAnimationType.fade:
            return FadeTransition(opacity: animation, child: child);

          case AppRouteAnimationType.scale:
            return ScaleTransition(scale: animation, child: child);

          case AppRouteAnimationType.slide:
            return SlideTransition(
              position: Tween(
                begin: const Offset(1, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );

          case AppRouteAnimationType.rotation:
            return RotationTransition(turns: animation, child: child);

          default:
            return FadeTransition(opacity: animation, child: child);
        }
      },
    );
  }
}
