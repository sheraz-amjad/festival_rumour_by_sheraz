import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:festival_rumour/ui/views/welcome/welcome_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/auth_background.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/utils/snackbar_util.dart';
import '../../../shared/widgets/responsive_widget.dart';

class WelcomeView extends BaseView<WelcomeViewModel> {
  const WelcomeView({super.key});

  @override
  WelcomeViewModel createViewModel() => WelcomeViewModel();

  @override
  Widget buildView(BuildContext context, WelcomeViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          /// Background
          const AuthBackground(),

          /// Bottom Login Box
          Align(
            alignment: Alignment.bottomCenter,
            child: ResponsiveContainer(
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: AppDimensions.tabletWidth,
              desktopMaxWidth: AppDimensions.desktopWidth,
              child: Container(
                width: double.infinity,
                padding:
                    context.isLargeScreen
                        ? const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingL,
                          vertical: AppDimensions.paddingXL,
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

                // Login Buttons
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildGoogleLogin(viewModel,context),
                      const SizedBox(height: 20),
                      _buildEmailLogin(viewModel),
                      const SizedBox(height: 20),
                      _buildAppleLogin(viewModel,context),
                      const SizedBox(height: 20),
                      _buildSignupText(viewModel),
                      const SizedBox(height: 25),
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
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildGoogleLogin(WelcomeViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
        onPressed: () {
          SnackbarUtil.showDevelopmentSnackBar(
            context,
            '🔧 Google login is under development',
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: _buildCircleIcon(AppAssets.googleIcon),
            ),
            const SizedBox(width: 55),
            Expanded(
              child: Text(
                AppStrings.loginWithGoogle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildEmailLogin(WelcomeViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 55, 92, 161),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
        onPressed: viewModel.loginWithEmail,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: _buildCircleIcon(AppAssets.phoneIcon),
            ),
            const SizedBox(width: 35),
            Text(
              AppStrings.loginWithEmailPhone,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppleLogin(WelcomeViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightXL,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
        onPressed: () {
          SnackbarUtil.showDevelopmentSnackBar(
            context,
            '🍎 Apple login is under development',
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: _buildCircleIcon(AppAssets.appleIcon),
            ),
            const SizedBox(width: 55),
            Text(
              AppStrings.loginWithApple,
              style: const TextStyle(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Shared Circle Icon Builder
  Widget _buildCircleIcon(String assetPath) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingS), // padding from constants
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary, // background color for icon circle
      ),
      child: SvgPicture.asset(
        assetPath,
        height: AppDimensions.iconM, // icon size from constants
        width: AppDimensions.iconM,
      ),
    );
  }
  /// 🔹 Signup Text
  Widget _buildSignupText(WelcomeViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.goToSignup,
      child: const Center(
        // <-- Center the text
        child: Text.rich(
          TextSpan(
            text: AppStrings.dontHaveAccount,
            style: TextStyle(color: AppColors.primary, fontSize: 14),
            children: [
              TextSpan(
                text: AppStrings.signupNow,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign:
              TextAlign.center, // ensures text is centered inside its bounds
        ),
      ),
    );
  }
}
