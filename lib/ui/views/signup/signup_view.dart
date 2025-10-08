import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/auth_background.dart';
import '../../../core/utils/backbutton.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'signup_view_model.dart';

class SignupView extends BaseView<SignupViewModel> {
  const SignupView({super.key});

  @override
  SignupViewModel createViewModel() => SignupViewModel();

  @override
  Widget buildView(BuildContext context, SignupViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// 🔹 Background
          const AuthBackground(),

          /// 🔹 Signup container at bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: ResponsiveContainer(
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: AppDimensions.tabletWidth,
              desktopMaxWidth: AppDimensions.desktopWidth,
              child: Container(
                width: double.infinity,
                padding: context.isLargeScreen
                    ? const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXL,
                  vertical: AppDimensions.paddingXXL,
                )
                    : context.isMediumScreen
                    ? const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingXL,
                )
                    : const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical: AppDimensions.paddingL,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.bottomsheet),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppDimensions.radiusXXL),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: AppDimensions.paddingL),
                      _buildPhoneInput(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingL),
                      _buildDescription(context),
                      const SizedBox(height: AppDimensions.paddingXL),
                      _buildContinueButton(context, viewModel),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🔹 Loader overlay
          if (viewModel.isLoading)
            Container(
              color: AppColors.overlay,
              alignment: Alignment.center,
              child: const LoadingWidget(color: AppColors.onPrimary),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CustomBackButton(onTap: () => context.pop()),
        const SizedBox(width: AppDimensions.spaceS),
        Text(
          AppStrings.signUp,
          style: const TextStyle(
            fontSize: AppDimensions.textXXL,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput(BuildContext context, SignupViewModel viewModel) {
    return Row(
      children: [
        SizedBox(
          width: AppDimensions.countryPickerWidth,
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
            height: AppDimensions.buttonHeightM,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Localizations.override(
              context: context,
              locale: const Locale(AppStrings.localeEnglish),
              child: CountryCodePicker(
                onChanged: (country) {},
                initialSelection: AppStrings.defaultCountryCode,
                favorite: AppStrings.favoriteCountries,
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                padding: EdgeInsets.zero,
                textStyle: const TextStyle(
                  fontSize: AppDimensions.textM,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
                showFlag: true,
                showFlagDialog: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.spaceM),
        Expanded(
          child: TextField(
            controller: viewModel.phoneNumberController,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              hintText: AppStrings.phoneHint,
              hintStyle: const TextStyle(color: AppColors.white),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              errorText: viewModel.phoneNumberError,
              errorStyle: const TextStyle(
                color: AppColors.accent,
                fontSize: AppDimensions.textS,
                fontWeight: FontWeight.w500,
              ),
            ),
            keyboardType: TextInputType.phone,
            cursorColor: AppColors.white,
            onChanged: (_) => viewModel.validatePhone(),
          ),
        ),
      ],
    );
  }


  Widget _buildDescription(BuildContext context) {
    return Text(
      AppStrings.description,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: AppDimensions.textM,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, SignupViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingM),
        ),
        onPressed: viewModel.isLoading ? null : viewModel.goToOtp,
        child: viewModel.isLoading
            ? const SizedBox(
          width: AppDimensions.iconS,
          height: AppDimensions.iconS,
          child: CircularProgressIndicator(
            color: AppColors.accent,
            strokeWidth: 2,
          ),
        )
            :  Text(
          AppStrings.continueText,
          style: TextStyle(
            fontSize: AppDimensions.textL,
            fontWeight: FontWeight.bold,
            color: AppColors.onPrimary,
          ),
        ),
      ),
    );
  }
}
