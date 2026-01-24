import 'package:capstone_project/backend/map_model/map_data_to_model.dart';
import 'package:capstone_project/backend/model/item_model.dart';
import 'package:capstone_project/dummy_data_holder.dart';
import 'package:capstone_project/logic/donated_item_controller/donated_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonatedItemCubit extends Cubit<DonatedItemState> {
  DonatedItemCubit() : super(DonatedItemInitialState());

  Future<void> loadDonationItems(String type) async {
    emit(DonatedItemLoadingState());

    try {
      if (type == "not") {
        List<ItemModel> donatedItems = MapDataToModel.mapToItemModel(
          jsonData: DummyDataHolder.unavailableItems,
        );
        emit(DonatedItemLoadedState(donatedItems: donatedItems));
      } else if (type == "my") {
        List<ItemModel> donatedItems = MapDataToModel.mapToItemModel(
          jsonData: DummyDataHolder.myDonatedItems,
        );
        emit(DonatedItemLoadedState(donatedItems: donatedItems));
      } else {
        List<ItemModel> donatedItems = MapDataToModel.mapToItemModel(
          jsonData: DummyDataHolder.donatedItems,
        );
        emit(DonatedItemLoadedState(donatedItems: donatedItems));
      }
    } catch (e) {
      emit(DonatedItemErrorState(errorMessage: e.toString()));
    }
  }
}
