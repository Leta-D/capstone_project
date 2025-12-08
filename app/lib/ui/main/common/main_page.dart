import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/ui/main/common/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> donorDrawerPage = [
    {
      "label": "Home",
      "icon": CupertinoIcons.home,
      "iconT": Icons.home,
      "target": HomePage(),
    },
    {
      "label": "Donate",
      "icon": Icons.volunteer_activism_outlined,
      "iconT": Icons.volunteer_activism,
      "target": HomePage(),
    },
    {
      "label": "My Donations",
      "icon": Icons.card_giftcard_outlined,
      "iconT": CupertinoIcons.gift_fill,
      "target": HomePage(),
    },
    {
      "label": "Notifications",
      "icon": CupertinoIcons.bell,
      "iconT": CupertinoIcons.bell_fill,
      "target": HomePage(),
    },
    {
      "label": "Profile",
      "icon": Icons.person_outline_outlined,
      "iconT": Icons.person,
      "target": HomePage(),
    },
  ];
  final List<Map<String, dynamic>> ngoDrawerPages = [
    {
      "label": "Home",
      "icon": CupertinoIcons.home,
      "iconT": Icons.home,
      "target": HomePage(),
    },
    {
      "label": "Find Donations",
      "icon": Icons.search,
      "iconT": CupertinoIcons.search_circle_fill,
      "target": HomePage(),
    },
    {
      "label": "Map",
      "icon": CupertinoIcons.map_pin_ellipse,
      "iconT": CupertinoIcons.map_fill,
      "target": HomePage(),
    },
    {
      "label": "Notifications",
      "icon": CupertinoIcons.bell,
      "iconT": CupertinoIcons.bell_fill,
      "target": HomePage(),
    },
    {
      "label": "Profile",
      "icon": Icons.person_outline_outlined,
      "iconT": Icons.person,
      "target": HomePage(),
    },
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ngoDrawerPages.map((e) => e["label"]).toList()[currentPageIndex],
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.lightGreen(0.35),
        shadowColor: AppColors.black(1),

        child: Column(
          children: [
            ClipRRect(
              child: Image.asset(
                "assets/kindBridgeLogo.png",
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                // color: AppColors.green(1),
              ),
            ),
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
                          ? AppColors.green(0.21)
                          : Colors.transparent,
                      titleTextStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: (currentPageIndex == index)
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                      trailing: (currentPageIndex == index)
                          ? Icon(CupertinoIcons.circle_filled, size: 10)
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
          ],
        ),
      ),
      body: ngoDrawerPages.map((e) => e["target"]).toList()[currentPageIndex],
    );
  }
}
