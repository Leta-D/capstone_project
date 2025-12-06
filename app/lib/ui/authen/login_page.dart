import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.lightGreen(0.71),
                  borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(50),
                    bottom: Radius.circular(20),
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: AppColors.black(1)),
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    ClipOval(
                      child: Container(
                        color: AppColors.green(1),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      cursorColor: AppColors.black(1),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: AppColors.black(1)),
                        // hintText: "@example.com",
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: AppColors.green(1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.green(1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.green(1)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.red(1)),
                        ),
                        errorText: null, // "type some thing"
                      ),
                    ),
                    SizedBox(),
                    TextField(
                      cursorColor: AppColors.black(1),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: AppColors.black(1)),
                        prefixIcon: Icon(Icons.lock, color: AppColors.green(1)),
                        suffix: InkWell(
                          onTap: () {},
                          child: Icon(Icons.remove_red_eye_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.green(1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.green(1)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.red(1)),
                        ),
                        errorText: null, // "type some thing"
                      ),
                    ),
                    SizedBox(),
                    ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.white(1),
                        backgroundColor: AppColors.green(0.8),
                        fixedSize: Size(240, 43),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: Text("Sign in", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
