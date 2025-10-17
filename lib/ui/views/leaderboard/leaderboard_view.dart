import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import 'leaderboard_view_model.dart';

class LeaderboardView extends BaseView<LeaderboardViewModel> {
  const LeaderboardView({super.key});

  @override
  LeaderboardViewModel createViewModel() => LeaderboardViewModel();

  @override
  Widget buildView(BuildContext context, LeaderboardViewModel viewModel) {
    return Scaffold(
      body: Stack(
        children: [
          LeaderboardWidgets.buildBackground(),
          LeaderboardWidgets.buildAppBar(context),

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LeaderboardWidgets.buildTitle(),
                const SizedBox(height: AppDimensions.paddingS),
                ...viewModel.leaders.map(
                      (leader) => LeaderboardWidgets.buildLeaderCard(
                    rank: leader['rank'],
                    name: leader['name'],
                    badge: leader['badge'],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardWidgets {
  /// 🔹 AppBar Section
  static Widget buildAppBar(BuildContext context) {
    return Stack(
      children: [
      /// 🔹 Background Layer (Covers SafeArea completely)
      Container(
      width: double.infinity,
      height: MediaQuery.of(context).padding.top + 70, // full safe area + app bar height
      decoration:  BoxDecoration(
        color: Colors.black.withOpacity(0.6),
      ),
    ),
    SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),

            const ResponsiveTextWidget(
              AppStrings.leaderBoard,
              textType: TextType.body, 
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.textL,
              ),

            // PRO badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: const Row(
                children: [
                  Icon(Icons.workspace_premium,
                      color: Colors.white, size: 16),
                  SizedBox(width: AppDimensions.spaceXS),
                  ResponsiveTextWidget(
                    AppStrings.pro,
                    textType: TextType.body, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.textS,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    ]
    );
  }

  /// 🔹 Background Image
  static Widget buildBackground() {
    return Image.asset(
      AppAssets.leaderboard,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  /// 🔹 Title Section
  static Widget buildTitle() {
    return Container(
      width: double.infinity,
      height: AppDimensions.imageXL,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
        decoration: BoxDecoration(
        color: AppColors.onPrimary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
        child: ResponsiveTextWidget(
      AppStrings.lunaFest2025,
      textType: TextType.body, 
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: AppDimensions.textXL,
      ),
    );
  }

  /// 🔹 Leaderboard Card
  static Widget buildLeaderCard({
    required int rank,
    required String name,
    required String badge,
  }) {
    final iconColor = rank == 1
        ? Colors.amber
        : rank == 2
        ? Colors.grey
        : Colors.brown;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          ResponsiveTextWidget(
            '$rank',
            textType: TextType.title,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: AppDimensions.paddingM),
          CircleAvatar(
            radius: AppDimensions.avatarM,
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(Icons.emoji_events, color: iconColor, size: 28),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveTextWidget(
                name,
                textType: TextType.body,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              ResponsiveTextWidget(
                badge,
                textType: TextType.caption,
                color: AppColors.grey400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

