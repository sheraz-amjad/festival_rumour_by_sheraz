import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/backbutton.dart';
import '../../../core/utils/custom_navbar.dart';
import '../../../core/router/app_router.dart';
import 'detail_view_model.dart';

class DetailView extends BaseView<DetailViewModel> {
  final VoidCallback? onBack;
  final Function(String)? onNavigateToSub;
  const DetailView({super.key, this.onBack, this.onNavigateToSub});

  @override
  DetailViewModel createViewModel() => DetailViewModel();

  @override
  Widget buildView(BuildContext context, DetailViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        if (onBack != null) {
          onBack!();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
        children: [
          // Background image (same as profile view)
          Positioned.fill(
            child: Image.asset(
              AppAssets.bottomsheet,
              fit: BoxFit.cover,
            ),
          ),
          
          // Dark overlay for readability
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context, viewModel),
                const SizedBox(height: AppDimensions.spaceXL),
                Expanded(
                  child: _buildContentCards(context),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildAppBar(BuildContext context, DetailViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        children: [
          CustomBackButton(
            onTap: onBack ?? () {
              // Navigate back to discover screen using ViewModel
              viewModel.navigateBack(context);
            },
          ),
          const SizedBox(width: AppDimensions.spaceM),
          const ResponsiveTextWidget(
            'Detail',
            textType: TextType.title,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            ),
        ],
      ),
    );
  }

  Widget _buildContentCards(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Column(
        children: [
          // Top row - two cards side by side
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  context,
                  'LUNA NEWS',
                  AppAssets.news,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.news),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceM),
              Expanded(
                child: _buildCard(
                  context,
                  'TOILET',
                  AppAssets.toilet,
                  onTap: () {
                    if (onNavigateToSub != null) {
                      onNavigateToSub!('toilets');
                    } else {
                      Navigator.pushNamed(context, AppRoutes.toilets);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          // Bottom row - two full-width cards
          _buildCard(
            context,
            'WHERE THE BEATS DROP',
            AppAssets.post1,
            isFullWidth: true,
            onTap: () => Navigator.pushNamed(context, AppRoutes.performance),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          _buildCard(
            context,
            'EVENTS HUB',
            AppAssets.post2,
            isFullWidth: true,
            onTap: () => Navigator.pushNamed(context, AppRoutes.event),
          ),
        ],
      ),
    );
  }
  Widget _buildCard(
      BuildContext context,
      String title,
      String imagePath, {
        bool isFullWidth = false,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.imageXXL,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // Background layer at the bottom (30% height)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: AppDimensions.imageXXL * 0.3, // 30% of container height
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
              ),

              // Centered text within background layer
              Positioned(
                bottom: AppDimensions.paddingM,
                left: 0,
                right: 0,
                child: Center(
                  child: ResponsiveTextWidget(
                    title,
                    textType: TextType.heading,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


