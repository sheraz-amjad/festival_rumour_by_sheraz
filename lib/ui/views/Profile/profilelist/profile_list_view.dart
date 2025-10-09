import 'package:festival_rumour/ui/views/Profile/profilelist/widgets/festivals_tab.dart';
import 'package:festival_rumour/ui/views/Profile/profilelist/widgets/followers_tab.dart';
import 'package:festival_rumour/ui/views/Profile/profilelist/widgets/following_tab.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/backbutton.dart';
import '../../../../core/utils/base_view.dart';
import 'profile_list_view_model.dart';


class ProfileListView extends BaseView<ProfileListViewModel> {
  final int initialTab; // 0 = Followers, 1 = Following, 2 = Festivals
  final String username;

  const ProfileListView({
    super.key,
    required this.initialTab,
    required this.username,
  });

  @override
  ProfileListViewModel createViewModel() => ProfileListViewModel();

  @override
  void onViewModelReady(ProfileListViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.setTab(initialTab);
  }

  @override
  Widget buildView(BuildContext context, ProfileListViewModel viewModel) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /// 🔹 Background
          Positioned.fill(
            child: Image.asset(
              AppAssets.bottomsheet,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Foreground UI
          SafeArea(
            child: Column(
              children: [
                /// 🔹 App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(onTap: () => Navigator.pop(context)),
                      Text(
                        username,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: AppColors.white),
                        onPressed: viewModel.refreshList,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// 🔹 Tabs Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      _buildTabButton(
                        label: "Followers",
                        isActive: viewModel.currentTab == 0,
                        onTap: () => viewModel.setTab(0),
                      ),
                      _buildTabButton(
                        label: "Following",
                        isActive: viewModel.currentTab == 1,
                        onTap: () => viewModel.setTab(1),
                      ),
                      _buildTabButton(
                        label: "Festivals",
                        isActive: viewModel.currentTab == 2,
                        onTap: () => viewModel.setTab(2),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// 🔹 Tab View
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildTabView(viewModel),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabView(ProfileListViewModel viewModel) {
    switch (viewModel.currentTab) {
      case 0:
        return FollowersTab(viewModel: viewModel);
      case 1:
        return FollowingTab(viewModel: viewModel);
      case 2:
        return FestivalsTab(viewModel: viewModel);
      default:
        return FollowersTab(viewModel: viewModel);
    }
  }

  Widget _buildTabButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : AppColors.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.onPrimary : AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
