import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/ui/authen/login_page.dart';
import 'package:capstone_project/ui/authen/signup_page.dart';
import 'package:capstone_project/ui/landing_pages/actor_selection.dart';
import 'package:capstone_project/ui/main/common/detailed_item_view.dart';
import 'package:capstone_project/ui/main/common/main_page.dart';
import 'package:capstone_project/ui/main/common/notifications_page.dart';
import 'package:capstone_project/ui/main/common/profile_page.dart';
import 'package:capstone_project/ui/main/donor/donate_page.dart';
import 'package:capstone_project/ui/main/donor/donor_home_page.dart';
import 'package:capstone_project/ui/main/donor/my_donations_page.dart';
import 'package:capstone_project/ui/main/ngo/find_donations_page.dart';
import 'package:capstone_project/ui/main/ngo/map_page.dart';
import 'package:capstone_project/ui/main/ngo/ngo_home_page.dart';
import 'package:flutter/material.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case AppRoutes.actorSelection:
        return _animatedRoute(
          ActorSelection(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.login:
        return _animatedRoute(
          LoginPage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.signup:
        return _animatedRoute(
          SignupPage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.mainPage:
        return _animatedRoute(
          MainPage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.donorHomePage:
        return _animatedRoute(
          DonorHomePage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.ngoHomePage:
        return _animatedRoute(
          NgoHomePage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.profilePage:
        return _animatedRoute(
          ProfilePage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.detailedItemView:
        return _animatedRoute(
          DetailedItemView(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.mapPage:
        return _animatedRoute(MapPage(), args?["animation"], args?["duration"]);

      case AppRoutes.donatePage:
        return _animatedRoute(
          DonatePage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.myDonationPage:
        return _animatedRoute(
          MyDonationsPage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.findDonationsPage:
        return _animatedRoute(
          FindDonationsPage(),
          args?["animation"],
          args?["duration"],
        );

      case AppRoutes.notificationPage:
        return _animatedRoute(
          NotificationsPage(),
          args?["animation"],
          args?["duration"],
        );

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
