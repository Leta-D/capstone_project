import 'package:capstone_project/backend/model/item_model.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/material.dart';

class DetailedItemView extends StatelessWidget {
  // ItemModel item;
  // DetailedItemView({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text("Item Details")),
      body: Stack(
        children: [
          SizedBox(
            height: screenSize.height / 2,
            child: RotatedBox(
              quarterTurns: 1,
              child: Image.asset("assets/kindBridge_logo.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: screenSize.height / 2,
              child: RotatedBox(
                quarterTurns: 3,
                child: Image.asset("assets/kindBridge_logo.png"),
              ),
            ),
          ),
          Container(
            color: Colors.white24.withOpacity(0.9),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              children: [
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: AppColors.grey(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Text("Item Name", style: TextStyle(fontSize: 20)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.green(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Availability",
                    style: TextStyle(fontSize: 16, color: AppColors.black(1)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
