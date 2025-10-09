import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/backbutton.dart';
import 'performance_view_model.dart';

class PerformanceView extends BaseView<PerformanceViewModel> {
  const PerformanceView({super.key});

  @override
  PerformanceViewModel createViewModel() => PerformanceViewModel();

  @override
  Widget buildView(BuildContext context, PerformanceViewModel viewModel) {
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
              Color(0xFFE3F2FD), // Light blue
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: AppDimensions.spaceL),
              _buildPerformanceCard(context),
              const SizedBox(height: AppDimensions.spaceL),
              _buildToiletsSection(context),
              const SizedBox(height: AppDimensions.spaceM),
              Expanded(
                child: _buildPerformanceCategories(context, viewModel),
              ),
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
            onTap: () => Navigator.pop(context),
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
            'Stage Running Order',
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

  Widget _buildPerformanceCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      padding: const EdgeInsets.all( AppDimensions.paddingL),
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
            'Performance',
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
                  AppAssets.performance,
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

  Widget _buildPerformanceCategories(BuildContext context, PerformanceViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      itemCount: viewModel.performanceCategories.length,
      itemBuilder: (context, index) {
        final category = viewModel.performanceCategories[index];
        return _buildPerformanceCategoryCard(context, category, viewModel);
      },
    );
  }

  Widget _buildPerformanceCategoryCard(BuildContext context, PerformanceCategory category, PerformanceViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: const Color(0xFFE3F2FD),
          width: 1,
        ),
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
          // Category icon
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              shape: BoxShape.circle,
              // Brown color
            ),
            child: Center(
              child: Image.asset(
                AppAssets.performance,
                width: AppDimensions.iconL,
                height: AppDimensions.iconL,
                fit: BoxFit.contain,
              )
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          
          // Category name
          Expanded(
            child: Text(
              category.name,
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

  Widget _buildPerformancePreview(BuildContext context, PerformanceViewModel viewModel) {
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
                    const SizedBox(height: AppDimensions.spaceL),
                    _buildNotesSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewAppBar(BuildContext context, PerformanceViewModel viewModel) {
    return Container(
      color: const Color(0xFFE3F2FD),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingM,
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
            'Performance Preview',
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Information',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppDimensions.textL,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Festival Name
        _buildInfoCard(
          context,
          'Festival Name',
          'Magic show',
          Icons.auto_fix_high,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Select Event
        _buildInfoCard(
          context,
          'Select Event',
          'Magic show',
          Icons.confirmation_number,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Start/End Date
        Row(
          children: [
            Expanded(
              child: _buildInfoCard2(
                context,
                'Start Date',
                '07.12.2024',
                Icons.calendar_today,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: _buildInfoCard2(
                context,
                'End Date',
                '09.12.2024',
                Icons.calendar_today,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Performance Title
        _buildInfoCard(
          context,
          'Performance Title',
          'Lorem Ipsum is simply dummy text.',
          Icons.flag,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Band
        _buildInfoCard(
          context,
          'Band',
          'Lorem Ipsum is simply dummy text.',
          Icons.music_note,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Artist
        _buildInfoCard(
          context,
          'Artist',
          'Lorem Ipsum is simply dummy text.',
          Icons.mic,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Participant Name
        _buildParticipantCard(context),
        const SizedBox(height: AppDimensions.spaceM),

        // Special Guests
        _buildInfoCard(
          context,
          'Special Guests',
          'Lorem Ipsum is simply dummy text.',
          Icons.star,
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Start/End Time in Row
        Row(
          children: [
            Expanded(
              child: _buildInfoCard2(
                context,
                'Start Time',
                '10:00 AM',
                Icons.access_time,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: _buildInfoCard2(
                context,
                'End Time',
                '12:00 AM',
                Icons.access_time,
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildInfoCard(BuildContext context, String label, String value, IconData icon) {
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


  Widget _buildInfoCard2(BuildContext context, String label, String value, IconData icon) {
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


  Widget _buildParticipantCard(BuildContext context) {
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
            child: const Icon(
              Icons.people,
              color: Colors.white,
              size: AppDimensions.iconM,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          const Expanded(
            child: Text(
              'Participant Name',
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppDimensions.textM,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppDimensions.textL,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border(
              left: BorderSide(
                color: Colors.grey,
                width: 4,
              ),
            ),
          ),
          child: const Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the,',
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppDimensions.textM,
            ),
          ),
        ),
      ],
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
