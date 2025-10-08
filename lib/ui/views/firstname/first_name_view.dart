import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        body: Stack(
          children: [
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
                      //    top: Radius.circular(AppDimensions.radiusL),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimensions.spaceXXL),
                      ResponsiveText(
                        AppStrings.firstNameQuestion,
                        style: const TextStyle(
                          fontSize: AppDimensions.textXXL,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingL),
                      _buildNameInput(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingXL),
                      const ResponsiveText(
                        AppStrings.firstNameInfo,
                        style: TextStyle(color: AppColors.primary),
                      ),
                      const Spacer(),
                      _buildNextButton(context, viewModel),
                    ],
                  ),
                ),
              ),
            ),
            _buildBackButton(context),
            if (viewModel.showWelcome) _buildWelcomeDialog(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput(BuildContext context, FirstNameViewModel viewModel) {
    return TextField(
      focusNode: viewModel.nameFocus,
      autofocus: true, // Auto-focus on first field
      decoration: InputDecoration(
        hintText: AppStrings.firstNameHint,
        hintStyle: const TextStyle(color: AppColors.grey400),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onPrimary, width: 1.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onPrimary, width: 0.8),
        ),
        errorText: viewModel.nameError,
        errorStyle: const TextStyle(
          color: AppColors.accent,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: const TextStyle(color: AppColors.primary),
      keyboardType: TextInputType.name,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        viewModel.onNameChanged(value);
        // Clear error when user starts typing
        if (viewModel.nameError != null) {
        //  viewModel.nameError = null;
          viewModel.notifyListeners();
        }
      },
      onSubmitted: (_) {
        if (viewModel.isNameEntered && viewModel.nameError == null) {
          viewModel.onNextPressed();
        }
      },
    );
  }


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

  Widget _buildWelcomeDialog(BuildContext context, FirstNameViewModel viewModel) {
    return Stack(
      children: [
        // 🟤 Fullscreen black overlay
        Container(
          color: Colors.black54, // translucent background layer
          width: double.infinity,
          height: double.infinity,
        ),

        // 🟢 Centered dialog
        Center(
          child: ResponsiveContainer(
            mobileMaxWidth: double.infinity,
            tabletMaxWidth: double.infinity,
            desktopMaxWidth: double.infinity,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.onPrimary,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("👋", style: TextStyle(fontSize: AppDimensions.textXXL)),
                      const SizedBox(height: AppDimensions.spaceS),
                      ResponsiveText(
                        "${AppStrings.welcome} ${viewModel.firstName}",
                        style: const TextStyle(
                          fontSize: AppDimensions.textL,
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      const ResponsiveText(
                        AppStrings.welcomeInfo,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.primary),
                      ),
                      const SizedBox(height: AppDimensions.paddingL),

                      // Buttons
                      Column(
                        children: [
                          SizedBox(
                            width: AppDimensions.buttonWidth,
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
                                AppStrings.letsGo,
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
                                AppStrings.editName,
                                style: TextStyle(color: AppColors.accent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Positioned welcome image
                  Positioned(
                    bottom: -8,
                    right: -8,
                    child: Image.asset(
                      AppAssets.welcomeback,
                      height: 85,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}