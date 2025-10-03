import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/auth_background.dart';
import '../../../core/utils/backbutton.dart';
import '../../../shared/widgets/gradient_text.dart';
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
      body: Stack(
        children: [

          /// Background
          const AuthBackground(),

          /// Signup container at bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: ResponsiveContainer(
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: 600,
              desktopMaxWidth: 800,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(0),
                padding: context.isLargeScreen
                    ? const EdgeInsets.symmetric(horizontal: 30, vertical: 60)
                    : context.isMediumScreen
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 50)
                    : const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.bottomsheet),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Back + Title Row
                      _buildHeader(context),
                      const SizedBox(height: AppDimensions.paddingL),

                      /// Phone Row (Country Picker + Number)
                      _buildPhoneInput(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingL),

                      /// Description
                      _buildDescription(context),
                      const SizedBox(height: AppDimensions.paddingXL),

                      /// Continue Button
                      _buildContinueButton(context, viewModel),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Loader
          if (viewModel.isLoading)
            Container(
              color: Colors.black45,
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
        ResponsiveText(
          AppStrings.signUp,
          style: const TextStyle(
            fontSize: 28,
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
          width: 120,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS),
            height: AppDimensions.buttonHeightM,
            decoration: BoxDecoration(
             // border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Localizations.override(
              context: context,
              locale: const Locale('en'),
              child: CountryCodePicker(
                onChanged: (country) {
                  // Handle country selection
                  print("Selected: ${country.dialCode} - ${country.name}");
                },
                initialSelection: 'PK',
                favorite: ['+92', 'PK', 'US'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                padding: EdgeInsets.zero,
                textStyle: const TextStyle(
                  fontSize: 14,
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
            style: const TextStyle(color: AppColors.white),
            decoration: const InputDecoration(
              hintText: "878 7764 2922",
              hintStyle: TextStyle(color: AppColors.white),
              enabledBorder: UnderlineInputBorder(
               // borderSide: BorderSide(color: AppColors.primary),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
            keyboardType: TextInputType.phone,
            cursorColor: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return ResponsiveText(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore",
      style: const TextStyle(color: AppColors.white, fontSize: 14),
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
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        ),
        onPressed: viewModel.isLoading ? null : viewModel.goToOtp,
        child: viewModel.isLoading
            ? const SizedBox(
          width: AppDimensions.iconS,
          height: AppDimensions.iconS,
          child: CircularProgressIndicator(
            color: AppColors.onPrimary,
            strokeWidth: 2,
          ),
        )
            : Text(
        AppStrings.continueText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.onPrimary, // Change to desired color
        ),
      ),
      ),
    );
  }
}


