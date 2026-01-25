import 'package:flutter/material.dart';

Widget ngoStatisticDataShow({
  required String label,
  required double percentage,
  required Color color,
  required IconData icon,
}) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: CircularProgressIndicator(
              value: percentage / 3,
              strokeWidth: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          Text(
            "${(percentage * 100).toInt()}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Icon(icon, color: color),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 14)),
    ],
  );
}
