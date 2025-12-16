import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Transform.rotate(
          angle: -88.6,
          child: Image.asset(
            "assets/kindBridge_logo.png",
            fit: BoxFit.contain,
            height: screenSize.height - 150,
            width: screenSize.width - 20,
          ),
        ),
        Container(color: AppColors.white(0.85)),
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CircleAvatar(radius: 75),
              ),
              SizedBox(height: 20),
              Text(
                "User Name",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.green(1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 1,
                  ),
                  child: Text(
                    "Donor",
                    style: TextStyle(
                      color: AppColors.white(1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(color: AppColors.lightGreen(0.2)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 3,
                      ),
                      child: ListTile(
                        leading: Icon(
                          CupertinoIcons.mail_solid,
                          color: AppColors.green(0.9),
                        ),
                        title: Text("Examle@gmail.com"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 3,
                      ),
                      child: ListTile(
                        leading: Icon(
                          CupertinoIcons.mail_solid,
                          color: AppColors.green(0.9),
                        ),
                        title: Text("Examle@gmail.com"),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: showDetails ? 120 : 0,
                      padding: showDetails
                          ? const EdgeInsets.all(16)
                          : EdgeInsets.zero,
                      child: showDetails
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 3,
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      CupertinoIcons.mail_solid,
                                      color: AppColors.green(0.9),
                                    ),
                                    title: Text("Examle@gmail.com"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 3,
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      CupertinoIcons.mail_solid,
                                      color: AppColors.green(0.9),
                                    ),
                                    title: Text("Examle@gmail.com"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 3,
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      CupertinoIcons.mail_solid,
                                      color: AppColors.green(0.9),
                                    ),
                                    title: Text("Examle@gmail.com"),
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    showDetails = !showDetails;
                  });
                },
                label: Text(!showDetails ? "Show more" : "show less"),
                icon: Icon(
                  !showDetails
                      ? CupertinoIcons.chevron_compact_down
                      : CupertinoIcons.chevron_compact_up,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
