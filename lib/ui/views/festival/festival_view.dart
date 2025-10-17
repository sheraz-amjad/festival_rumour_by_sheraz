import 'package:festival_rumour/ui/views/festival/widgets/festivalcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/responsive_widget.dart';
import 'festival_view_model.dart';

class FestivalView extends BaseView<FestivalViewModel> {
  const FestivalView({super.key});

  @override
  FestivalViewModel createViewModel() => FestivalViewModel();

  @override
  void onViewModelReady(FestivalViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadFestivals();
  }

  @override
  Widget buildView(BuildContext context, FestivalViewModel viewModel) {
    final pageController = viewModel.pageController;

    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        viewModel.unfocusSearch();
      },
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// 🖼 Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.bottomsheet),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🎨 Overlay layer (white or black tint)
          Container(
            color: AppColors.primary.withOpacity(0.3), // You can tweak opacity (0.1–0.4)
          ),

          /// 🧱 Foreground content
          SafeArea(
            child: ResponsiveContainer(
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: AppDimensions.tabletWidth,
              desktopMaxWidth: AppDimensions.desktopWidth,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTopBarWithSearch(context, viewModel),
                const SizedBox(height: AppDimensions.paddingS),
                _titleHeadline(context),
                const SizedBox(height: AppDimensions.paddingS),
                Expanded(
                    child: _buildFestivalsSlider(context, viewModel, pageController),
                ),
                const SizedBox(height: AppDimensions.paddingS),
                _buildBottomIcon(context),
              ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }


  Widget _buildTopBarWithSearch(BuildContext context, FestivalViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Row(
      children: [
          // Logo
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
          
          // Search Bar (same design as home view)
        Expanded(
          child: Container(
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
                Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return TextField(
                          focusNode: viewModel.searchFocusNode,
                          decoration: InputDecoration(
                            hintText: "Search festivals...",
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

                  /// 🔹 Dropdown Filter (same as home view)
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'all',
                      dropdownColor: AppColors.onPrimary.withOpacity(0.5),
                      isExpanded: false,
                      menuWidth: double.infinity,
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.30,
                  icon: Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingXS),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                        child: const Icon(Icons.keyboard_arrow_up, color: AppColors.onPrimary, size: 16),
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
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.grid_view,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const ResponsiveTextWidget(
                                'All Festivals',
                                textType: TextType.caption,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'live',
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.live_tv,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const ResponsiveTextWidget(
                                'Live',
                                textType: TextType.caption,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'upcoming',
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.schedule,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const ResponsiveTextWidget(
                                'Upcoming',
                                textType: TextType.caption,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'past',
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.history,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const ResponsiveTextWidget(
                                'Past',
                                textType: TextType.caption,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                  ],
                  onChanged: (value) {
                        if (value != null) {
                          // Handle filter change
                          debugPrint("Selected Filter: $value");
                        }
                  },
                    ),
                ),
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildFestivalsSlider(BuildContext context, FestivalViewModel viewModel, PageController pageController) {
    if (viewModel.isLoading && viewModel.festivals.isEmpty) {
      return LoadingWidget(message: AppStrings.loadingfestivals);
    }

    // Show filtered festivals if there's a search query, otherwise show all festivals
    final festivalsToShow = viewModel.searchQuery.isNotEmpty ? viewModel.filteredFestivals : viewModel.festivals;

    if (festivalsToShow.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: AppDimensions.spaceM),
            ResponsiveTextWidget(
              viewModel.searchQuery.isNotEmpty 
                ? "No festivals found for '${viewModel.searchQuery}'"
                : AppStrings.noFestivalsAvailable,
              textType: TextType.body,
              color: AppColors.onSurfaceVariant,
              textAlign: TextAlign.center,
            ),
            if (viewModel.searchQuery.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.spaceS),
              TextButton(
                onPressed: () => viewModel.clearSearch(),
                child: const ResponsiveTextWidget(
                  "Clear search",
                  textType: TextType.body, color: AppColors.primary),
                ),
            ],
          ],
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
        final festival = festivalsToShow[index % festivalsToShow.length];
        return SizedBox(
          width: double.infinity,
          child: ResponsivePadding(
            mobilePadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
            tabletPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            desktopPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
            child: FestivalCard(
              festival: festival,
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
    return Center(
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
    );
  }

  Widget _titleHeadline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
      decoration: BoxDecoration(
        color: AppColors.headlineBackground,
      ),
      child: ResponsiveTextWidget(
        AppStrings.headlineText,
        textAlign: TextAlign.center,
        textType: TextType.title,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}
