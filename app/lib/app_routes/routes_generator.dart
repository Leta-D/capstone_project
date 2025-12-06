import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/ui/authen/login_page.dart';
import 'package:capstone_project/ui/authen/signup_page.dart';
import 'package:capstone_project/ui/landing_pages/actor_selection.dart';
import 'package:flutter/material.dart';

class RoutGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.actorSelection:
        return MaterialPageRoute(builder: (_) => ActorSelection());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignupPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
