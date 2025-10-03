import 'package:festival_rumour/ui/views/eventscreen/widgets/eventcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/responsive_widget.dart';
import 'event_view_model.dart';

class EventView extends BaseView<EventViewModel> {
  const EventView({super.key});

  @override
  EventViewModel createViewModel() => EventViewModel();

  @override
  void onViewModelReady(EventViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadEvents();
  }

  @override
  Widget buildView(BuildContext context, EventViewModel viewModel) {
    final pageController = viewModel.pageController;

    return Scaffold(
      body: Container(
        // 🔑 Background is outside SafeArea (covers full screen)
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bottomsheet),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          // 🔑 Only widgets are inside SafeArea
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                child: _buildTopBar(context),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              SizedBox(
                width: double.infinity,
                child: _titleHeadline(context),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: _buildEventSlider(context, viewModel, pageController),
                ),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              SizedBox(
                width: double.infinity,
                child: _buildBottomIcon(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        // 🔹 Left Logo (unchanged)
        Container(
          height: AppDimensions.iconXXL,
          width: AppDimensions.iconXXL,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(AppAssets.logoPng, color: AppColors.primary),
        ),

        const SizedBox(width: AppDimensions.paddingM),

        // 🔹 Search Bar
        // 🔹 Search Bar
        Expanded(
          child: Container(
            height: AppDimensions.buttonHeightM,
            decoration: BoxDecoration(
              color: AppColors.onPrimary, // dark bg
              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // Search Icon
                const Icon(Icons.search, color: AppColors.primary, size: 24),

                const SizedBox(width: 8),

                // Search Placeholder (styled text field)
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      filled: false,
                    ),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                // ⬇️ Dropdown with circular white background icon
                DropdownButton<String>(
                  value: "All",
                  underline: const SizedBox(),
                  dropdownColor: AppColors.onPrimary,
                  icon: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white, // circle bg
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_drop_down, color: AppColors.onPrimary),
                  ),
                  items: const [
                    DropdownMenuItem(value: "All", child: SizedBox()), // no label
                    DropdownMenuItem(value: "Users", child: Text("Users")),
                    DropdownMenuItem(value: "Posts", child: Text("Posts")),
                    DropdownMenuItem(value: "Events", child: Text("Events")),
                  ],
                  onChanged: (value) {
                    debugPrint("Selected: $value");
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildEventSlider(
    BuildContext context,
    EventViewModel viewModel,
    PageController pageController,
  ) {
    if (viewModel.isLoading && viewModel.events.isEmpty) {
      return const LoadingWidget(message: 'Loading events...');
    }

    if (viewModel.events.isEmpty) {
      return const Center(
        child: Text(
          'No events available',
          style: TextStyle(fontSize: 16, color: AppColors.onSurfaceVariant),
        ),
      );
    }

    return PageView.builder(
      controller: pageController,
      padEnds: true,
      //itemCount: viewModel.events.length,
      onPageChanged: (page) {
        viewModel.setPage(page);
      },
      itemBuilder: (context, index) {
        final event = viewModel.events[index % viewModel.events.length];
        return SizedBox(
          // 🔑 force full width
          width: double.infinity,
          child: ResponsivePadding(
            mobilePadding: const EdgeInsets.symmetric(horizontal: 8),
            tabletPadding: const EdgeInsets.symmetric(horizontal: 12),
            desktopPadding: const EdgeInsets.symmetric(horizontal: 16),
            child: EventCard(
              event: event,
              onBack: viewModel.goBack,
              onTap: viewModel.navigateToHome,
              onNext: viewModel.goToNextSlide,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomIcon(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 🔑 full width
      child: Center(
        child: Container(
          height: AppDimensions.buttonHeightXL,
          width: AppDimensions.buttonHeightXL,
          child: SvgPicture.asset(
            "assets/icons/note.svg",
            width: AppDimensions.iconM,
            height: AppDimensions.iconM,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _titleHeadline(BuildContext context) {
    return Container(
      width: double.infinity, // 🔑 full width
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        //borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        AppStrings.headlineText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
