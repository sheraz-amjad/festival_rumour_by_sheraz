import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/appbar.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'first_name_view_model.dart';

class FirstNameView extends BaseView<FirstNameViewModel> {
  const FirstNameView({super.key});

  @override
  FirstNameViewModel createViewModel() => FirstNameViewModel();

  @override
  Widget buildView(BuildContext context, FirstNameViewModel viewModel) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// Main content
          Positioned.fill(
            child: ResponsiveContainer(
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: double.infinity,
              desktopMaxWidth: double.infinity,
              child: Container(
                padding: context.isLargeScreen
                    ? const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXL,
                  vertical: AppDimensions.paddingXL,
                )
                    : context.isMediumScreen
                    ? const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingL,
                )
                    : const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical: AppDimensions.paddingL,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.firstnameback),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppDimensions.radiusL),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimensions.spaceXXL),

                    ResponsiveText(
                      "What's your first name?",
                      style: const TextStyle(
                        fontSize: 40, // only heading uses font size
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingL),

                    _buildNameInput(context, viewModel),
                    const SizedBox(height: AppDimensions.paddingXL),

                    const ResponsiveText(
                      "This is how it'll appear on your profile.\nCan't change it later.",
                      style: TextStyle(color: AppColors.primary),
                    ),

                    const Spacer(),

                    _buildNextButton(context, viewModel),
                  ],
                ),
              ),
            ),
          ),

          /// Back button
          _buildBackButton(context),

          /// Welcome dialog
          if (viewModel.showWelcome) _buildWelcomeDialog(context, viewModel),
        ],
      ),
    );
  }

  /// 🔹 Name input field
  Widget _buildNameInput(BuildContext context, FirstNameViewModel viewModel) {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Enter first name",
        border: UnderlineInputBorder(),
        hintStyle: TextStyle(color: AppColors.grey400),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onPrimary, width: 0),
        ),
      ),
      style: const TextStyle(color: AppColors.primary),
      onChanged: viewModel.onNameChanged,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) {
        FocusScope.of(context).unfocus();
        if (viewModel.isNameEntered) {
          viewModel.onNextPressed();
        }
      },
    );
  }

  /// 🔹 Next button
  Widget _buildNextButton(BuildContext context, FirstNameViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          viewModel.isNameEntered ? AppColors.accent : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        ),
        onPressed: viewModel.isNameEntered && !viewModel.isLoading
            ? () {
          FocusScope.of(context).unfocus();
          viewModel.onNextPressed();
        }
            : null,
        child: viewModel.isLoading
            ? const SizedBox(
          width: AppDimensions.iconS,
          height: AppDimensions.iconS,
          child: CircularProgressIndicator(
            color: AppColors.accent,
            strokeWidth: 2,
          ),
        )
            : const Text(
          AppStrings.next,
          style: TextStyle(color: AppColors.onPrimary),
        ),
      ),
    );
  }

  /// 🔹 Back button
  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      left: AppDimensions.paddingM,
      top: AppDimensions.spaceXL,
      child: Container(
        width: AppDimensions.iconL,
        height: AppDimensions.iconL,
        decoration: const BoxDecoration(
          color: AppColors.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back,
              size: AppDimensions.iconM, color: AppColors.onSurface),
          onPressed: () =>
              Provider.of<FirstNameViewModel>(context, listen: false).goBack(),
        ),
      ),
    );
  }

  /// 🔹 Welcome dialog
  Widget _buildWelcomeDialog(BuildContext context, FirstNameViewModel viewModel) {
    return Container(
      alignment: Alignment.center,
      child: ResponsiveContainer(
        mobileMaxWidth: double.infinity,
        tabletMaxWidth: 500,
        desktopMaxWidth: 600,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            color: AppColors.onPrimary,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ✅ Background image only at bottom-right
              Positioned(
                bottom: 0,
                right: 0,
            // adjust visibility
                  child: Image.asset(
                  AppAssets.welcomeback,  // your image asset
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),

              // ✅ Foreground content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("👋", style: TextStyle(fontSize: 40)),
                  const SizedBox(height: AppDimensions.spaceS),

                  ResponsiveText(
                    "Welcome! ${viewModel.firstName}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.spaceS),

                  const ResponsiveText(
                    "There's a lot out there to discover,\n"
                        "but let's get your profile set up first.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.primary),
                  ),
                  const SizedBox(height: AppDimensions.paddingL),

                  Column(
                    children: [
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDimensions.paddingM,
                            ),
                          ),
                          onPressed: viewModel.continueToNext,
                          child: const Text(
                            "Let's Go",
                            style: TextStyle(color: AppColors.onPrimary),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppDimensions.spaceS),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          onPressed: viewModel.onEditName,
                          child: const Text(
                            "Edit Name",
                            style: TextStyle(color: AppColors.accent),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
