import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/material.dart';

Widget animatedDashboard(PageController pageController) {
  // final widgetController = Get.put(WidgetController());
  final noOfDashboardItem = 5;
  double currentPage = 0;
  void handlePageChange(int index) {
    if (index == 5) {
      // When user reaches the end → jump back to first item
      Future.delayed(Duration(milliseconds: 400), () {
        pageController.jumpToPage(0);
      });
    }
  }

  Widget dashBoaredItemFrame(int index) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: (noOfDashboardItem != index)
            ? AppColors.green(0.4)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
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
            double distance = currentPage - index;

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
            for (var item in [0, 1, 2, 3, 4])
              Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: (item == 1)
                      ? AppColors.green(0.8)
                      : AppColors.green(0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}
