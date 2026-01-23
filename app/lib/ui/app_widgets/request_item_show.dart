import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:capstone_project/constant/app_colors.dart';

Widget requestedItemCard(int index, Map<String, dynamic> item) {
  return Container(
    width: 170,
    height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 250 : 210,
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.lightGreen(0.3),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Item image
        item['image'] == null || item['image'].isEmpty
            ? Container(
                color: AppColors.white(0.7),
                height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 160 : 120,
                child: Image.asset(
                  "assets/kindBridge_logo.png",
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                color: AppColors.white(0.7),
                height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 160 : 120,
                child: Image.asset(item['image'], fit: BoxFit.cover),
              ),

        const SizedBox(height: 12),

        // Item type
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            "Category: ${item['type'] ?? 'N/A'}",
            style: TextStyle(fontSize: 16, color: AppColors.black(1)),
          ),
        ),

        // Item name (scrollable if too long)
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: 165,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                item['itemName'] ?? "Unknown",
                style: TextStyle(fontSize: 14, color: AppColors.grey(1)),
              ),
            ),
          ),
        ),

        // Quantity and location
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 4),
          child: Text(
            "Quantity: ${item['quantityRequested'] ?? 0}",
            style: TextStyle(fontSize: 14, color: AppColors.green(0.8)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 2),
          child: Text(
            "Location: ${item['location'] ?? 'N/A'}",
            style: TextStyle(fontSize: 12, color: AppColors.grey(0.9)),
          ),
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
