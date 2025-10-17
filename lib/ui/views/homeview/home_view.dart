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
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        viewModel.unfocusSearch();
      },
      child: Scaffold(
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
                _buildSearchBar(context, viewModel),
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
          // Logo with responsive sizing
          SvgPicture.asset(
            AppAssets.logo,
            color: AppColors.primary,
           width: 50,
           height: 50,
           // width: _getResponsiveIconSize(context),
           //  height: _getResponsiveIconSize(context),
          ),

          SizedBox(width: _getResponsiveSpacing(context)),
          
          // Title - Flexible to prevent overflow
          Expanded(
            child: ResponsiveTextWidget(
              AppStrings.lunaFest2025,
              textType: TextType.heading,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          const Spacer(),


          // Job Icon Button with responsive sizing
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.jobicon,
             // width: _getResponsiveIconSize(context),
              //height: _getResponsiveIconSize(context),
            ),
            onPressed: () => _showPostBottomSheet(context),
          ),
          
          SizedBox(width:20),
          
          // Pro Label - Flexible container
          Flexible(
            child: GestureDetector(
              onTap: viewModel.goToSubscription,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _getResponsivePadding(context),
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: ResponsiveTextWidget(
                  AppStrings.proLabel,
                  textType: TextType.label,
                  color: AppColors.proLabelText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for responsive sizing - optimized for high-res phones
  double _getResponsiveIconSize(BuildContext context) {
    if (context.isHighResolutionPhone) {
      return AppDimensions.iconM; // 48px for high-res phones like Pixel 6 Pro
    } else if (context.isLargeScreen) {
      return AppDimensions.iconXL; // 64px for desktop
    } else if (context.isMediumScreen) {
      return AppDimensions.iconL; // 32px for tablets
    }
    return AppDimensions.iconL; // 32px minimum for all phones
  }

  double _getResponsiveSpacing(BuildContext context) {
    if (context.isHighResolutionPhone) {
      return AppDimensions.spaceM; // 16px for high-res phones (reduced from 24px)
    } else if (context.isLargeScreen) {
      return AppDimensions.spaceL; // 24px for desktop (reduced from 32px)
    } else if (context.isMediumScreen) {
      return AppDimensions.spaceS; // 8px for tablets (reduced from 16px)
    }
    return AppDimensions.spaceS; // 8px minimum for all phones (reduced from 16px)
  }

  double _getResponsiveTitleSize(BuildContext context) {
    if (context.isHighResolutionPhone) {
      return AppDimensions.textL; // 18px for high-res phones
    } else if (context.isLargeScreen) {
      return AppDimensions.textXL; // 26px for desktop
    } else if (context.isMediumScreen) {
      return AppDimensions.textM; // 14px for tablets
    }
    return AppDimensions.textM; // 14px minimum for all phones
  }

  double _getResponsivePadding(BuildContext context) {
    if (context.isHighResolutionPhone) {
      return AppDimensions.paddingS; // 8px for high-res phones (reduced from 16px)
    } else if (context.isLargeScreen) {
      return AppDimensions.paddingM; // 16px for desktop (reduced from 24px)
    } else if (context.isMediumScreen) {
      return AppDimensions.paddingXS; // 4px for tablets (reduced from 8px)
    }
    return AppDimensions.paddingXS; // 4px minimum for all phones (reduced from 8px)
  }

  double _getResponsiveLabelSize(BuildContext context) {
    if (context.isHighResolutionPhone) {
      return AppDimensions.textM; // 14px for high-res phones
    } else if (context.isLargeScreen) {
      return AppDimensions.textL; // 18px for desktop
    } else if (context.isMediumScreen) {
      return AppDimensions.textS; // 12px for tablets
    }
    return AppDimensions.textS; // 12px minimum for all phones
  }


  Widget _buildSearchBar(BuildContext context, HomeViewModel viewModel) {
    return ResponsiveContainer(
      mobileMaxWidth: double.infinity,
      tabletMaxWidth: double.infinity,
      desktopMaxWidth: double.infinity,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: _getResponsivePadding(context)),
        padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding(context)),
        decoration: BoxDecoration(
          color: AppColors.onPrimary,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search, 
              color: AppColors.onSurfaceVariant, 
              size: _getResponsiveIconSize(context),
            ),
            SizedBox(width: _getResponsiveSpacing(context)),

            /// 🔹 Search Field
            Expanded(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return TextField(
                    focusNode: viewModel.searchFocusNode,
                    decoration: InputDecoration(
                      hintText: AppStrings.searchHint,
                      hintStyle: const TextStyle(
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
                      suffixIcon: viewModel.currentSearchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.primary, size: 20),
                              onPressed: () {
                                viewModel.clearSearch();
                                setState(() {}); // Update the UI
                              },
                            )
                          : null,
                    ),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.textM,
                    ),
                    onChanged: (value) {
                      viewModel.setSearchQuery(value);
                    },
                    onSubmitted: (value) {
                      viewModel.unfocusSearch();
                    },
                    textInputAction: TextInputAction.search,
                  );
                },
              ),
            ),

            /// 🔹 Dropdown Filter
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: viewModel.currentFilter,
                dropdownColor: AppColors.onPrimary.withOpacity(0.5), // Dark gray background
                isExpanded: false,
                menuWidth: double.infinity,
                menuMaxHeight: MediaQuery.of(context).size.height * 0.30,
                icon: Container(
                  padding: EdgeInsets.all(_getResponsivePadding(context) * 0.5),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up, 
                    color: AppColors.onPrimary, 
                    size: _getResponsiveIconSize(context) * 0.6,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'all',
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: viewModel.currentFilter == 'all' ? AppColors.accent : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.grid_view,
                            color: viewModel.currentFilter == 'all' ? Colors.black : Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'All Posts',
                          style: TextStyle(
                            color: viewModel.currentFilter == 'all' ? AppColors.accent : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: AppStrings.live,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: viewModel.currentFilter == AppStrings.live ? Colors.yellow : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.live_tv,
                            color: viewModel.currentFilter == AppStrings.live ? Colors.black : Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.live,
                          style: TextStyle(
                            color: viewModel.currentFilter == AppStrings.live ? Colors.yellow : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: AppStrings.upcoming,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: viewModel.currentFilter == AppStrings.upcoming ? Colors.yellow : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.schedule,
                            color: viewModel.currentFilter == AppStrings.upcoming ? Colors.black : Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.upcoming,
                          style: TextStyle(
                            color: viewModel.currentFilter == AppStrings.upcoming ? Colors.yellow : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: AppStrings.past,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: viewModel.currentFilter == AppStrings.past ? Colors.yellow : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.history,
                            color: viewModel.currentFilter == AppStrings.past ? Colors.black : Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.past,
                          style: TextStyle(
                            color: viewModel.currentFilter == AppStrings.past ? Colors.yellow : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    viewModel.setFilter(value);
                    debugPrint("Selected Filter: $value");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedList(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isLoading && viewModel.posts.isEmpty) {
      return const LoadingWidget(message: AppStrings.loadingPosts);
    }

    if (viewModel.posts.isEmpty) {
      return Center(
        child: ResponsiveTextWidget(
          AppStrings.noPostsAvailable,
          textType: TextType.body,
          color: AppColors.onPrimary,
          fontSize: AppDimensions.textM,
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
            if (index != viewModel.posts.length - 1)
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
                    "JOB Details",
                    textType: TextType.title,
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildJobTile(
                image: AppAssets.job1,
                title: "Festival Gizza Job",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.festivalsJob);
                  // Navigate to add job screen if needed
                },
              ),
              const Divider(color: Colors.yellow, thickness: 1),
              const SizedBox(height: 8),
              _buildJobTile(
                image: AppAssets.job2,
                title: "FestieHeros Job",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.festivalsJob);
                  // Navigate to another add post screen if needed
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
        decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.1),
          // borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.yellow, width: 1),
        ),
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
                      fontSize: 16,
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
