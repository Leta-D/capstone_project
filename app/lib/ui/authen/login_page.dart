import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/auth/auth_bloc.dart';
import 'package:capstone_project/logic/auth/auth_event.dart';
import 'package:capstone_project/logic/auth/login_controller/login_cubit.dart';
import 'package:capstone_project/logic/auth/login_controller/login_state.dart';
import 'package:capstone_project/logic/page_controller/page_controller_cubit.dart';
import 'package:capstone_project/logic/page_controller/user_role_state.dart';
import 'package:capstone_project/ui/app_widgets/api_error_handler_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwdController = TextEditingController();

  bool passError = false;
  bool emailError = false;

  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          context.read<AuthBloc>().add(
            LoggedIn(
              accessToken: state.accessToken,
              refreshToken: state.refreshToken,
              role: state.role,
            ),
          );

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
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  (context).read<PageControllerCubit>().state.role ==
                          UserRole.donor
                      ? SizedBox(
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
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.signup,
                                    arguments: {
                                      "animation": AppRouteAnimationType.slide,
                                      "duration": 500,
                                    },
                                  );
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(color: AppColors.black(1)),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(height: screenSize.height - 20),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          "assets/kindBridge_logo.png",
                          width: 130,
                          height: 130,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // SizedBox(height: 10),
                      state is LoginFailState
                          ? apiErrorHandlerWidget(state.errorMessage)
                          : SizedBox.shrink(),
                      SizedBox(height: 15),
                      Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: emailController,
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
                          errorText: emailError ? "Invalid email" : null,
                        ),
                      ),
                      SizedBox(height: 35),
                      TextField(
                        controller: passwdController,
                        cursorColor: AppColors.black(1),
                        obscureText: !showPass,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: AppColors.black(1)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.green(1),
                          ),
                          suffix: InkWell(
                            onTap: () => setState(() => showPass = !showPass),
                            child: Icon(
                              showPass
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
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
                          errorText: passError
                              ? "password must atleast be 6 char"
                              : null,
                        ),
                      ),
                      SizedBox(height: 40),
                      (state is! LoginLoadingState)
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  emailError = !RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(emailController.text.trim());
                                  passError = passwdController.text.length < 6;
                                });

                                if (!emailError && !passError) {
                                  UserRole role = context
                                      .read<PageControllerCubit>()
                                      .state
                                      .role;

                                  context.read<LoginCubit>().login(
                                    email: emailController.text.trim(),
                                    password: passwdController.text.trim(),
                                    role: role == UserRole.donor
                                        ? "donor"
                                        : "ngo",
                                  );
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

                              child: Text(
                                "Sign in",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : CircularProgressIndicator(
                              color: AppColors.green(1),
                            ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
