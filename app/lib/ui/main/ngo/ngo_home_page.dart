import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_project/constant/app_colors.dart';
import 'package:flutter/material.dart';

class NgoHomePage extends StatelessWidget {
  const NgoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 170,
          pinned: true,
          floating: false,
          backgroundColor: const Color.fromARGB(255, 218, 248, 234),
          // backgroundColor: AppColors.lightGreen(0.2),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Ngo Name',
              style: TextStyle(
                color: AppColors.black(1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.lightGreen(0.3),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: 'fromBackend/Users{id}/profile.jpg',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const CircularProgressIndicator(
                                  color: Color.fromARGB(224, 3, 241, 102),
                                  strokeWidth: 2,
                                );
                              },
                              errorWidget: (context, error, e) {
                                return const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color.fromARGB(255, 1, 165, 69),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
