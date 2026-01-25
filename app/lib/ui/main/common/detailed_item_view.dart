import 'package:capstone_project/backend/model/item_model.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/page_controller/page_controller_cubit.dart';
import 'package:capstone_project/logic/page_controller/user_role_state.dart';
import 'package:capstone_project/logic/send_request/send_accept_request_cubit.dart';
import 'package:capstone_project/logic/send_request/send_accept_request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailedItemView extends StatefulWidget {
  final ItemModel item;

  const DetailedItemView({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _DetailedItemViewState(item);
}

class _DetailedItemViewState extends State<DetailedItemView> {
  final ItemModel item;

  _DetailedItemViewState(this.item);

  @override
  void initState() {
    context.read<SendAcceptRequestCubit>().resetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
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
              color: Colors.white.withOpacity(0.9),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Item image
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey(0.7),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(item.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Item name
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Item type
                  Text(
                    "Category: ${item.type}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  /// Availability badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: item.available
                          ? AppColors.green(0.6)
                          : Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.available ? "Available" : "Donation Accepted",
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
                  Text(item.description, style: const TextStyle(fontSize: 15)),

                  const SizedBox(height: 20),

                  /// Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 6),
                      Text(item.location, style: const TextStyle(fontSize: 15)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat.yMMMMd().add_jm().format(item.createdAt),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  context.read<PageControllerCubit>().state.role ==
                              UserRole.ngo &&
                          item.available
                      ? Center(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    BlocBuilder<
                                      SendAcceptRequestCubit,
                                      SendAcceptRequestState
                                    >(
                                      builder: (context, state) {
                                        if (state
                                            is SendAcceptRequestInitialState) {
                                          context
                                              .read<SendAcceptRequestCubit>()
                                              .sendRequest();
                                          return AlertDialog(
                                            title: Text("Sending Request..."),
                                            content: SizedBox(
                                              width: 60,
                                              height: 55,
                                              child: CircularProgressIndicator(
                                                color: AppColors.green(0.8),
                                              ),
                                            ),
                                          );
                                        } else if (state
                                            is SendAcceptRequestLoadingState) {
                                          return AlertDialog(
                                            title: Text("Sending Request..."),
                                            content: SizedBox(
                                              width: 60,
                                              height: 55,
                                              child: CircularProgressIndicator(
                                                color: AppColors.green(0.8),
                                              ),
                                            ),
                                          );
                                        } else if (state
                                            is SendAcceptRequestLoadedState) {
                                          return AlertDialog(
                                            iconColor: AppColors.grey(0.9),
                                            title: Text(
                                              "Request Sent Successfully",
                                              style: TextStyle(
                                                color: AppColors.green(0.9),
                                              ),
                                            ),
                                            content: Text(
                                              "Your request has been sent.",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(
                                                    color: AppColors.green(0.9),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else if (state
                                            is SendAcceptRequestErrorState) {
                                          return Center(
                                            child: Text(
                                              "Error Sending Request",
                                            ),
                                          );
                                        }
                                        return SizedBox.shrink();
                                      },
                                    ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.white(1),
                              backgroundColor: AppColors.green(0.8),
                              fixedSize: Size(200, 43),
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Request Item",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ).animate(
                          effects: [
                            FlipEffect(duration: Duration(milliseconds: 800)),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
