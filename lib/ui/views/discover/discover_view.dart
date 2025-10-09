import 'package:festival_rumour/core/utils/backbutton.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/utils/snackbar_util.dart';
import '../../../shared/widgets/responsive_widget.dart';
import 'discover_viewmodel.dart';
import 'widgets/event_header_card.dart';
import 'widgets/action_tile.dart';
import 'widgets/grid_option.dart';


class DiscoverView extends BaseView<DiscoverViewModel> {
  final VoidCallback? onBack;
  const DiscoverView({super.key, this.onBack});

  @override
  DiscoverViewModel createViewModel() => DiscoverViewModel();


  @override
  Widget buildView(BuildContext context, DiscoverViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        print("🔙 Discover screen back button pressed");
        if (onBack != null) {
          onBack!(); // Navigate to home tab
          return false; // Prevent default back behavior
        }
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.bottomsheet,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: ResponsiveContainer(
                mobileMaxWidth: double.infinity,
                tabletMaxWidth: AppDimensions.tabletWidth,
                desktopMaxWidth: AppDimensions.desktopWidth,
                child: SingleChildScrollView(
                  child: ResponsivePadding(
                    mobilePadding: const EdgeInsets.all(AppDimensions.paddingM),
                    tabletPadding: const EdgeInsets.all(AppDimensions.paddingL),
                    desktopPadding: const EdgeInsets.all(AppDimensions.paddingXL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackButton(
                            onTap: onBack ?? () {},
                          ),
                          Text(
                            AppStrings.overview,
                            style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: AppDimensions.textXL),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  viewModel.toggleFavorite();
                                  // Show feedback snackbar
                                  if (viewModel.isFavorited) {
                                    SnackbarUtil.showSuccessSnackBar(
                                      context,
                                      '❤️ Added to favorites!',
                                    );
                                  } else {
                                    SnackbarUtil.showInfoSnackBar(
                                      context,
                                      '💔 Removed from favorites',
                                    );
                                  }
                                },
                                child: Icon(
                                  viewModel.isFavorited 
                                    ? Icons.favorite 
                                    : Icons.favorite_border,
                                  color: viewModel.isFavorited 
                                    ? Colors.red 
                                    : AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: AppDimensions.spaceM),
                              const Icon(Icons.ios_share_sharp, color: AppColors.primary),
                            ],
                          ),
                        ],
                      ),
      
                      const SizedBox(height: AppDimensions.spaceL),
      
                      /// Event Header
                      const EventHeaderCard(),
      
                      const SizedBox(height: AppDimensions.spaceL),
      
                      /// “Get Ready” section
                      const Text(
                        "GET READY",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
      
                      const SizedBox(height: AppDimensions.spaceL),
      
                      /// Action Tiles
                      const ActionTile(
                        iconPath: AppAssets.handicon,
                        text: "Count me in, catch ya at Luna Fest",
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      const ActionTile(
                        iconPath: AppAssets.iconcharcter,
                        text: "Invite your festie bestie",
                      ),
      
                      const SizedBox(height: AppDimensions.spaceM),
      
                      /// Grid Options
                      GridView.count(
                        crossAxisCount: context.isLargeScreen ? 4 : context.isMediumScreen ? 3 : 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: context.isLargeScreen ? AppDimensions.spaceL : AppDimensions.spaceM,
                        crossAxisSpacing: context.isLargeScreen ? AppDimensions.spaceL : AppDimensions.spaceM,
                        childAspectRatio: context.isLargeScreen ? 1.3 : context.isMediumScreen ? 1.2 : 1.1,
                        children: const [
                          GridOption(title: "LOCATION", icon: AppAssets.mapicon),
                          GridOption(title: "CHAT ROOMS", icon: AppAssets.chaticon),
                          GridOption(title: "RUMORS", icon: AppAssets.rumors),
                          GridOption(title: "DETAIL", icon: AppAssets.detailicon),
                        ],
                      ),
                    ],
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}