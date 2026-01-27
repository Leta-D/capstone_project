import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/page_controller/page_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActorSelection extends StatefulWidget {
  const ActorSelection({super.key});
  @override
  createState() => _ActorSelectionState();
}

class _ActorSelectionState extends State<ActorSelection> {
  int selection = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exit = await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              "Exit App",
              style: TextStyle(color: AppColors.red(0.6), fontSize: 22),
            ),
            content: Text("Are you sure you want to exit?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No", style: TextStyle(color: AppColors.green(1))),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Yes", style: TextStyle(color: AppColors.red(1))),
              ),
            ],
          ),
        );
        return exit;
      },

      child: Scaffold(
        // appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/kindBridge_logo.png",
                    width: 130,
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text("KindBridge"),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Your Role',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black(1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Please choose how you would like to use the application.',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.grey(1),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(),
                for (int x = 0; x < 2; x++)
                  InkWell(
                    splashColor: AppColors.lightGreen(0.2),
                    onTap: () => setState(() => selection = x),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOutQuad,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: (selection == x) ? 120 : 100,
                      decoration: BoxDecoration(
                        color: (selection == x)
                            ? AppColors.lightGreen(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: BoxBorder.all(
                          width: 2,
                          color: (selection == x)
                              ? AppColors.lightGreen(0.8)
                              : AppColors.lightGreen(0.3),
                        ),
                      ),
                      child: Row(
                        spacing: 30,
                        children: [
                          ClipOval(
                            child: Container(
                              color: (selection == x)
                                  ? AppColors.lightGreen(0.4)
                                  : Colors.transparent,
                              width: (selection == x) ? 60 : 40,
                              height: (selection == x) ? 60 : 40,
                              child: Image.asset(
                                ["assets/charity.png", "assets/ngo.png"][x],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ["Doner", "NGO"][x],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              (selection == x)
                                  ? SizedBox(
                                      width: 200,
                                      child: Text(
                                        [
                                          "I want to donat items or food.",
                                          "A registered Non-Governmental Organization.",
                                        ][x],
                                        style: TextStyle(
                                          color: AppColors.grey(1),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    (selection == 0)
                        ? (context).read<PageControllerCubit>().setDonor()
                        : (context).read<PageControllerCubit>().setNgo();
                    Navigator.pushNamed(
                      context,
                      AppRoutes.login,
                      arguments: {
                        'animation': AppRouteAnimationType.slide,
                        'duration': 600,
                      },
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white(1),
                    backgroundColor: AppColors.green(0.8),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 1),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: Text("Continue", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
