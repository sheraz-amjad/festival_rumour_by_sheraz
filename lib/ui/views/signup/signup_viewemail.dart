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
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const AuthBackground(),

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
                    ? const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 36)
                    : const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 28),
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
                      _buildEmailField(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingM),
                      _buildPasswordField(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingM),
                      _buildConfirmPasswordField(context, viewModel),
                      const SizedBox(height: AppDimensions.paddingL),
                      _buildContinueButton(context, viewModel),
                    ],
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
        const SizedBox(width: AppDimensions.spaceL),
        const Text(
          AppStrings.signUp,
          style: TextStyle(
            fontSize: AppDimensions.textXL,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(
      BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      controller: viewModel.emailController,
      focusNode: viewModel.emailFocus,
      autofocus: true, // Auto-focus on first field
      style: const TextStyle(color: AppColors.primary),
      decoration: InputDecoration(
        labelText: AppStrings.emailLabel,
        hintText: AppStrings.emailHint,
        labelStyle: const TextStyle(color: AppColors.primary),
        hintStyle: const TextStyle(color: AppColors.primary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
        ),
        errorText: viewModel.emailError,
        errorStyle: const TextStyle(
          color: AppColors.accent,
          fontSize: AppDimensions.textS,
          fontWeight: FontWeight.w500,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => viewModel.handleEmailSubmitted(),
      onChanged: (value) {
        // Clear error when user starts typing
        if (viewModel.emailError != null) {
          viewModel.emailError = null;
          viewModel.notifyListeners();
        }
      },
    );
  }

  /// Password field with visibility toggle
  Widget _buildPasswordField(
      BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      controller: viewModel.passwordController,
      focusNode: viewModel.passwordFocus,
      obscureText: !viewModel.isPasswordVisible, // 👁️ toggle state
      style: const TextStyle(color: AppColors.primary),
      decoration: InputDecoration(
        labelText: AppStrings.passwordLabel,
        hintText: AppStrings.passwordHint,
        labelStyle: const TextStyle(color: AppColors.primary),
        hintStyle: const TextStyle(color: AppColors.primary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
        ),
        errorText: viewModel.passwordError,
        errorStyle: const TextStyle(
          color: AppColors.accent,
          fontSize: AppDimensions.textS,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.primary,
          ),
          onPressed: viewModel.togglePasswordVisibility,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => viewModel.handlePasswordSubmitted(),
      onChanged: (value) {
        // Clear error when user starts typing
        if (viewModel.passwordError != null) {
          viewModel.passwordError = null;
          viewModel.notifyListeners();
        }
      },
    );
  }

  /// Confirm password field with visibility toggle
  Widget _buildConfirmPasswordField(
      BuildContext context, SignupViewEmailModel viewModel) {
    return TextField(
      controller: viewModel.confirmPasswordController,
      focusNode: viewModel.confirmPasswordFocus,
      obscureText: !viewModel.isConfirmPasswordVisible, // 👁️ toggle state
      style: const TextStyle(color: AppColors.primary),
      decoration: InputDecoration(
        labelText: AppStrings.confirmPasswordLabel,
        hintText: AppStrings.confirmPasswordHint,
        labelStyle: const TextStyle(color: AppColors.primary),
        hintStyle: const TextStyle(color: AppColors.primary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
        ),
        errorText: viewModel.confirmPasswordError,
        errorStyle: const TextStyle(
          color: AppColors.accent,
          fontSize: AppDimensions.textS,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.isConfirmPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.primary,
          ),
          onPressed: viewModel.toggleConfirmPasswordVisibility,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => viewModel.handleConfirmPasswordSubmitted(),
      onChanged: (value) {
        // Clear error when user starts typing
        if (viewModel.confirmPasswordError != null) {
          viewModel.confirmPasswordError = null;
          viewModel.notifyListeners();
        }
      },
    );
  }

  Widget _buildContinueButton(
      BuildContext context, SignupViewEmailModel viewModel) {
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
        onPressed: viewModel.isLoading
            ? null
            : () {
          viewModel.unfocusAll(); // Use viewModel method instead of FocusScope
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
          style: TextStyle(
            color: AppColors.onPrimary,
            fontSize: AppDimensions.textL,
          ),
        ),
      ),
    );
  }
}
