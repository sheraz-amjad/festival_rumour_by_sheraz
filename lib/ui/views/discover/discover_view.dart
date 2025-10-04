import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import 'app_festivals.dart';
import 'category_chip.dart';
import 'discover_viewmodel.dart';

class DiscoverView extends BaseView<DiscoverViewModel> {
  const DiscoverView({super.key});

  @override
  DiscoverViewModel createViewModel() => DiscoverViewModel();

  @override
  Widget buildView(BuildContext context, DiscoverViewModel viewModel) {
    // Filter festivals based on selected category
    final filteredFestivals = AppFestivals.festivals
        .where((fest) => fest['status'] == viewModel.selected)
        .toList();

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(viewModel, filteredFestivals),
    );
  }

  /// AppBar widget
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      title: const Text(AppStrings.selectFestivalsBy),
      titleTextStyle: const TextStyle(
        fontSize: AppDimensions.size25,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: AppColors.black),
        ),
      ],
    );
  }

  /// Main body widget
  Widget _buildBody(DiscoverViewModel viewModel, List<Map<String, String>> festivals) {
    return Column(
      children: [
        _buildCategoryChips(viewModel),
        Expanded(child: _buildFestivalPageView(festivals)),
      ],
    );
  }

  /// Category chip row
  Widget _buildCategoryChips(DiscoverViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CategoryChip(
            label: AppStrings.live,
            isSelected: viewModel.selected == AppStrings.live,
            onTap: () => viewModel.select(AppStrings.live),
          ),
          CategoryChip(
            label: AppStrings.upcoming,
            isSelected: viewModel.selected == AppStrings.upcoming,
            onTap: () => viewModel.select(AppStrings.upcoming),
          ),
          CategoryChip(
            label: AppStrings.past,
            isSelected: viewModel.selected == AppStrings.past,
            onTap: () => viewModel.select(AppStrings.past),
          ),
        ],
      ),
    );
  }

  /// Festival PageView widget
  Widget _buildFestivalPageView(List<Map<String, String>> festivals) {
    if (festivals.isEmpty) {
      return Center(
        child: Text(
          AppStrings.noEventsAvailable,
          style: const TextStyle(fontSize: AppDimensions.textL),
        ),
      );
    }

    return PageView.builder(
      itemCount: festivals.length,
      itemBuilder: (context, index) {
        final fest = festivals[index];
        return _buildFestivalCard(fest);
      },
    );
  }

  /// Single Festival card widget
  Widget _buildFestivalCard(Map<String, String> fest) {
    return Card(
      margin: const EdgeInsets.all(AppDimensions.paddingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            child: Image.asset(
              fest['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingS,
                  vertical: AppDimensions.paddingXS),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Text(
                fest['status']!,
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fest['title']!,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: AppDimensions.textTitle,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  fest['date']!,
                  style: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
