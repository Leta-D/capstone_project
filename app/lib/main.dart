import 'package:capstone_project/ui/authen/login_page.dart';
import 'package:capstone_project/ui/authen/signup_page.dart';
import 'package:capstone_project/ui/landing_pages/actor_selection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: SignupPage());
  }
}
