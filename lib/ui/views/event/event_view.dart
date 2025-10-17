import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/backbutton.dart';
import 'event_view_model.dart';

class EventView extends BaseView<EventViewModel> {
  const EventView({super.key});

  @override
  EventViewModel createViewModel() => EventViewModel();

  @override
  Widget buildView(BuildContext context, EventViewModel viewModel) {
    if (viewModel.showEventPreview) {
      return _buildEventPreview(context, viewModel);
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
              _buildEventsCard(context),
              const SizedBox(height: AppDimensions.spaceL),
              _buildToiletsSection(context),
              const SizedBox(height: AppDimensions.spaceM),
              Expanded(
                child: _buildEventCategoryCards(context, viewModel),
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
          const ResponsiveTextWidget(
            'Events',
            textType: TextType.body, 
              color: AppColors.black,
           //                 fontWeight: FontWeight.bold,
            ),
        ],
      ),
    );
  }

  Widget _buildEventsCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      width: double.infinity,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ResponsiveTextWidget(
            'Events',
            textType: TextType.body, 
              color: Colors.white,
              //fontSize: AppDimensions.textXXL,
              fontWeight: FontWeight.bold,
            ),
          const SizedBox(height: AppDimensions.spaceM),
          // Clipboard with checklist icon
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),

            child: Image.asset(
              AppAssets.assignmentIcon, // 👈 your image path constant
              width: AppDimensions.iconXXL,
              height: AppDimensions.iconXXL,
              fit: BoxFit.contain,
            ),
          ),
          // Yellow pencil icon
         ]
      ),
    );
  }

  Widget _buildToiletsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ResponsiveTextWidget(
            'Toilets',
            textType: TextType.body, 
              color: AppColors.black,
              //              fontWeight: FontWeight.bold,
            ),
          GestureDetector(
            onTap: () {
              // Handle view all action
            },
            child: const ResponsiveTextWidget(
              'View All',
              textType: TextType.body,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEventCategoryCards(BuildContext context, EventViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      itemCount: viewModel.eventCategories.length,
      itemBuilder: (context, index) {
        final category = viewModel.eventCategories[index];
        return _buildEventCategoryCard(context, category, index, viewModel);
      },
    );
  }

  Widget _buildEventCategoryCard(BuildContext context, EventCategory category, int index, EventViewModel viewModel) {
    final isSelected = index == 1; // Film Screenings is highlighted
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
         color: isSelected ? const Color(0xFF4CAF50) : Colors.transparent,
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
          // Icon
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              AppAssets.assignmentIcon, // 👈 your image path constant
              width: AppDimensions.iconL,
              height: AppDimensions.iconL,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          
          // Category name
          Expanded(
            child: ResponsiveTextWidget(
              category.name,
              textType: TextType.body,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          // View Detail button
          GestureDetector(
            onTap: () {
              viewModel.showEventPreview = true;
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
              child: const ResponsiveTextWidget(
                'View Detail',
                textType: TextType.caption,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEventPreview(BuildContext context, EventViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildEventPreviewAppBar(context, viewModel),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNewEventInformationSection(context),
                    const SizedBox(height: AppDimensions.spaceL),
                    _buildDetailCardsSection(context),
                    const SizedBox(height: AppDimensions.spaceL),
                    _buildTimeCardsSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventPreviewAppBar(BuildContext context, EventViewModel viewModel) {
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
              viewModel.showEventPreview = false;
              viewModel.notifyListeners();
            },
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
          const ResponsiveTextWidget(
            'New Event Preview',
            textType: TextType.title,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildNewEventInformationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveTextWidget(
          'New Event Information',
          textType: TextType.body, 
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        const SizedBox(height: AppDimensions.spaceM),
        
        // Festival Name Card
        _buildInfoCard(
          context,
          'Festival Name',
          'Magic show',
          Icons.auto_fix_high,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        
        // Title Card
        _buildInfoCard(
          context,
          'Title',
          'Abcde',
          Icons.description,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        
        // Content Card
        _buildContentCard(context),
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
                ResponsiveTextWidget(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                ResponsiveTextWidget(
                  value,
                  style: const TextStyle(
                    color: AppColors.black,
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
        color: const Color(0xFFE3F2FD), // Light blue
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const ResponsiveTextWidget(
                'Content',
                textType: TextType.body, 
                  color: Colors.grey,
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

  Widget _buildDetailCardsSection(BuildContext context) {
    return Column(
      children: [
        // Crowd Capacity Card
        _buildInfoCard(
          context,
          'Crowd Capacity',
          '5000',
          Icons.groups,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        
        // Price Per Person Card
        _buildInfoCard(
          context,
          'Price Per Person',
          '50',
          Icons.person_add_alt_1,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        
        // Total Amount Card
        _buildInfoCard(
          context,
          'Total Amount',
          '25.0000',
          Icons.monetization_on,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        
        // Tax Card
        _buildInfoCard(
          context,
          'Tax',
          '1',
          Icons.receipt_long,
        ),
      ],
    );
  }

  Widget _buildTimeCardsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            context,
            'Start Time',
            '10.00 AM',
            Icons.access_time,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceM),
        Expanded(
          child: _buildInfoCard(
            context,
            'End Time',
            '12:00AM',
            Icons.access_time,
          ),
        ),
      ],
    );
  }
}

class EventCategory {
  final String name;
  final String description;

  EventCategory({
    required this.name,
    required this.description,
  });
}
