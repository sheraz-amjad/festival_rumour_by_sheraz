import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import 'discover_viewmodel.dart';

class DiscoverView extends BaseView<DiscoverViewModel> {
  const DiscoverView({super.key});

  @override
  DiscoverViewModel createViewModel() => DiscoverViewModel();

  @override
  Widget buildView(BuildContext context, DiscoverViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.selectFestivalsBy),
        titleTextStyle: const TextStyle(
          fontSize: AppDimensions.size25,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CategoryChip(AppStrings.live, viewModel.selected == AppStrings.live, () => viewModel.select(AppStrings.live)),
                _CategoryChip("Upcoming", viewModel.selected == "Upcoming", () => viewModel.select("Upcoming")),
                _CategoryChip("Past", viewModel.selected == "Past", () => viewModel.select("Past")),
              ],
            ),
          ),

          Expanded(
            child: PageView.builder(
              itemCount: viewModel.festivals.length,
              itemBuilder: (context, index) {
                final fest = viewModel.festivals[index];
                return Card(
                  margin: const EdgeInsets.all(AppDimensions.paddingM),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                        child: Image.asset(fest['image']!, fit: BoxFit.cover, width: double.infinity),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS, vertical: AppDimensions.paddingXS),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          ),
                          child: const Text(AppStrings.live, style: TextStyle(color: AppColors.white)),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fest['title']!, style: const TextStyle(color: AppColors.white, fontSize: AppDimensions.textTitle, fontWeight: FontWeight.bold)),
                            Text(fest['date']!, style: const TextStyle(color: AppColors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip(this.label, this.isSelected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? AppColors.black : AppColors.grey200,
        labelStyle: TextStyle(color: isSelected ? AppColors.white : AppColors.black),
      ),
    );
  }
}
