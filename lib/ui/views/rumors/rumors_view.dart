import 'package:festival_rumour/ui/views/homeview/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'rumors_viewmodel.dart';

class RumorsView extends BaseView<RumorsViewModel> {
  const RumorsView({super.key});

  @override
  RumorsViewModel createViewModel() => RumorsViewModel();

  @override
  void onViewModelReady(RumorsViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadRumors();
  }

  @override
  Widget buildView(BuildContext context, RumorsViewModel viewModel) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image - Full screen coverage
          Positioned.fill(
            child: Image.asset(
              AppAssets.bottomsheet,
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
                  child: _buildRumorsList(context, viewModel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, RumorsViewModel viewModel) {
    return ResponsivePadding(
      mobilePadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.appBarHorizontalMobile,
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
          // Back Button
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: AppDimensions.iconL,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          
          SizedBox(width: context.isLargeScreen ? AppDimensions.spaceXL : AppDimensions.spaceL),
          
          // Title - Flexible to prevent overflow
          Expanded(
            child: ResponsiveTextWidget(
              AppStrings.rumors,
              textType: TextType.heading,
              color: AppColors.primary,
              baseFontSize: context.isLargeScreen ? AppDimensions.textXL : 
                           context.isMediumScreen ? AppDimensions.textL : AppDimensions.textS,
              fontWeight: FontWeight.bold,
              maxLines: 1,
            ),
          ),
          
          SizedBox(width: context.isLargeScreen ? AppDimensions.spaceL : AppDimensions.spaceXXL),

          // Job Icon Button
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.jobicon,
              width: context.isLargeScreen ? 30 : context.isMediumScreen ? 28 : 25,
              height: context.isLargeScreen ? 30 : context.isMediumScreen ? 28 : 25,
            ),
            onPressed: () => _showPostBottomSheet(context),
          ),
          
          SizedBox(width: context.isLargeScreen ? AppDimensions.spaceL : AppDimensions.spaceL),
          
          // Pro Label - Flexible container
          Flexible(
            child: GestureDetector(
              onTap: viewModel.goToSubscription,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.isLargeScreen ? AppDimensions.paddingM : AppDimensions.paddingS,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.proLabelBackground,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: ResponsiveTextWidget(
                  AppStrings.proLabel,
                  textType: TextType.label,
                  color: AppColors.proLabelText,
                  fontWeight: FontWeight.bold,
                  baseFontSize: context.isLargeScreen ? AppDimensions.textM : AppDimensions.textS,
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
            margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
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
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      isDense: true,
                      filled: false,
                      fillColor: Colors.transparent,
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

  Widget _buildRumorsList(BuildContext context, RumorsViewModel viewModel) {
    if (viewModel.isLoading && viewModel.rumors.isEmpty) {
      return const LoadingWidget(message: AppStrings.loadingPosts);
    }

    if (viewModel.rumors.isEmpty) {
      return Center(
        child: ResponsiveTextWidget(
          AppStrings.noPostsAvailable,
          textType: TextType.body,
          color: AppColors.onPrimary,
          baseFontSize: AppDimensions.textM,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
      itemCount: viewModel.rumors.length,
      itemBuilder: (context, index) {
        final rumor = viewModel.rumors[index];
        return Column(
          children: [
            PostWidget(post: rumor),
            // Add spacing except after the last post
            if (index != viewModel.rumors.length - 1)
              const SizedBox(height: AppDimensions.spaceM),
          ],
        );
      },
    );
  }

  void _showPostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.onPrimary.withOpacity(0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ResponsiveTextWidget(
                    "POST JOB",
                    textType: TextType.title,
                    color: Colors.yellow,
                    baseFontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildJobTile(
                image: AppAssets.job1,
                title: "Festival Gizza Job",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.festivalsJob);
                },
              ),
              const Divider(color: Colors.yellow, thickness: 1),
              const SizedBox(height: 8),
              _buildJobTile(
                image: AppAssets.job2,
                title: "FestieHeros Job",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.festivalsJob);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJobTile({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Left side (Image + Text)
            Expanded(
              child: Row(
                children: [
                  /// Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Text — flexible and ellipsis
                  Expanded(
                    child: ResponsiveTextWidget(
                      title,
                      textType: TextType.body,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      baseFontSize: 16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            /// Chevron icon (outside Expanded)
            const Icon(Icons.chevron_right, color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}
