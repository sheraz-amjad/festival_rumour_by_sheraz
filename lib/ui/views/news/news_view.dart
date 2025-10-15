import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/backbutton.dart';
import 'news_view_model.dart';

class NewsView extends BaseView<NewsViewModel> {
  final VoidCallback? onBack;
  const NewsView({super.key, this.onBack});

  @override
  NewsViewModel createViewModel() => NewsViewModel();

  @override
  Widget buildView(BuildContext context, NewsViewModel viewModel) {
    if (viewModel.showBulletinPreview) {
      return _buildBulletinPreview(context, viewModel);
    }

    if (viewModel.showPerformancePreview) {
      return _buildPerformancePreview(context, viewModel);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E8), // Light green
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: AppDimensions.spaceL),
              _buildBulletinCard(context),
              const SizedBox(height: AppDimensions.spaceL),
              _buildToiletsSection(context),
              const SizedBox(height: AppDimensions.spaceM),
              Expanded(child: _buildFestivalCards(context, viewModel)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50), // Green background
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: AppDimensions.iconM,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          const Text(
            'Bulletin Management',
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppDimensions.textL,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletinCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50), // Green background
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Bulletin',
            style: TextStyle(
              color: Colors.white,
              fontSize: AppDimensions.textXXL,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingM),

                child: Image.asset(
                  AppAssets.news1, // 👈 your image path constant
                  width: AppDimensions.iconXXL,
                  height: AppDimensions.iconXXL,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToiletsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Toilets',
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppDimensions.textL,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle view all action
            },
            child: const Text(
              'View All',
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppDimensions.textM,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalCards(BuildContext context, NewsViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      itemCount: viewModel.festivals.length,
      itemBuilder: (context, index) {
        final festival = viewModel.festivals[index];
        return _buildFestivalCard(context, festival, viewModel);
      },
    );
  }

  Widget _buildFestivalCard(BuildContext context, FestivalItem festival, NewsViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: const Color(0xFFE8F5E8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              AppAssets.news1,
              width: AppDimensions.iconL,
              height: AppDimensions.iconL,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),

          // Festival name
          Expanded(
            child: Text(
              festival.name,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: AppDimensions.textM,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // View Detail button
          GestureDetector(
            onTap: () {
              viewModel.showPerformancePreview = true;
              viewModel.notifyListeners();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingS,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: const Text(
                'View Detail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppDimensions.textS,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletinPreview(BuildContext context, NewsViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildBulletinPreviewAppBar(context, viewModel),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBulletinInformationSection(context),
                    const SizedBox(height: AppDimensions.spaceL),
                    _buildScheduleOptionsCard(context),
                    const SizedBox(height: AppDimensions.spaceL),
                    _buildScheduleForLaterSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletinPreviewAppBar(
    BuildContext context,
    NewsViewModel viewModel,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFE8F5E8), // Light green background
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              viewModel.showBulletinPreview = false;
              viewModel.notifyListeners();
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
              size: AppDimensions.iconL,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          const Text(
            'Bulletin Preview',
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppDimensions.textL,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletinInformationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bulletin Information',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppDimensions.textL,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Title Name Card
        _buildInfoCard(context, 'Title Name', 'Magic show', Icons.description),
        const SizedBox(height: AppDimensions.spaceM),

        // Content Card
        _buildContentCard(context),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8), // Light blue-green
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(icon, color: Colors.white, size: AppDimensions.iconM),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.textS,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.textM,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8), // Light blue-green
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Content',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AppDimensions.textS,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Center(
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: const Icon(
                Icons.edit_document,
                color: Colors.white,
                size: AppDimensions.iconXXL,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleOptionsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8), // Light blue-green
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: AppDimensions.iconL,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Schedule Options',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.textS,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                const Text(
                  'Publish Now',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.textM,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleForLaterSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Schedule For Later',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppDimensions.textL,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                context,
                'Time',
                '2.00 PM',
                Icons.access_time,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: _buildInfoCard(
                context,
                'Date',
                '07.12.2024',
                Icons.calendar_today,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformancePreview(BuildContext context, NewsViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildPreviewAppBar(context, viewModel),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPerformanceInformationSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewAppBar(BuildContext context, NewsViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        children: [
          CustomBackButton(
            onTap: () {
              viewModel.showPerformancePreview = false;
              viewModel.notifyListeners();
            },
          ),
          const SizedBox(width: AppDimensions.spaceM),
          const Text(
            'Bulletin Preview',
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppDimensions.textL,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceInformationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bulletin Information',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppDimensions.textL,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Festival Name
        _buildPerformanceInfoCard(
          context,
          'Title Name',
          'Magic show',
          Icons.auto_fix_high,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Select Event
        _buildPerformanceInfoCard(
          context,
          'Content',
          '',
          Icons.content_paste,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Start Date
        _buildPerformanceInfoCard(
          context,
          'Schedule Options',
          'Publish Now',
          Icons.verified ,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        Text(
          'Schedule For Later',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppDimensions.textL,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Row(
          children: [
            Expanded(
              child: _buildPerformanceInfoCard2(
                context,
                'Time',
                '10:00 AM',
                Icons.access_time,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: _buildPerformanceInfoCard2(
                context,
                'Date',
                '07.12.2024',
                Icons.calendar_today,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceInfoCard(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD), // Light blue
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: AppDimensions.iconM,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.textS,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.textM,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceInfoCard2(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: AppDimensions.iconS,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.textS,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.textM,
                    fontWeight: FontWeight.bold,
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

class PerformanceCategory {
  final String name;
  final String description;
  final IconData icon;

  PerformanceCategory({
    required this.name,
    required this.description,
    required this.icon,
  });
}
