import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DonateItemRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://capstone-api-dwzu.onrender.com",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<int?> sendDonationItem({
    required String itemName,
    required String itemType,
    required int numberOfItems,
    required String description,
    required String street,
    required String city,
    required String region,
    required String latitude,
    required String longitude,
    String? itemImageUrl, // optional
  }) async {
    try {
      String? accessToken = await storage.read(key: 'accessToken');

      final formMap = {
        "body": jsonEncode({
          "itemName": itemName,
          "itemType": itemType,
          "numberOfItems": numberOfItems,
          "description": description.isEmpty ? "No description" : description,
          "street": street,
          "city": city,
          "region": region,
          "latitude": latitude,
          "longitude": longitude,
        }),
      };

      // Add image only if exists
      // if (itemImageUrl != null && itemImageUrl.isNotEmpty) {
      //   formMap["item"] = await MultipartFile.fromFile(
      //     itemImageUrl,
      //     filename: itemImageUrl.split('/').last,
      //   ).toString();
      // }

      final formData = FormData.fromMap(formMap);

      // Send request
      Response response = await _dio.post(
        "/users/donate",
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      print("Donation succeeded");
      print(response.data);
      print("Status code : ${response.statusCode}");

      return response.statusCode;
    } on DioException catch (e) {
      print("Upload failed");
      print("Status: ${e.response?.statusCode}");
      print("Message: ${e.response?.data}");
      throw e.response?.statusCode ?? 500;
    }
  }
}
