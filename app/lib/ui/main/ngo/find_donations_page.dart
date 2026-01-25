import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/backend/model/item_model.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/donated_item_controller/donated_item_cubit.dart';
import 'package:capstone_project/logic/donated_item_controller/donated_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindDonationsPage extends StatefulWidget {
  const FindDonationsPage({super.key});

  @override
  State<FindDonationsPage> createState() => _FindDonationsPageState();
}

class _FindDonationsPageState extends State<FindDonationsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<DonatedItemCubit, DonatedItemState>(
          listener: (context, state) {
            if (state is DonatedItemInitialState) {
              context.read<DonatedItemCubit>().loadDonationItems("ngo");
            }
            // if (context.read<ProfileCubit>.state == initial)
          },
          builder: (context, state) {
            if (state is DonatedItemInitialState) {
              context.read<DonatedItemCubit>().loadDonationItems("ngo");
            }
            if (state is DonatedItemLoadingState ||
                state is DonatedItemInitialState) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    CircularProgressIndicator(
                      color: AppColors.green(0.8),
                      backgroundColor: AppColors.lightGreen(0.4),
                    ),
                    Text(
                      "Fetching data....",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DonatedItemLoadedState) {
              return Column(
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 270,
                        child:
                            SearchAnchor(
                              builder: (context, searchController) {
                                return SearchBar(
                                  controller: searchController,
                                  elevation: const WidgetStatePropertyAll(1),
                                  backgroundColor: WidgetStatePropertyAll(
                                    AppColors.white(0.6),
                                  ),
                                  shadowColor: WidgetStatePropertyAll(
                                    AppColors.lightGreen(0.7),
                                  ),
                                  hintText: "Search...",
                                  leading: Icon(
                                    Icons.search,
                                    color: AppColors.green(1),
                                    size: 30,
                                  ),
                                  onTap: () => searchController.openView(),
                                  onChanged: (_) => searchController.openView(),
                                );
                              },
                              suggestionsBuilder: (context, searchController) {
                                final query = searchController.text
                                    .toLowerCase();

                                final suggestions = state.donatedItems.where((
                                  item,
                                ) {
                                  return item.name.toLowerCase().contains(
                                        query,
                                      ) ||
                                      item.type.toLowerCase().contains(query);
                                }).toList();

                                return suggestions.map((item) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.inventory_2,
                                      color: AppColors.green(1),
                                    ),
                                    title: Text(item.name),
                                    subtitle: Text(item.type),
                                    trailing: Icon(
                                      item.available
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: item.available
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    onTap: () {
                                      searchController.closeView(item.name);

                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.detailedItemView,
                                        arguments: {"selected_item": item},
                                      );
                                    },
                                  );
                                }).toList();
                              },
                            ).animate(
                              delay: Duration(milliseconds: 200),
                              effects: [
                                FlipEffect(
                                  duration: Duration(milliseconds: 400),
                                ),
                              ],
                            ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Sort"),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 8),
                      child: TextButton.icon(
                        onPressed: () {
                          context.read<DonatedItemCubit>().loadDonationItems(
                            "ngo",
                          );
                        },

                        icon: Icon(
                          Icons.replay_outlined,
                          color: AppColors.green(0.8),
                        ),
                        label: Text(
                          "Refresh",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blue(1),

                            decorationStyle: TextDecorationStyle.double,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5),
                  Container(
                    color: AppColors.lightGreen(0.13),
                    height: 600,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 20,
                        // runSpacing: 20,
                        children: List.generate(
                          state.donatedItems.length,
                          (index) => InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.detailedItemView,
                                arguments: {
                                  "selected_item": state.donatedItems[index],
                                },
                              );
                            },
                            child: _itemShowCard(
                              index,
                              state.donatedItems[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Image.asset(
                    "assets/error_images/unknown.png",
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      (state as DonatedItemErrorState).errorMessage,
                      style: TextStyle(
                        color: AppColors.red(1),
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Please refresh the page",
                    style: TextStyle(color: AppColors.grey(1), fontSize: 14),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<DonatedItemCubit>().loadDonationItems("ngo");
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white(1),
                      backgroundColor: AppColors.green(0.8),
                      fixedSize: Size(140, 43),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      Icons.replay_outlined,
                      color: AppColors.white(1),
                    ),
                    label: Text("refresh", style: TextStyle(fontSize: 18)),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _itemShowCard(int index, ItemModel item) {
    return Container(
      width: 170,
      height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 250 : 210,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightGreen(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.white(0.7),
            height: (index + 1 % 4 == 0 || index + 1 % 4 == 1) ? 160 : 120,
            child: Image.asset(item.image),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "Type: ${item.type}",
              style: TextStyle(fontSize: 18, color: AppColors.black(1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: 165,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 14, color: AppColors.grey(1)),
                ),
              ),
            ),
          ),
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                item.available ? Icons.pages : Icons.check_circle_outline,
                color: AppColors.blue(1),
              ),
              Text(
                item.available ? "Pending" : "Donated",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.green(1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),
    ).animate(
      delay: Duration(milliseconds: 300),
      effects: [
        ScaleEffect(
          duration: Duration(
            milliseconds: (index + 1 % 4 == 0 || index + 1 % 4 == 1)
                ? 500
                : 300,
          ),
        ),
      ],
    );
  }
}
