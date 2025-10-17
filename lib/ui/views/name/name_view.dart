import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'name_view_model.dart';

class NameView extends BaseView<NameViewModel> {
  const NameView({super.key});

  @override
  NameViewModel createViewModel() => NameViewModel();

  @override
  Widget buildView(BuildContext context, NameViewModel viewModel) {
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
                      const ResponsiveTextWidget(
                        AppStrings.firstNameInfo,
                        textType: TextType.body,
                          color: AppColors.primary
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

  Widget _buildNameInput(BuildContext context, NameViewModel viewModel) {
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


  Widget _buildNextButton(BuildContext context, NameViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
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
            : const ResponsiveTextWidget(
          AppStrings.next,
          textType: TextType.body, color: AppColors.onPrimary),
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
              Provider.of<NameViewModel>(context, listen: false).goBack(),
        ),
      ),
    );
  }

  Widget _buildWelcomeDialog(BuildContext context, NameViewModel viewModel) {
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
                      const ResponsiveTextWidget(AppStrings.emojiWave, textType: TextType.body),
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
                      const ResponsiveTextWidget(
                        AppStrings.welcomeInfo,
                        textAlign: TextAlign.center,
                        textType: TextType.body,
                          color: AppColors.primary
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
                              child: const ResponsiveTextWidget(
                                AppStrings.letsGo,
                                textType: TextType.body, color: AppColors.onPrimary),
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
                              child: const ResponsiveTextWidget(
                                AppStrings.editName,
                                textType: TextType.body, color: AppColors.accent),
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