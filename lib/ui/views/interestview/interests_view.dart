import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/appbar.dart';
import '../../../core/utils/backbutton.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'interests_view_model.dart';

class InterestsView extends BaseView<InterestsViewModel> {
  const InterestsView({super.key});

  @override
  InterestsViewModel createViewModel() => InterestsViewModel();

  @override
  Widget buildView(BuildContext context, InterestsViewModel viewModel) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ResponsiveContainer(
          mobileMaxWidth: double.infinity,
          tabletMaxWidth: 600,
          desktopMaxWidth: 800,
          child: Container(
            padding: context.isLargeScreen 
                ? const EdgeInsets.symmetric(horizontal: 40, vertical: 30)
                : context.isMediumScreen 
                    ? const EdgeInsets.symmetric(horizontal: 30, vertical: 25)
                    : const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.interestback),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                CustomBackButton(onTap: () => context.pop()),
                const SizedBox(height: AppDimensions.spaceM),

                // Heading
                ResponsiveText(
                  "Your Festival Interests",
                  style: const TextStyle(color:AppColors.accent, fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppDimensions.spaceS),
                
                ResponsiveText(
                  "Do their habits match yours? You go first.",
                  style: const TextStyle(color: AppColors.primary),
                ),

                const SizedBox(height: AppDimensions.paddingL),
                
                ResponsiveText(
                  "Choose from categories",
                  style: const TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppDimensions.spaceM),

                // Chips
                Expanded(
                  child: _buildInterestsGrid(context, viewModel),
                ),

                const SizedBox(height: AppDimensions.paddingL),

                // Action buttons
                _buildActionButtons(context, viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildInterestsGrid(BuildContext context, InterestsViewModel viewModel) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: AppDimensions.spaceS,      // horizontal spacing
        runSpacing: AppDimensions.spaceS,   // vertical spacing
        children: viewModel.categories.map((cat) {
          final selected = viewModel.isSelected(cat);
          return _buildInterestChip(cat, selected, viewModel);
        }).toList(),
      ),
    );
  }

  Widget _buildInterestChip(String category, bool selected, InterestsViewModel viewModel) {
    return ChoiceChip(
      showCheckmark: false,
      label: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        child: Text(
          category,
          style: TextStyle(
            color: selected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
      selected: selected,
      onSelected: (_) => viewModel.toggle(category),
      selectedColor: AppColors.accent,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        side: BorderSide(
          color: selected ? AppColors.onPrimary : AppColors.onSurface,
          width: selected ? 2 : 1,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, InterestsViewModel viewModel) {
    return Column(
      children: [
        // Next button
        SizedBox(
          width: double.infinity,
          height: AppDimensions.buttonHeightXL,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: viewModel.hasSelection
                  ? AppColors.accent
                  : AppColors.accent,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
              ),
            ),
            onPressed: viewModel.hasSelection && !viewModel.isLoading
                ? () {
                    FocusScope.of(context).unfocus();
                    viewModel.saveInterests();
                  }
                : null,
            child: viewModel.isLoading
                ? const SizedBox(
                    width: AppDimensions.iconS,
                    height: AppDimensions.iconS,
                    child: CircularProgressIndicator(
                      color: AppColors.onPrimary,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    AppStrings.next,
                    style: TextStyle(fontSize:20,color:  AppColors.onPrimary),
                  ),
          ),
        ),

        const SizedBox(height: AppDimensions.spaceM),
      ],
    );
  }
}
