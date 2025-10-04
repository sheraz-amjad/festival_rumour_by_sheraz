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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bottomsheet),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
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
        Container(
          height: AppDimensions.iconXXL,
          width: AppDimensions.iconXXL,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(
            AppAssets.logo,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: Container(
            height: AppDimensions.buttonHeightM,
            decoration: BoxDecoration(
              color: AppColors.onPrimary,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.primary, size: AppDimensions.iconM),
                const SizedBox(width: AppDimensions.paddingS),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: AppStrings.searchHint,
                      hintStyle: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.textM,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      filled: false,
                    ),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.textM,
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: AppStrings.allFilter,
                  underline: const SizedBox(),
                  dropdownColor: AppColors.onPrimary,
                  icon: Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingXS),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_drop_down, color: AppColors.onPrimary),
                  ),
                  items: const [
                    DropdownMenuItem(value: AppStrings.allFilter, child: SizedBox()),
                    DropdownMenuItem(value: AppStrings.live, child: Text(AppStrings.live,style: TextStyle(color: AppColors.primary))),
                    DropdownMenuItem(value: AppStrings.upcoming, child: Text(AppStrings.upcoming,style: TextStyle(color: AppColors.primary))),
                    DropdownMenuItem(value: AppStrings.past, child: Text(AppStrings.past,style: TextStyle(color: AppColors.primary))),
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

  Widget _buildEventSlider(BuildContext context, EventViewModel viewModel, PageController pageController) {
    if (viewModel.isLoading && viewModel.events.isEmpty) {
      return const LoadingWidget(message: AppStrings.loadingEvents);
    }

    if (viewModel.events.isEmpty) {
      return const Center(
        child: Text(
          AppStrings.noEventsAvailable,
          style: TextStyle(fontSize: AppDimensions.textM, color: AppColors.onSurfaceVariant),
        ),
      );
    }

    return PageView.builder(
      controller: pageController,
      padEnds: true,
      onPageChanged: (page) {
        viewModel.setPage(page);
      },
      itemBuilder: (context, index) {
        final event = viewModel.events[index % viewModel.events.length];
        return SizedBox(
          width: double.infinity,
          child: ResponsivePadding(
            mobilePadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
            tabletPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            desktopPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
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
      width: double.infinity,
      child: Center(
        child: Container(
          height: AppDimensions.buttonHeightXL,
          width: AppDimensions.buttonHeightXL,
          child: SvgPicture.asset(
            AppAssets.note,
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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
      decoration: BoxDecoration(
        color: AppColors.headlineBackground,
      ),
      child: Text(
        AppStrings.headlineText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: AppDimensions.textL,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
