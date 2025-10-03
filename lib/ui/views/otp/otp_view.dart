import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
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
import 'opt_view_model.dart';

class OtpView extends BaseView<OtpViewModel> {
  const OtpView({super.key});

  @override
  OtpViewModel createViewModel() => OtpViewModel();

  @override
  Widget buildView(BuildContext context, OtpViewModel viewModel) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: ResponsiveContainer(
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: 600,
              desktopMaxWidth: 800,
              child: Container(
                padding: context.isLargeScreen 
                    ? const EdgeInsets.symmetric(horizontal: 50, vertical: 50)
                    : context.isMediumScreen 
                        ? const EdgeInsets.symmetric(horizontal: 40, vertical: 40)
                        : const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
                    const SizedBox(height: 60),

                    ResponsiveText(
                      AppStrings.enterCode,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceS),

                    ResponsiveText(
                      "Enter the four digit code we sent to you\n+62 873 7764 2922",
                      style: const TextStyle(color: AppColors.primary, fontSize: 15),
                    ),
                    const SizedBox(height: AppDimensions.paddingL),

                    // OTP Input
                    _buildOtpInput(context, viewModel),

                    const SizedBox(height: AppDimensions.paddingXL),

                    // Signup button
                    _buildSignupButton(context, viewModel),

                    const SizedBox(height: AppDimensions.spaceM),

                    // Resend code button
                    _buildResendButton(context, viewModel),
                  ],
                ),
              ),
            ),
          ),
          ),

          // Back button (top left, floating)
          Positioned(
            top: 16,
            left: 16,
            child: CustomBackButton(onTap: () => context.pop()),
          ),
        ],
      ),
    );
  }Widget _buildOtpInput(BuildContext context, OtpViewModel viewModel) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autoFocus: true,
      animationType: AnimationType.fade,

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),

        // Increase size of circles
        fieldHeight: AppDimensions.buttonHeightXL,
        fieldWidth: AppDimensions.buttonHeightXL,

        // Fill colors
        activeFillColor: AppColors.onPrimary,    // No fill color for active
        inactiveFillColor: AppColors.onPrimary,  // No fill color for inactive
        selectedFillColor: AppColors.onPrimary,  // No fill color for selected

        // Border colors
        inactiveColor: Colors.transparent,       // White border
        selectedColor: Colors.transparent,       // White border when selected
        activeColor: Colors.transparent,         // White border for active
      ),

      textStyle: const TextStyle(
        color: AppColors.primary,                // White text color
        fontSize: 30,                           // Slightly larger text
        fontWeight: FontWeight.bold,
      ),
      cursorColor: AppColors.primary,
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: true,
      onChanged: viewModel.onCodeChanged,
      onCompleted: (value) {
        FocusScope.of(context).unfocus();
        viewModel.verifyCode();
      },
    );
  }

  Widget _buildSignupButton(BuildContext context, OtpViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
        ),
        onPressed: viewModel.isLoading ? null : viewModel.verifyCode,
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
                AppStrings.signUp,
                style: TextStyle(color: AppColors.onPrimary, fontSize: 16),
              ),
      ),
    );
  }

  Widget _buildResendButton(BuildContext context, OtpViewModel viewModel) {
    return Center(
      child: TextButton(
        onPressed: viewModel.isLoading ? null : viewModel.resendCode,
        child: const Text(
          AppStrings.resendCode,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
