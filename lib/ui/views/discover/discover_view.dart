import 'dart:ui';
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
import '../../../core/utils/snackbar_util.dart';
import '../../../shared/widgets/responsive_widget.dart';
import 'discover_viewmodel.dart';

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
                    desktopPadding:
                    const EdgeInsets.all(AppDimensions.paddingXL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackButton(onTap: onBack ?? () {}),
                            Text(
                              AppStrings.overview,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: AppDimensions.textXL,
                              ),
                            ),
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
                                        ? Colors.red
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

                        const Text(
                          AppStrings.getReady,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
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
                              '🎉 Hey! Join me at LunaFest using the Festival Rumour app! '
                                  'Let’s enjoy the vibe together 🌙🔥\n\n'
                                  'Download now: https://yourapp.link',
                              subject: 'Join me at LunaFest!',
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
                          children: const [
                            GridOption(
                                title: AppStrings.location,
                                icon: AppAssets.mapicon),
                            GridOption(
                                title: AppStrings.chatRooms,
                                icon: AppAssets.chaticon),
                            GridOption(
                                title: AppStrings.rumors,
                                icon: AppAssets.rumors),
                            GridOption(
                                title: AppStrings.detail,
                                icon: AppAssets.detailicon),
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
            const SizedBox(height: 10),
            const Text(
              'Share Location',
              style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                SnackbarUtil.showSuccessSnackBar(
                  context,
                  'Location Sharing Enabled',
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Allow To Share Location So The Crowd Can Find You, Nothing Else',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Hiding My Vibe, Staying Incognito',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
