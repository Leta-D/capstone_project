import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final ScrollController _controller = ScrollController();
  final PageController pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.5, // shows ~3 items
  );

  final noOfDashboardItem = 5;
  int currentPage = 1;
  void handlePageChange(int index) {
    if (index == 5) {
      // When user reaches the end; jump back to first item
      Future.delayed(Duration(milliseconds: 300), () {
        pageController.jumpToPage(0);
      });
    }
    setState(() {
      currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 170,
          pinned: true,
          floating: false,
          backgroundColor: const Color.fromARGB(255, 218, 248, 234),
          // backgroundColor: AppColors.lightGreen(0.2),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Donor Name',
              style: TextStyle(
                color: AppColors.black(1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: Stack(
              children: [
                Image.asset(
                  "assets/kindBridge_logo.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Container(color: AppColors.white(0.91)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.lightGreen(0.3),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: 'fromBackend/Users{id}/profile.jpg',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const CircularProgressIndicator(
                                  color: Color.fromARGB(224, 3, 241, 102),
                                  strokeWidth: 2,
                                );
                              },
                              errorWidget: (context, error, e) {
                                return const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color.fromARGB(255, 1, 165, 69),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.grey(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.format_quote_rounded,
                      color: AppColors.green(1),
                      size: 20,
                    ),
                  ),
                  Text("Today's Qoute", style: TextStyle(fontSize: 16)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.format_quote_rounded,
                      color: AppColors.green(1),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: _animatedDashboard(),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              trailing: Icon(CupertinoIcons.forward, color: AppColors.green(1)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Donation Requests", style: TextStyle(fontSize: 23)),
                  Row(
                    spacing: 5,
                    children: [
                      Container(
                        width: 85,
                        height: 2,
                        color: AppColors.green(0.6),
                      ),
                      Container(
                        width: 40,
                        height: 2,
                        color: AppColors.grey(0.6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return (index < 5)
                    ? _buildPopularDonationsItem(index)
                    : SizedBox(
                        width: 70,
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          elevation: 0,
                          color: AppColors.grey(0.3),
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {},
                            splashColor: AppColors.lightGreen(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.more_horiz),
                                Text(
                                  'More',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 40)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recent Donations", style: TextStyle(fontSize: 23)),
                Row(
                  spacing: 5,
                  children: [
                    Container(
                      width: 80,
                      height: 2,
                      color: AppColors.green(0.6),
                    ),
                    Container(width: 36, height: 2, color: AppColors.grey(0.6)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverGrid.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(left: 15),
            child: Text("Item $index"),
          ),
        ),

        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) => ListTile(title: Text('Item $index')),
        //     childCount: 20,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildPopularDonationsItem(int index) {
    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        elevation: 0,
        color: AppColors.lightGreen(0.31),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Center(
              child: Text(
                'Item ${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedDashboard() {
    Widget dashBoaredItemFrame(int index) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: (noOfDashboardItem != index)
              ? AppColors.lightGreen(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          // shape: BoxShape.rectangle,
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.green(0.3),
          //     blurRadius: 3,
          //     spreadRadius: 4,
          //   ),
          // ],
        ),
        child: (index != noOfDashboardItem)
            ? Image.asset(
                "assets/images/dashboard_image_${index + 1}.jpg",
                fit: BoxFit.cover,
              )
            : SizedBox(),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: pageController,
            itemCount: noOfDashboardItem + 1,
            onPageChanged: handlePageChange,
            itemBuilder: (context, index) {
              double distance = ((currentPage * 1.0) - index).abs();

              double targetScale = 1 - (distance * 0.3).clamp(0.0, 1.0);

              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: targetScale, end: targetScale),
                duration: Duration(milliseconds: 300),
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: InkWell(
                  onTap: () {
                    showDialog(
                      useRootNavigator: true,
                      useSafeArea: true,
                      context: context,
                      builder: (_) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 140.0,
                          horizontal: 30,
                        ),
                        child: dashBoaredItemFrame(index),
                      ),
                    );
                  },
                  child: dashBoaredItemFrame(index),
                ),
              );
            },
          ),
        ),

        // for the dotes below the dashboard items
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < 5; index++)
                Container(
                  width: 6,
                  height: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: (index == currentPage)
                        ? AppColors.green(0.8)
                        : AppColors.lightGreen(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
