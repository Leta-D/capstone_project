import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/ui/landing_pages/actor_selection.dart';
import 'package:flutter/material.dart';

class RoutGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.actorSelection:
        return MaterialPageRoute(builder: (_) => ActorSelection());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
