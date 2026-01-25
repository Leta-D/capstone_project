abstract class ItemDonationControllerState {}

class ItemDonationInitialState extends ItemDonationControllerState {}

class ItemDonationLoadingState extends ItemDonationControllerState {}

class ItemDonationDonatedState extends ItemDonationControllerState {}

class ItemDonationErrorState extends ItemDonationControllerState {
  String? errorMessage;

  ItemDonationErrorState({required this.errorMessage});
}
