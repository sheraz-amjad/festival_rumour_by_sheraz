import 'package:festival_rumour/ui/views/homeview/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/utils/custom_navbar.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'home_viewmodel.dart';

class HomeView extends BaseView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel createViewModel() => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadPosts();
  }

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent, // makes background image visible
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                AppAssets.bottomsheet, // from your constants
                fit: BoxFit.cover,
              ),
            ),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  _buildAppBar(context, viewModel),
                  _buildSearchBar(context),
                  const SizedBox(height: AppDimensions.spaceS),
                  Expanded(
                    child: _buildFeedList(context, viewModel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, HomeViewModel viewModel) {
    return ResponsivePadding(
      mobilePadding: const EdgeInsets.symmetric(
       // horizontal: AppDimensions.appBarHorizontalMobile,
        vertical: AppDimensions.appBarVerticalMobile,
      ),
      tabletPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.appBarHorizontalTablet,
        vertical: AppDimensions.appBarVerticalTablet,
      ),
      desktopPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.appBarHorizontalDesktop,
        vertical: AppDimensions.appBarVerticalDesktop,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.logo,
            color: AppColors.primary,
            width: AppDimensions.iconXXL,
            height: AppDimensions.iconXXL,
          ),
          const SizedBox(width: AppDimensions.spaceL),
          ResponsiveText(
            AppStrings.lunaFest2025,

            style: const TextStyle(
              color: AppColors.primary,
              fontSize: AppDimensions.textXXL,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceL),

          IconButton(
            icon: SvgPicture.asset(
              AppAssets.jobicon,
             // color: AppColors.primary,
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: AppDimensions.spaceL),
          GestureDetector(
            onTap: viewModel.goToSubscription,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.proLabelBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: const Text(
                AppStrings.proLabel,
                style: TextStyle(
                  color: AppColors.proLabelText,
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.textS,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchBar(BuildContext context) {
    String selectedFilter = AppStrings.allFilter;

    return ResponsiveContainer(
      mobileMaxWidth: double.infinity,
      tabletMaxWidth: double.infinity,
      desktopMaxWidth: double.infinity,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: AppColors.onPrimary,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.onSurfaceVariant, size: AppDimensions.iconM),
                const SizedBox(width: AppDimensions.spaceS),

                /// 🔹 Search Field
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: AppStrings.searchHint,
                      hintStyle: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.textM,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.textM,
                    ),
                  ),
                ),

                /// 🔹 Dropdown Filter
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                   // value: selectedFilter == AppStrings.allFilter ? AppStrings.live : selectedFilter,
                    dropdownColor: AppColors.onPrimary,
                    isExpanded: false,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.35,
                    icon: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingXS),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_drop_down, color: AppColors.onPrimary),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: AppStrings.live,
                        child: Row(
                          children: [
                            Icon(Icons.wifi_tethering, color: AppColors.primary, size: 20),
                            SizedBox(width: 8),
                            Text(AppStrings.live, style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: AppStrings.upcoming,
                        child: Row(
                          children: [
                            Icon(Icons.schedule, color: AppColors.primary, size: 20),
                            SizedBox(width: 8),
                            Text(AppStrings.upcoming, style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: AppStrings.past,
                        child: Row(
                          children: [
                            Icon(Icons.history, color: AppColors.primary, size: 20),
                            SizedBox(width: 8),
                            Text(AppStrings.past, style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedFilter = value);
                        debugPrint("Selected Filter: $value");
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedList(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isLoading && viewModel.posts.isEmpty) {
      return const LoadingWidget(message: AppStrings.loadingPosts);
    }

    if (viewModel.posts.isEmpty) {
      return const Center(
        child: Text(
          AppStrings.noPostsAvailable,
          style: TextStyle(
            fontSize: AppDimensions.textM,
            color: AppColors.onPrimary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
      itemCount: viewModel.posts.length,
      itemBuilder: (context, index) {
        final post = viewModel.posts[index];
        return Column(
          children: [
            PostWidget(post: post),
            // Add spacing except after the last post
            if (index != viewModel.posts.length - 1)
              const SizedBox(height: AppDimensions.spaceM),
          ],
        );
      },
    );
  }
}
