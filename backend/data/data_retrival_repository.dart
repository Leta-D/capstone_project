import 'package:capstone_project/dummy_data_holder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

class DataRetrivalRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://capstone-api-dwzu.onrender.com",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String> getDonatedItems() async {
    try {
      final token = await storage.read(key: "accessToken");
      if (token == null) {
        throw Exception("Access token not found");
      }

      final response = await _dio.get(
        "/admin/donated-items",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print(response.data);
      return DummyDataHolder.donatedItems;
    } catch (e) {
      return e.toString();
    }
  }
}
