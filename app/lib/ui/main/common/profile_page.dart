import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController(text: "User Name");
  final emailController = TextEditingController(text: "Example@gmail.com");

  bool nameError = false;
  bool emailError = false;

  bool showPasswd = false;
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Stack(
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
          Container(
            color: AppColors.white(0.85),
            width: screenSize.width,
            height: screenSize.height,
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: AppColors.lightGreen(0.3),
                    foregroundColor: AppColors.green(0.5),
                    child: Icon(CupertinoIcons.person_solid, size: 50),
                  ),
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
                        height: showDetails ? 200 : 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: showDetails ? 20 : 0,
                        ),
                        child: showDetails
                            ? Column(
                                children: [
                                  for (var item in [
                                    "Examle@gmail.com",
                                    "Examle@gmail.com",
                                    "Examle@gmail.com",
                                  ])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 3.0,
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
                  label: Text(
                    !showDetails ? "show more" : "show less",
                    style: TextStyle(color: AppColors.black(1), fontSize: 16),
                  ),
                  icon: Icon(
                    !showDetails
                        ? CupertinoIcons.chevron_compact_down
                        : CupertinoIcons.chevron_compact_up,
                    color: AppColors.green(1),
                    size: 18,
                  ),
                  // style: ButtonStyle(
                  //   side: WidgetStatePropertyAll(
                  //     BorderSide(color: AppColors.green(1)),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 15),
            child: Align(
              alignment: Alignment(1, -1),
              child: FloatingActionButton(
                backgroundColor: AppColors.lightGreen(0.17),
                elevation: 0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog.adaptive(
                      scrollable: true,
                      backgroundColor: AppColors.white(0.9),
                      icon: Icon(
                        CupertinoIcons.pencil_ellipsis_rectangle,
                        color: AppColors.green(1),
                      ),
                      title: Text("Edit Profile"),
                      content: SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Text(
                              "Changing the following data will update your profile!",
                            ),
                            SizedBox(height: 40),
                            TextField(
                              controller: nameController,
                              cursorColor: AppColors.black(1),
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(
                                  color: AppColors.black(1),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.green(1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.green(1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.green(1),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.red(1),
                                  ),
                                ),
                                errorText: nameError
                                    ? "Name must be atleast 3 char"
                                    : null,
                              ),
                            ),
                            SizedBox(height: 30),
                            TextField(
                              controller: emailController,
                              cursorColor: AppColors.black(1),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: AppColors.black(1),
                                ),

                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  color: AppColors.green(1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.green(1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.green(1),
                                  ),
                                ),

                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.red(1),
                                  ),
                                ),
                                errorText: emailError ? "Invalid email" : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: AppColors.red(0.9),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Change',
                            style: TextStyle(
                              color: AppColors.green(0.9),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: "Edit Profile",
                splashColor: AppColors.lightGreen(0.7),
                child: Icon(
                  CupertinoIcons.pencil_ellipsis_rectangle,
                  size: 30,
                  color: AppColors.green(1),
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(color: AppColors.green(1), blurRadius: 5),
                    Shadow(color: AppColors.lightGreen(1), blurRadius: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
