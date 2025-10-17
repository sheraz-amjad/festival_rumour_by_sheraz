import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../profile_list_view_model.dart';

class FollowingTab extends StatelessWidget {
  final ProfileListViewModel viewModel;
  const FollowingTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextField(
            style: const TextStyle(color: AppColors.primary),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: AppStrings.searchFollowing,
              hintStyle: const TextStyle(color: AppColors.primary),
              prefixIcon: const Icon(Icons.search, color: AppColors.primary),
              filled: true,
              fillColor: AppColors.onPrimary.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onChanged: viewModel.searchFollowing,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: viewModel.following.length,
            itemBuilder: (context, index) {
              final following = viewModel.following[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.white,
                    width: AppDimensions.dividerThickness,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: AppDimensions.avatarM,
                      backgroundImage: AssetImage(following['image'] ?? ''),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            following['name'] ?? 'Unknown User',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: AppDimensions.textL,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spaceXS),
                          Text(
                            following['username'] ?? '',
                            style: const TextStyle(
                              color: AppColors.grey600,
                              fontSize: AppDimensions.textM,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: AppDimensions.buttonHeightS,
                      margin: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to chat view
                          Navigator.pushNamed(context, AppRoutes.chat);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey600,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Message',
                          style: TextStyle(
                            fontSize: AppDimensions.textS,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppColors.white,
                      ),
                      onSelected: (value) {
                        if (value == 'unfollow') {
                          viewModel.unfollowUser(following);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'unfollow',
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_remove,
                                color: AppColors.red,
                                size: AppDimensions.iconS,
                              ),
                              SizedBox(width: AppDimensions.spaceS),
                              Text(
                                AppStrings.unfollow,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: AppDimensions.textM,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
