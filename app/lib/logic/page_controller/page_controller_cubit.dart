import 'package:flutter/cupertino.dart';
import 'package:capstone_project/ui/main/donor/donor_home_page.dart';
import 'package:capstone_project/ui/main/common/notifications_page.dart';
import 'package:capstone_project/ui/main/common/profile_page.dart';
import 'package:capstone_project/ui/main/donor/donate_page.dart';
import 'package:capstone_project/ui/main/donor/my_donations_page.dart';
import 'package:capstone_project/ui/main/ngo/find_donations_page.dart';
import 'package:capstone_project/ui/main/ngo/map_page.dart';
import 'package:capstone_project/ui/main/ngo/ngo_home_page.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/logic/page_controller/user_role_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageControllerCubit extends Cubit<UserRoleState> {
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

  PageControllerCubit()
    : super(UserRoleState(role: UserRole.initial, currentIndex: 0, pages: []));

  void setNgo() {
    emit(
      UserRoleState(role: UserRole.ngo, currentIndex: 0, pages: ngoDrawerPages),
    );
  }

  void setDonor() {
    emit(
      UserRoleState(
        role: UserRole.donor,
        currentIndex: 0,
        pages: donorDrawerPages,
      ),
    );
  }

  void changeMainPageIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
