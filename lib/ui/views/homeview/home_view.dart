import 'package:festival_rumour/ui/views/homeview/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top AppBar
            _buildAppBar(context, viewModel),

            // Search Bar
            _buildSearchBar(context),

            const SizedBox(height: AppDimensions.spaceS),

            // Feed List
            Expanded(
              child: _buildFeedList(context, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, HomeViewModel viewModel) {
    return ResponsivePadding(
      mobilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      tabletPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      desktopPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/logo.svg",
            width: AppDimensions.iconM,
            height: AppDimensions.iconM,
          ),
          const SizedBox(width: AppDimensions.spaceS),
          ResponsiveText(
            "Luna Fest 2025",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          GestureDetector(
            onTap: viewModel.goToSubscription,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingS, 
                  vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: const Text(
                "PRO",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Handle notifications
            },
          ),
          const SizedBox(width: AppDimensions.spaceS),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return ResponsiveContainer(
      mobileMaxWidth: double.infinity,
      tabletMaxWidth: 600,
      desktopMaxWidth: 800,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM, 
            vertical: AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: AppColors.onSurfaceVariant),
            SizedBox(width: AppDimensions.spaceS),
            Text(
              "Select Festival",
              style: TextStyle(color: AppColors.onSurfaceVariant),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeedList(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isLoading && viewModel.posts.isEmpty) {
      return const LoadingWidget(message: 'Loading posts...');
    }

    if (viewModel.posts.isEmpty) {
      return const Center(
        child: Text(
          'No posts available',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
      itemCount: viewModel.posts.length,
      itemBuilder: (context, index) {
        final post = viewModel.posts[index];
        return PostWidget(post: post);
      },
    );
  }
}
