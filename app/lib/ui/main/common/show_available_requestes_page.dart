import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/dummy_data_holder.dart';
import 'package:capstone_project/ui/app_widgets/request_item_show.dart';
import 'package:capstone_project/ui/main/common/detailed_request_view.dart';
import 'package:flutter/material.dart';

class ShowAvailableRequestsPage extends StatelessWidget {
  const ShowAvailableRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Requested Donations"),
        backgroundColor: AppColors.lightGreen(0.3),
      ),
      body: Stack(
        children: [
          // Background decorations
          SizedBox(
            height: screenSize.height / 2,
            child: RotatedBox(
              quarterTurns: 1,
              child: Image.asset(
                "assets/kindBridge_logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: screenSize.height / 2,
              child: RotatedBox(
                quarterTurns: 3,
                child: Image.asset(
                  "assets/kindBridge_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content overlay
          Container(
            color: AppColors.white(0.9),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: DummyDataHolder.donationRequests.length,
              itemBuilder: (context, index) {
                final item = DummyDataHolder.donationRequests[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailedRequestView(item: item),
                    ),
                  ),
                  child: requestedItemCard(index, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
