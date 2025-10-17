import 'dart:ui';
import 'package:festival_rumour/core/router/app_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:festival_rumour/ui/views/discover/widgets/action_tile.dart';
import 'package:festival_rumour/ui/views/discover/widgets/event_header_card.dart';
import 'package:festival_rumour/ui/views/discover/widgets/grid_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/backbutton.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import '../../../core/utils/snackbar_util.dart';
import '../../../shared/widgets/responsive_widget.dart';
import 'discover_viewmodel.dart';

class DiscoverView extends BaseView<DiscoverViewModel> {
  final VoidCallback? onBack;
  final Function(String)? onNavigateToSub;
  const DiscoverView({super.key, this.onBack, this.onNavigateToSub});

  @override
  DiscoverViewModel createViewModel() => DiscoverViewModel();

  @override
  Widget buildView(BuildContext context, DiscoverViewModel viewModel) {
    final screenWidth = context.screenWidth;

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
                    desktopPadding:
                    const EdgeInsets.all(AppDimensions.paddingXL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header
                        Row(
                          children: [
                            CustomBackButton(onTap: onBack ?? () {}),
                            
                            SizedBox(width: context.isLargeScreen ? 16 : context.isMediumScreen ? 12 : 8),
                            
                            /// Overview title
                            ResponsiveTextWidget(
                              AppStrings.overview,
                              textType: TextType.heading,
                              color: AppColors.primary,
                            ),
                            
                            /// Spacer to push icons to the right
                            const Spacer(),
                            
                            /// Right-side icons
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    viewModel.toggleFavorite();
                                    if (viewModel.isFavorited) {
                                      SnackbarUtil.showSuccessSnackBar(
                                        context,
                                        AppStrings.addedToFavorites,
                                      );
                                    } else {
                                      SnackbarUtil.showInfoSnackBar(
                                        context,
                                        AppStrings.removedFromFavorites,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    viewModel.isFavorited
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: viewModel.isFavorited
                                        ? AppColors.error
                                        : AppColors.primary,
                                  ),
                                ),
                                const SizedBox(
                                    width: AppDimensions.spaceM),
                                const Icon(Icons.ios_share_sharp,
                                    color: AppColors.primary),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.spaceL),

                        const EventHeaderCard(),

                        const SizedBox(height: AppDimensions.spaceL),

                        const ResponsiveTextWidget(
                          AppStrings.getReady,
                          textType: TextType.body, 
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),

                        const SizedBox(height: AppDimensions.spaceL),

                        /// Action Tiles
                        ActionTile(
                          iconPath: AppAssets.handicon,
                          text: AppStrings.countMeInCatchYaAtLunaFest,
                          onTap: () {
                            // 👇 Show share location popup here
                            showDialog(
                              context: context,
                              builder: (context) => const ShareLocationPopup(),
                            );
                          },
                        ),
                        const SizedBox(height: AppDimensions.spaceS),
                        ActionTile(
                          iconPath: AppAssets.iconcharcter,
                          text: AppStrings.inviteYourFestieBestie,
                          onTap: () async {
                            // 👇 Trigger native social share
                            await Share.share(
                                  AppStrings.shareMessage,
                              subject: AppStrings.shareSubject,
                              sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 0),
                            );
                          },
                        ),

                        const SizedBox(height: AppDimensions.spaceM),

                        /// Grid Options
                        GridView.count(
                          crossAxisCount: context.isLargeScreen
                              ? 4
                              : context.isMediumScreen
                              ? 3
                              : 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: context.isLargeScreen
                              ? AppDimensions.spaceL
                              : AppDimensions.spaceM,
                          crossAxisSpacing: context.isLargeScreen
                              ? AppDimensions.spaceL
                              : AppDimensions.spaceM,
                          childAspectRatio: context.isLargeScreen
                              ? 1.3
                              : context.isMediumScreen
                              ? 1.2
                              : 1.1,
                          children: [
                            GridOption(
                                title: AppStrings.location,
                                icon: AppAssets.mapicon,
                                onNavigateToSub: onNavigateToSub),
                            GridOption(
                                title: AppStrings.chatRooms,
                                icon: AppAssets.chaticon,
                                onNavigateToSub: onNavigateToSub),
                            GridOption(
                                title: AppStrings.rumors,
                                icon: AppAssets.rumors,
                              onTap: () => viewModel.goToRumors(context),
                            ),
                            GridOption(
                                title: AppStrings.detail,
                                icon: AppAssets.detailicon,
                                onNavigateToSub: onNavigateToSub),
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

/// 🟡 POPUP WIDGET (inside the same file)
class ShareLocationPopup extends StatelessWidget {
  const ShareLocationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.onPrimary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: AppColors.primary),
              ),
            ),
            const Icon(Icons.location_on,
                color: AppColors.accent, size: 60),
            SizedBox(height: AppDimensions.spaceS),
            const ResponsiveTextWidget(
              AppStrings.shareLocation,
              textType: TextType.body, 
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  //fontSize: 20
            ),
            SizedBox(height: AppDimensions.paddingL),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                SnackbarUtil.showSuccessSnackBar(
                  context,
                  AppStrings.locationSharingEnabled,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ResponsiveTextWidget(
                  AppStrings.locationSharingDescription,
                  textAlign: TextAlign.center,
                  textType: TextType.body, 
                      color: AppColors.black,
                      fontWeight: FontWeight.w800,
                      //fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: AppDimensions.spaceM),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ResponsiveTextWidget(
                  AppStrings.hidingMyVibe,
                  textAlign: TextAlign.center,
                  textType: TextType.body, 
                      color: AppColors.black,
                      fontWeight: FontWeight.w800,
                      //fontSize: 16
                  ),
                ),
              ),
        ],
        ),
      ),
    );
  }
}
