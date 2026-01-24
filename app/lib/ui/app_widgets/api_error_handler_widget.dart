import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget apiErrorHandlerWidget(String error) {
  Map<String, List<String>> imagesUrls = {
    "400": ["assets/error_images/usedEmail.png", "Email already in use"],
    "403": ["assets/error_images/404.png", "404 ERROR"],
    "402": [
      "assets/error_images/network.png",
      "Network error, please check your network and try again.",
    ],
    "404": [
      "assets/error_images/noUser.png",
      "USER NOT FOUND please create Account",
    ],
    "401": ["assets/error_images/password.png", "Invalid password"],
  };

  print(
    "========================================================================",
  );
  print(error);

  return Animate(
    delay: Duration(milliseconds: 200),
    effects: [
      FlipEffect(curve: Curves.easeIn),
      ShakeEffect(delay: Duration(milliseconds: 350)),
    ],

    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.red(0.09),
        // border: Border.all(color: AppColors.red(1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset(
            (imagesUrls.keys.contains(error.split(":")[1].trim()))
                ? imagesUrls[error.split(":")[1].trim()]![0]
                : "assets/error_images/unknown.png",
            width: 80,
            height: 80,
          ),

          Row(
            children: [
              Icon(Icons.error, color: AppColors.red(1)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  (imagesUrls.keys.contains(error.split(":")[1].trim()))
                      ? imagesUrls[error.split(":")[1].trim()]![1]
                      : error,
                  style: TextStyle(color: AppColors.red(1), fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
