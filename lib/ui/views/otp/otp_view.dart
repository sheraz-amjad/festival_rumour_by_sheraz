import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/utils/backbutton.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'opt_view_model.dart';

class OtpView extends BaseView<OtpViewModel> {
  const OtpView({super.key});

  @override
  OtpViewModel createViewModel() => OtpViewModel();

  @override
  Widget buildView(BuildContext context, OtpViewModel viewModel) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 👈 Background extends behind status bar
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// 🔹 Background image (full screen, including status bar)
          const Positioned.fill(
            child: Image(
              image: AssetImage(AppAssets.bottomsheet),
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Foreground content inside SafeArea
          SafeArea(
            child: Center(
              child: ResponsiveContainer(
                mobileMaxWidth: double.infinity,
                tabletMaxWidth: 500,
                desktopMaxWidth: 600,
                child: Padding(
                  padding: context.isLargeScreen
                      ? const EdgeInsets.symmetric(horizontal: 80, vertical: 60)
                      : context.isMediumScreen
                      ? const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 40)
                      : const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 30),
                  child: Column(
                    children: [
                      /// 🔹 Top Back Button
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomBackButton(onTap: () => context.pop()),
                      ),

                      const Spacer(),

                      /// 🔹 Header Section
                      const _HeaderTexts(),
                      const SizedBox(height: AppDimensions.paddingL),

                      /// 🔹 OTP Input
                      _OtpInput(viewModel: viewModel),
                      const SizedBox(height: AppDimensions.paddingXL),

                      /// 🔹 Sign Up Button
                      _SignupButton(viewModel: viewModel),
                      const SizedBox(height: AppDimensions.spaceM),

                      /// 🔹 Resend Button
                      _ResendButton(viewModel: viewModel),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 Header Texts (Title + Description)
class _HeaderTexts extends StatelessWidget {
  const _HeaderTexts();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          AppStrings.enterCode,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: AppDimensions.spaceS),
        Text(
          AppStrings.enterOtpDescription,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

/// 🔹 OTP Input
class _OtpInput extends StatelessWidget {
  final OtpViewModel viewModel;

  const _OtpInput({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinCodeTextField(
          appContext: context,
          length: 4,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          autoFocus: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.circle,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            fieldHeight: AppDimensions.buttonHeightXL,
            fieldWidth: AppDimensions.buttonHeightXL,
            activeFillColor: AppColors.onPrimary,
            inactiveFillColor: AppColors.onPrimary,
            selectedFillColor: AppColors.onPrimary,
            inactiveColor: Colors.transparent,
            selectedColor: Colors.transparent,
            activeColor: Colors.transparent,
          ),
          textStyle: const TextStyle(
            color: AppColors.primary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: AppColors.primary,
          animationDuration: const Duration(milliseconds: 200),
          enableActiveFill: true,
          onChanged: (value) {
            viewModel.onCodeChanged(value);
          },
          onCompleted: (value) {
            FocusScope.of(context).unfocus();
            viewModel.verifyCode();
          },
        ),
        if (viewModel.otpError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              viewModel.otpError!,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
      ],
    );
  }
}

/// 🔹 Signup Button
class _SignupButton extends StatelessWidget {
  final OtpViewModel viewModel;

  const _SignupButton({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: viewModel.isOtpValid
              ? AppColors.accent
              : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
        ),
        onPressed:
        viewModel.isOtpValid && !viewModel.isLoading ? viewModel.verifyCode : null,
        child: viewModel.isLoading
            ? const SizedBox(
          width: AppDimensions.iconM,
          height: AppDimensions.iconM,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
        )
            : const Text(
          AppStrings.signUp,
          style: TextStyle(
            color: AppColors.onPrimary,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

/// 🔹 Resend Button
class _ResendButton extends StatelessWidget {
  final OtpViewModel viewModel;

  const _ResendButton({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: viewModel.isLoading ? null : viewModel.resendCode,
      child: const Text(
        AppStrings.resendCode,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
