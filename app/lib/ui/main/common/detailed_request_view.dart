import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailedRequestView extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailedRequestView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    // Parse the createdAt string to DateTime safely
    DateTime? createdAt;
    try {
      createdAt = DateTime.parse(item['createdAt']);
    } catch (_) {
      createdAt = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        backgroundColor: AppColors.lightGreen(0.3),
      ),
      body: Stack(
        children: [
          /// Background decorations
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

          /// Content
          SingleChildScrollView(
            child: Container(
              height: screenSize.height,
              color: AppColors.white(0.9),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Item image (optional placeholder)
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey(0.7),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: item['image'] != null
                            ? AssetImage(item['image'])
                            : AssetImage("assets/kindBridge_logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Item name
                  Text(
                    item['itemName'] ?? "Unknown Item",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Item type
                  Text(
                    "Category: ${item['type'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  /// Quantity Requested badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Quantity Requested: ${item['quantityRequested'] ?? 0}",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black(1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Description
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['description'] ?? "No description",
                    style: const TextStyle(fontSize: 15),
                  ),

                  const SizedBox(height: 20),

                  /// Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        item['location'] ?? "Unknown",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Created date
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        createdAt != null
                            ? DateFormat.yMMMMd().add_jm().format(createdAt)
                            : "N/A",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
