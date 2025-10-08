import 'package:festival_rumour/core/utils/backbutton.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_widget.dart';

import '../homeview/home_viewmodel.dart';
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
        if (onBack != null) {
          onBack!(); // navigate to home tab
          return false; // prevent default back navigation
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
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
                            children: const [
                              Icon(Icons.favorite_border, color: AppColors.primary),
                              SizedBox(width: AppDimensions.spaceM),
                              Icon(Icons.ios_share_sharp, color: AppColors.primary),
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
                        crossAxisCount: screenWidth < 600 ? 2 : 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: AppDimensions.spaceM,
                        crossAxisSpacing: AppDimensions.spaceM,
                        childAspectRatio: 1.2,
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
          ],
        ),
      ),
    );
  }
}