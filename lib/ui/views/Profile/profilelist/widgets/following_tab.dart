import 'package:festival_rumour/shared/widgets/responsive_widget.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical:AppDimensions.paddingS),
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
                borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
                borderSide: const BorderSide(color: AppColors.onPrimary, width: 2), // ✅ White border when active
              ),
            ),
            onChanged: viewModel.searchFollowing,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            itemCount: viewModel.following.length,
            itemBuilder: (context, index) {
              final following = viewModel.following[index];
              return Container(
                margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  border: Border.all(
                    color: AppColors.white,
                    width: AppDimensions.dividerThickness,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: AppDimensions.avatarS,
                      backgroundImage: AssetImage(following['image'] ?? ''),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                    ),
                    const SizedBox(width: AppDimensions.paddingXS),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveText(
                            following['name'] ?? 'Unknown User',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: AppDimensions.textL,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spaceXS),
                          ResponsiveText(
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
                      height: AppDimensions.buttonHeightM,
                      margin: const EdgeInsets.only(right: AppDimensions.spaceS),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to chat view
                          Navigator.pushNamed(context, AppRoutes.chat);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const ResponsiveText(
                          'Message',
                          style: TextStyle(
                            fontSize: AppDimensions.textM,
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
                              ResponsiveText(
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
