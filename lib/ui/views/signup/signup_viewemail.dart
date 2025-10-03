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
                    ? const EdgeInsets.symmetric(horizontal: 24, vertical: 44)
                    : context.isMediumScreen 
                        ? const EdgeInsets.symmetric(horizontal: 18, vertical: 36)
                        : const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
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
                      const SizedBox(height: AppDimensions.paddingM),

                      /// Email Field
                      _buildEmailField(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingM),

                      /// Password Field
                      _buildPasswordField(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingM),

                      /// Confirm Password Field
                      _buildConfirmPasswordField(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingL),

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
      style: const TextStyle(color: AppColors.primary),
      decoration: const InputDecoration(
        labelText: AppStrings.emailLabel,
        hintText: AppStrings.emailHint,
        labelStyle: TextStyle(color: AppColors.primary),
        hintStyle: TextStyle(color: AppColors.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField(BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      style: const TextStyle(color: AppColors.primary),
      decoration: const InputDecoration(
        labelText: AppStrings.passwordLabel,
        hintText: AppStrings.passwordHint,
        labelStyle: TextStyle(color: AppColors.primary),
        hintStyle: TextStyle(color: AppColors.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
        ),
      ),
      obscureText: true,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      style: const TextStyle(color: AppColors.primary),
      decoration: const InputDecoration(
        labelText: AppStrings.confirmPasswordLabel,
        hintText: AppStrings.confirmPasswordHint,
        labelStyle: TextStyle(color: AppColors.primary),
        hintStyle: TextStyle(color: AppColors.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
        ),
      ),
      obscureText: true,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildContinueButton(BuildContext context, SignupViewEmailModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        ),
        onPressed: viewModel.isLoading ? null : () {
          FocusScope.of(context).unfocus();
          viewModel.goToOtp();
        },
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
            AppStrings.continueText,
                style: TextStyle(color: AppColors.onPrimary, fontSize: 16),
              ),
      ),
    );
  }
}