import 'package:capstone_project/backend/data/donate_item_repository.dart';
import 'package:capstone_project/logic/donation_controller/item_donation_controller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDonationControllerCubit extends Cubit<ItemDonationControllerState> {
  ItemDonationControllerCubit() : super(ItemDonationInitialState());

  final DonateItemRepository _donateItemRepository = DonateItemRepository();

  void donateItem({
    required String itemName,
    required String itemType,
    required int numberOfItems,
    required String description,
    required String street,
    required String city,
    required String region,
    required String latitude,
    required String longitude,
    String itemImageUrl = "",
  }) async {
    emit(ItemDonationLoadingState());
    try {
      await _donateItemRepository
          .sendDonationItem(
            itemName: itemName,
            itemType: itemType,
            numberOfItems: numberOfItems,
            description: description,
            street: street,
            city: city,
            region: region,
            latitude: latitude,
            longitude: longitude,
            itemImageUrl: itemImageUrl,
          )
          .then((response) {
            if (response == 201) {
              emit(ItemDonationDonatedState());
            } else {
              print("Error code : =============$response=====================");
              throw "Error uploading this is from cubit";
            }
          });
    } catch (e) {
      print("Error code : ===============${e.toString()}===================");
      emit(ItemDonationErrorState(errorMessage: e.toString()));
    }
  }
}
