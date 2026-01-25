import 'package:capstone_project/logic/send_request/send_accept_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendAcceptRequestCubit extends Cubit<SendAcceptRequestState> {
  SendAcceptRequestCubit() : super(SendAcceptRequestInitialState());

  void sendRequest() {
    emit(SendAcceptRequestLoadingState());
    Future.delayed(Duration(seconds: 5), () {
      emit(SendAcceptRequestLoadedState());
    });
  }

  void resetState() {
    emit(SendAcceptRequestInitialState());
  }
}
