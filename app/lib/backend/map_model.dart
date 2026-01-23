import 'dart:convert';
import 'package:capstone_project/backend/model/item_model.dart';
import 'package:capstone_project/backend/model/user_model.dart';

class MapDataToModel {
  static List<ItemModel> mapToItemModel({required String jsonData}) {
    dynamic decodedJsonData = jsonDecode(jsonData);

    final List<ItemModel> items = ((decodedJsonData) as List)
        .map<ItemModel>((e) => ItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return items;
  }

  static UserModel mapToUserModel({required String jsonData}) {
    dynamic decodedJsonData = jsonDecode(jsonData);
    UserModel user = UserModel.fromJson(decodedJsonData);

    return user;
  }
}
