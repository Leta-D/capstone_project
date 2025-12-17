import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/ui/main/donor/donor_home_page.dart';
import 'package:capstone_project/ui/main/common/notifications_page.dart';
import 'package:capstone_project/ui/main/common/profile_page.dart';
import 'package:capstone_project/ui/main/donor/donate_page.dart';
import 'package:capstone_project/ui/main/donor/my_donations_page.dart';
import 'package:capstone_project/ui/main/ngo/find_donations_page.dart';
import 'package:capstone_project/ui/main/ngo/map_page.dart';
import 'package:capstone_project/ui/main/ngo/ngo_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> donorDrawerPages = [
    {
      "label": "Home",
      "icon": CupertinoIcons.home,
      "iconT": Icons.home,
      "target": DonorHomePage(),
    },
    {
      "label": "Donate",
      "icon": Icons.volunteer_activism_outlined,
      "iconT": Icons.volunteer_activism,
      "target": DonatePage(),
    },
    {
      "label": "My Donations",
      "icon": Icons.card_giftcard_outlined,
      "iconT": CupertinoIcons.gift_fill,
      "target": MyDonationsPage(),
    },
    {
      "label": "Notifications",
      "icon": CupertinoIcons.bell,
      "iconT": CupertinoIcons.bell_fill,
      "target": NotificationsPage(),
    },
    {
      "label": "Profile",
      "icon": Icons.person_outline_outlined,
      "iconT": Icons.person,
      "target": ProfilePage(),
    },
  ];

  final List<Map<String, dynamic>> ngoDrawerPages = [
    {
      "label": "Home",
      "icon": CupertinoIcons.home,
      "iconT": Icons.home,
      "target": NgoHomePage(),
    },
    {
      "label": "Find Donations",
      "icon": Icons.search,
      "iconT": CupertinoIcons.search_circle_fill,
      "target": FindDonationsPage(),
    },
    {
      "label": "Map",
      "icon": CupertinoIcons.map_pin_ellipse,
      "iconT": CupertinoIcons.map_fill,
      "target": MapPage(),
    },
    {
      "label": "Notifications",
      "icon": CupertinoIcons.bell,
      "iconT": CupertinoIcons.bell_fill,
      "target": NotificationsPage(),
    },
    {
      "label": "Profile",
      "icon": Icons.person_outline_outlined,
      "iconT": Icons.person,
      "target": ProfilePage(),
    },
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: (currentPageIndex == 0)
          ? null
          : AppBar(
              title: Text(
                ngoDrawerPages
                    .map((e) => e["label"])
                    .toList()[currentPageIndex],
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
                    itemCount: ngoDrawerPages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8,
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              currentPageIndex = index;
                            });
                            Navigator.pop(context);
                          },
                          iconColor: (currentPageIndex == index)
                              ? AppColors.green(1)
                              : AppColors.black(1),
                          textColor: (currentPageIndex == index)
                              ? AppColors.white(1)
                              : AppColors.black(1),
                          tileColor: (currentPageIndex == index)
                              ? AppColors.green(0.31)
                              : Colors.transparent,
                          titleTextStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: (currentPageIndex == index)
                                ? FontWeight.bold
                                : FontWeight.w400,
                          ),
                          trailing: (currentPageIndex == index)
                              ? Icon(
                                  CupertinoIcons.circle_filled,
                                  size: 10,
                                  color: const Color.fromARGB(255, 7, 255, 102),
                                )
                              : null,
                          leading: Icon(
                            (currentPageIndex == index)
                                ? ngoDrawerPages[index]["iconT"]
                                : ngoDrawerPages[index]["icon"],
                          ),
                          title: Text(ngoDrawerPages[index]["label"]),
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
                            onPressed: () => Navigator.pop(context),
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
      body: ngoDrawerPages.map((e) => e["target"]).toList()[currentPageIndex],
    );
  }
}
