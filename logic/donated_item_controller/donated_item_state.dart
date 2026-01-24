import 'package:capstone_project/backend/model/item_model.dart';

abstract class DonatedItemState {}

class DonatedItemInitialState extends DonatedItemState {}

class DonatedItemLoadingState extends DonatedItemState {}

class DonatedItemLoadedState extends DonatedItemState {
  final List<ItemModel> donatedItems;

  DonatedItemLoadedState({required this.donatedItems});
}

class DonatedItemErrorState extends DonatedItemState {
  final String errorMessage;

  DonatedItemErrorState({required this.errorMessage});
}
