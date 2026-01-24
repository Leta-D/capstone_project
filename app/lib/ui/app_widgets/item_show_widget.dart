import 'package:capstone_project/backend/model/item_model.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget itemShowWidgetCard(int index, ItemModel item) {
  return Container(
    width: 170,
    height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 250 : 210,
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.lightGreen(0.3),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        item.image.isEmpty
            ? Container(
                color: AppColors.white(0.7),
                height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 160 : 120,
                child: Image.asset("assets/kindBridge_logo.png"),
              )
            : Container(
                color: AppColors.white(0.7),
                height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 160 : 120,
                // child: Image.asset("assets/kindBridge_logo.png"),
                child: Image.asset(item.image, fit: BoxFit.cover),
              ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            "Type: ${item.type}",
            style: TextStyle(fontSize: 18, color: AppColors.black(1)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: 165,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                item.name,
                style: TextStyle(fontSize: 14, color: AppColors.grey(1)),
              ),
            ),
          ),
        ),
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              item.available ? Icons.pages : Icons.check_circle_outline,
              color: AppColors.blue(1),
            ),
            Text(
              item.available ? "Pending" : "Donated",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.green(1),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ],
    ),
  ).animate(
    delay: Duration(milliseconds: 300),
    effects: [
      ScaleEffect(
        duration: Duration(
          milliseconds: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 500 : 300,
        ),
      ),
    ],
  );
}
