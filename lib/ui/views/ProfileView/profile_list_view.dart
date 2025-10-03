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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: viewModel.closeProfileList,
              ),
            ),
          ),
          Row(
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
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          color: active ? AppColors.accent.withOpacity(0.2) : AppColors.lightGrey,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
