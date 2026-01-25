import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_project/app_routes/app_routes.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:capstone_project/logic/donated_item_controller/donated_item_cubit.dart';
import 'package:capstone_project/logic/donated_item_controller/donated_item_state.dart';
import 'package:capstone_project/logic/profile_controller/profile_controller_cubit.dart';
import 'package:capstone_project/logic/profile_controller/profile_controller_state.dart';
import 'package:capstone_project/ui/app_widgets/item_show_widget.dart';
import 'package:capstone_project/ui/main/ngo/ngo_statistic_data_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NgoHomePage extends StatefulWidget {
  const NgoHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _NgoHomePageState();
}

class _NgoHomePageState extends State<NgoHomePage> {
  @override
  void initState() {
    context.read<ProfileControllerCubit>().fetchProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
          builder: (context, state) {
            return SliverAppBar(
              expandedHeight: 170,
              pinned: true,
              floating: false,
              backgroundColor: const Color.fromARGB(255, 218, 248, 234),
              // backgroundColor: AppColors.lightGreen(0.2),
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  spacing: 25,
                  children: [
                    Text(
                      state is ProfileControllerLoadedState
                          ? state.role == "user"
                                ? state.name
                                : "Hope For All Foundation"
                          : state is ProfileControllerErrorState
                          ? "Profile Loading Error"
                          : "....",
                      style: TextStyle(
                        color: state is ProfileControllerErrorState
                            ? AppColors.red(0.9)
                            : AppColors.black(1),
                        fontSize: state is ProfileControllerErrorState
                            ? 14
                            : 18,
                        fontWeight: state is ProfileControllerErrorState
                            ? FontWeight.w300
                            : FontWeight.bold,
                      ),
                    ),
                    state is ProfileControllerErrorState
                        ? InkWell(
                            onTap: () {
                              context
                                  .read<ProfileControllerCubit>()
                                  .fetchProfile();
                            },
                            child: Icon(
                              Icons.refresh_rounded,
                              color: AppColors.green(1),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                background: Stack(
                  children: [
                    Image.asset(
                      "assets/kindBridge_logo.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Container(color: AppColors.white(0.91)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 50),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            state is! ProfileControllerLoadingState
                                ? CircleAvatar(
                                    radius: 45,
                                    backgroundColor: AppColors.lightGreen(0.3),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'fromBackend/Users{id}/profile.jpg',
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return const CircularProgressIndicator(
                                            color: Color.fromARGB(
                                              224,
                                              3,
                                              241,
                                              102,
                                            ),
                                            strokeWidth: 2,
                                          );
                                        },
                                        errorWidget: (context, error, e) {
                                          return const Icon(
                                            Icons.person,
                                            size: 40,
                                            color: Color.fromARGB(
                                              255,
                                              1,
                                              165,
                                              69,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(
                                    color: Color.fromARGB(224, 3, 241, 102),
                                    strokeWidth: 2,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        SliverToBoxAdapter(child: SizedBox(height: 30)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Donation Statics", style: TextStyle(fontSize: 23)),
                Row(
                  spacing: 5,
                  children: [
                    Container(
                      width: 125,
                      height: 2,
                      color: AppColors.green(0.6),
                    ),
                    Container(width: 45, height: 2, color: AppColors.grey(0.6)),
                  ],
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 8)),

        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ngoStatisticDataShow(
                label: "Total request",
                percentage: 0.20,
                icon: Icons.send_rounded,
                color: AppColors.blue(0.9),
              ).animate(
                delay: Duration(milliseconds: 200),
                effects: [FlipEffect(duration: Duration(milliseconds: 600))],
              ),
              ngoStatisticDataShow(
                label: "Total Accepted",
                percentage: 0.12,
                icon: Icons.send_rounded,
                color: AppColors.green(0.8),
              ).animate(
                delay: Duration(milliseconds: 400),
                effects: [FlipEffect(duration: Duration(milliseconds: 600))],
              ),
              ngoStatisticDataShow(
                label: "Total Pending",
                percentage: 0.08,
                icon: Icons.send_rounded,
                color: AppColors.red(0.7),
              ).animate(
                delay: Duration(milliseconds: 600),
                effects: [FlipEffect(duration: Duration(milliseconds: 600))],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recent Donations", style: TextStyle(fontSize: 23)),
                Row(
                  spacing: 5,
                  children: [
                    Container(
                      width: 80,
                      height: 2,
                      color: AppColors.green(0.6),
                    ),
                    Container(width: 36, height: 2, color: AppColors.grey(0.6)),
                  ],
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<DonatedItemCubit, DonatedItemState>(
          builder: (context, state) {
            if (state is DonatedItemInitialState) {
              context.read<DonatedItemCubit>().loadDonationItems("all");
            }
            if (state is DonatedItemLoadingState) {
              return SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is DonatedItemLoadedState) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.detailedItemView,
                          arguments: {
                            "selected_item": state.donatedItems[index],
                          },
                        );
                      },
                      child: itemShowWidgetCard(
                        index,
                        state.donatedItems[index],
                      ),
                    ),
                  ),
                  childCount: state.donatedItems.length,
                ),
              );
            }
            if (state is DonatedItemErrorState) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(color: AppColors.red(1), fontSize: 16),
                  ),
                ),
              );
            }
            return SliverToBoxAdapter();
          },
        ),
      ],
    );
  }
}
