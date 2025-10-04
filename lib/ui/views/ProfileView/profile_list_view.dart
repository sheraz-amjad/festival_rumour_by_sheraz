import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/follower_tile.dart';
import '../../../core/services/festival_tile.dart';
import 'profile_list_view_model.dart';

class ProfileListView extends BaseView<ProfileListViewModel> {
  final int initialTab; // 0 = Followers, 1 = Following, 2 = Festivals

  const ProfileListView({super.key, required this.initialTab});

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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: viewModel.closeProfileList,
        ),
        title: Text(
          viewModel.currentTab == 0
              ? AppStrings.followers
              : viewModel.currentTab == 1
              ? AppStrings.following
              : AppStrings.festivals,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _buildTabBar(viewModel),
        ),
      ),
      body: ListView.builder(
        itemCount: viewModel.getCurrentList().length,
        itemBuilder: (context, i) {
          final item = viewModel.getCurrentList()[i];
          if (viewModel.currentTab == 2) {
            return FestivalTile(title: item['title']!);
          }
          return FollowerTile(
            data: item,
            showAction: viewModel.currentTab == 1,
            onAction: () => viewModel.unfollowUser(item),
          );
        },
      ),
    );
  }

  /// 🔹 Custom TabBar (Followers | Following | Festivals)
  Widget _buildTabBar(ProfileListViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _tabButton(
          '${viewModel.followers.length} ${AppStrings.followers}',
          viewModel.currentTab == 0,
              () => viewModel.setTab(0),
        ),
        _tabButton(
          '${viewModel.following.length} ${AppStrings.following}',
          viewModel.currentTab == 1,
              () => viewModel.setTab(1),
        ),
        _tabButton(
          '${viewModel.festivals.length} ${AppStrings.festivals}',
          viewModel.currentTab == 2,
              () => viewModel.setTab(2),
        ),
      ],
    );
  }

  /// 🔹 Tab Button Widget
  Widget _tabButton(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.accent : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? AppColors.accent : AppColors.grey600,
          ),
        ),
      ),
    );
  }
}
