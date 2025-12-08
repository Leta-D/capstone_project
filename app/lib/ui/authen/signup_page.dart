import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwdController = TextEditingController();

  bool nameError = false;
  bool emailError = false;
  bool passwdError = false;

  bool showPasswd = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      // backgroundColor: AppColors.lightGreen(0.8),
      backgroundColor: const Color.fromARGB(255, 214, 252, 228),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: screenSize.height - 20,
                child: Align(
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
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.login,
                          arguments: {
                            "anim": AppRouteAnimationType.fade,
                            "duration": 500,
                          },
                        );
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: AppColors.black(1)),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
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
                    "Create your donor account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: nameController,
                    cursorColor: AppColors.black(1),
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: AppColors.black(1)),
                      prefixIcon: Icon(Icons.person, color: AppColors.green(1)),

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
                      errorText: nameError
                          ? "Name must be atleast 3 char"
                          : null,
                    ),
                  ),
                  SizedBox(),
                  TextField(
                    controller: emailController,
                    cursorColor: AppColors.black(1),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: AppColors.black(1)),

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
                      errorText: emailError ? "Invalid email" : null,
                    ),
                  ),
                  SizedBox(),
                  TextField(
                    controller: passwdController,
                    cursorColor: AppColors.black(1),
                    obscureText: showPasswd,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: AppColors.black(1)),
                      prefixIcon: Icon(Icons.lock, color: AppColors.green(1)),
                      suffix: InkWell(
                        onTap: () => setState(() => showPasswd = !showPasswd),
                        child: Icon(
                          showPasswd
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                        ),
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
                      errorText: passwdError
                          ? "password must atleast be 8 char"
                          : null,
                    ),
                  ),
                  SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        nameError = nameController.text.length < 3;
                        emailError = !RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(emailController.text);
                        passwdError = passwdController.text.length < 8;
                      });

                      if (!nameError && !emailError && !passwdError) {
                        print("Sending data");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white(1),
                      backgroundColor: AppColors.green(0.8),
                      fixedSize: Size(240, 43),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    child: Text("Sign up", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
