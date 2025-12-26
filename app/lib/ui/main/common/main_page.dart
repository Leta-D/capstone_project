import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/page_controller/page_controller_cubit.dart';
import 'package:capstone_project/logic/page_controller/user_role_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<PageControllerCubit, UserRoleState>(
      builder: (context, state) {
        if (state.role == UserRole.initial) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Invalid User State"),
              titleTextStyle: TextStyle(color: AppColors.red(1), fontSize: 22),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(Icons.error_outline, size: 80, color: AppColors.red(1)),
                  SizedBox(height: 10),
                  Text(
                    "The app user login is not in a valid state.",
                    style: TextStyle(color: AppColors.red(1), fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please, Login Again!",
                    style: TextStyle(color: AppColors.red(1), fontSize: 18),
                  ),
                  SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red(1),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 16, color: AppColors.white(1)),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Kind Bridge",
                    style: TextStyle(fontSize: 16, color: AppColors.black(0.6)),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: (state.currentIndex == 0)
              ? null
              : AppBar(
                  title: Text(
                    state.pages
                        .map((e) => e["label"])
                        .toList()[state.currentIndex],
                  ),
                  backgroundColor: AppColors.lightGreen(0.2),
                ),
          drawer:
              // Stack(
              //   children: [
              //     Container(
              //       width: screenSize.width / 1.24,
              //       decoration: BoxDecoration(
              //         color: AppColors.black(0.6),
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //     ),
              Drawer(
                // backgroundColor: AppColors.lightGreen(0.5),
                backgroundColor: const Color.fromRGBO(133, 179, 152, 0.9),
                shadowColor: AppColors.black(1),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      // color: AppColors.black(1),
                      child: Image.asset(
                        "assets/kindBridge_logo.png",
                        width: 200,
                        height: 150,
                        fit: BoxFit.contain,
                        // color: AppColors.green(1),
                      ),
                    ),
                    // Text(
                    //   "Kind Bridge",
                    //   style: TextStyle(
                    //     color: AppColors.white(1),
                    //     fontSize: 35,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(
                      height: 450,
                      child: ListView.builder(
                        // padding: EdgeInsets.only(top: 10),
                        itemCount: state.pages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8,
                            ),
                            child: ListTile(
                              onTap: () {
                                context
                                    .read<PageControllerCubit>()
                                    .changeMainPageIndex(index);
                                Navigator.pop(context);
                              },
                              iconColor: (state.currentIndex == index)
                                  ? AppColors.green(1)
                                  : AppColors.black(1),
                              textColor: (state.currentIndex == index)
                                  ? AppColors.white(1)
                                  : AppColors.black(1),
                              tileColor: (state.currentIndex == index)
                                  ? AppColors.green(0.31)
                                  : Colors.transparent,
                              titleTextStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: (state.currentIndex == index)
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                              ),
                              trailing: (state.currentIndex == index)
                                  ? Icon(
                                      CupertinoIcons.circle_filled,
                                      size: 10,
                                      color: const Color.fromARGB(
                                        255,
                                        7,
                                        255,
                                        102,
                                      ),
                                    )
                                  : null,
                              leading: Icon(
                                (state.currentIndex == index)
                                    ? state.pages[index]["iconT"]
                                    : state.pages[index]["icon"],
                              ),
                              title: Text(state.pages[index]["label"]),
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,

                          builder: (_) => AlertDialog(
                            backgroundColor: AppColors.white(0.8),
                            title: Text('Logout'),
                            content: const Text("Are you sure to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    color: AppColors.green(0.9),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.actorSelection,
                                      (route) => false,
                                      arguments: {
                                        'animation':
                                            AppRouteAnimationType.rotation,
                                        'duration': 500,
                                      },
                                    ),
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: AppColors.red(0.9),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      iconColor: AppColors.red(1),
                      leading: Icon(Icons.exit_to_app_rounded),
                      title: Text(
                        "Logout",
                        style: TextStyle(color: AppColors.red(1), fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
          //   ],
          // ),
          // backgroundColor: AppColors.white(0.88),
          body: state.pages
              .map((e) => e["target"])
              .toList()[state.currentIndex],
        );
      },
    );
  }
}
