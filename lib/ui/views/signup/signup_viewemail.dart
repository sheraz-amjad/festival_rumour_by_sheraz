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
import 'signup_viewemail_model.dart';

class SignupViewEmail extends BaseView<SignupViewEmailModel> {
  const SignupViewEmail({super.key});

  @override
  SignupViewEmailModel createViewModel() => SignupViewEmailModel();

  @override
  Widget buildView(BuildContext context, SignupViewEmailModel viewModel) {
    return Scaffold(
      body: Stack(
        children: [
          const AuthBackground(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea( // ✅ Prevent overlay from navigation bar
              top: false,
              child: ResponsiveContainer(
                mobileMaxWidth: double.infinity,
                tabletMaxWidth: double.infinity,
                desktopMaxWidth: double.infinity,
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
                      top: Radius.circular(AppDimensions.radiusL),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: AppDimensions.paddingM),
                        _buildEmailField(context, viewModel),
                        const SizedBox(height: AppDimensions.paddingM),
                        _buildPasswordField(context, viewModel),
                        const SizedBox(height: AppDimensions.paddingM),
                        _buildConfirmPasswordField(context, viewModel),
                        const SizedBox(height: AppDimensions.paddingXL),
                        _buildContinueButton(context, viewModel),
                        const SizedBox(height: AppDimensions.paddingL),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),


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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
  Widget _buildEmailField(BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      controller: viewModel.emailController,
      style: const TextStyle(color: AppColors.primary),
      keyboardType: TextInputType.emailAddress,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: AppStrings.emailLabel,
        hintText: AppStrings.emailHint,
        labelStyle: const TextStyle(color: AppColors.primary),
        hintStyle: const TextStyle(color: AppColors.primary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.accent, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorText: viewModel.emailError,
        errorStyle: const TextStyle(
          color: AppColors.accent, // ✅ white validation message
          fontSize: AppDimensions.textS,
          fontWeight: FontWeight.w500,
        ),// 👈 show validation error
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      controller: viewModel.passwordController,
      style: const TextStyle(color: AppColors.primary),
      obscureText: true,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: AppStrings.passwordLabel,
        hintText: AppStrings.passwordHint,
        labelStyle: const TextStyle(color: AppColors.primary),
        hintStyle: const TextStyle(color: AppColors.primary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.accent, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorText: viewModel.passwordError,
        errorStyle: const TextStyle(
          color: AppColors.accent, // ✅ white validation message
          fontSize: AppDimensions.textS,
          fontWeight: FontWeight.w500,
        ),// // 👈 show validation error
      ),
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      controller: viewModel.confirmPasswordController,
      style: const TextStyle(color: AppColors.primary),
      obscureText: true,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: AppStrings.confirmPasswordLabel,
        hintText: AppStrings.confirmPasswordHint,
        labelStyle: const TextStyle(color: AppColors.primary),
        hintStyle: const TextStyle(color: AppColors.primary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.accent, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorText: viewModel.confirmPasswordError,
        errorStyle: const TextStyle(
          color: AppColors.accent, // ✅ white validation message
          fontSize: AppDimensions.textS,
          fontWeight: FontWeight.w500,
        ),// 👈 show validation error
      ),
    );
  }
  Widget _buildContinueButton(BuildContext context, SignupViewEmailModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingXS),
        ),
        onPressed: viewModel.isLoading
            ? null
            : () {
          FocusScope.of(context).unfocus();
          viewModel.goToOtp();
        },
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
          AppStrings.continueText,
          style: TextStyle(color: AppColors.onPrimary, fontSize: AppDimensions.textXL),
        ),
      ),
    );
  }
}
