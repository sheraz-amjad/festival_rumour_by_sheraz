import 'package:festival_rumour/ui/views/ProfileView/profile_list_view.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_assets.dart';
import 'profile_viewmodel.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/stat_tile.dart'; // 🔹 import widget

class ProfileView extends BaseView<ProfileViewModel> {
  const ProfileView({super.key});

  @override
  ProfileViewModel createViewModel() => ProfileViewModel();

  @override
  Widget buildView(BuildContext context, ProfileViewModel viewModel) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.profile, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: viewModel.goToNotifications,
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Info
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: AppDimensions.avatarProfile,
                    backgroundImage: AssetImage(AppAssets.profile),
                  ),
                  const SizedBox(width: AppDimensions.size10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.sufyanCh, style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDimensions.textXL)),
                        const SizedBox(height: AppDimensions.size4),
                        const Text(AppStrings.monNom, style: TextStyle(color: AppColors.grey500)),
                        const SizedBox(height: AppDimensions.size4),
                        const Text(AppStrings.profileDescription),
                        const SizedBox(height: AppDimensions.size8),

                        // 🔹 Replace with reusable StatTile widgets
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatTile(count: AppStrings.posts100, label: AppStrings.posts, onTap: () { /* scroll to posts */ }),
                            StatTile(
                              count: AppStrings.followers209,
                              label: AppStrings.followers,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ProfileListView(initialTab: 0),
                                  ),
                                );
                              },
                            ),
                            StatTile(
                              count: AppStrings.following109,
                              label: AppStrings.following,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ProfileListView(initialTab: 1),
                                  ),
                                );
                              },
                            ),
                            StatTile(
                              count: AppStrings.festivals3,
                              label: AppStrings.festivals,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ProfileListView(initialTab: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Posts Grid
            GridView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 600 ? 4 : 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: viewModel.posts.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () { viewModel.onPostTap(index); },
                child: Image.asset(
                  viewModel.posts[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
