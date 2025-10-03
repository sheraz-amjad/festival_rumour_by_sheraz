import 'package:festival_rumour/ui/views/welcome/welcome_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/group_image.dart';
import '../../../core/utils/auth_background.dart';
import '../../../core/utils/base_view.dart';

class WelcomeView extends BaseView<WelcomeViewModel> {
  const WelcomeView({super.key});

  @override
  WelcomeViewModel createViewModel() => WelcomeViewModel();

  @override
  Widget buildView(BuildContext context, WelcomeViewModel viewModel) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          const AuthBackground(),

          /// Bottom Login Box
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
                child: Stack(
                  children: [
                    /// Background Images
                    const GroupedImages(
                      topImage: AppAssets.part1,
                      bottomImage: AppAssets.part2,
                      spacing: 12,
                      size: 140,
                    ),

                    /// Login Buttons
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildGoogleLogin(viewModel),
                        const SizedBox(height: 12),

                        _buildEmailLogin(viewModel),
                        const SizedBox(height: 12),

                        _buildAppleLogin(viewModel),
                        const SizedBox(height: 20),

                        _buildSignupText(viewModel),
                      ],
                    ),
                  ],
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
  /// 🔹 Google Login Button
  Widget _buildGoogleLogin(WelcomeViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightL, // height from constants
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
        onPressed: viewModel.loginWithGoogle,
        icon: SvgPicture.asset(
          AppAssets.googleIcon,
          height: AppDimensions.iconM, // icon size from constants
        ),
        label: const Text(
          AppStrings.loginWithGoogle,
          style: TextStyle(color: Colors.white), // no font size
        ),
      ),
    );
  }

  /// 🔹 Email Login Button
  Widget _buildEmailLogin(WelcomeViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightL,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 55, 92, 161),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
        onPressed: viewModel.loginWithEmail,
        icon: _buildCircleIcon(AppAssets.phoneIcon),
        label: const Text(
          AppStrings.loginWithEmailPhone,
          style: TextStyle(color: Colors.white), // no font size
        ),
      ),
    );
  }

  /// 🔹 Apple Login Button
  Widget _buildAppleLogin(WelcomeViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightL,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
        onPressed: viewModel.loginWithApple,
        icon: _buildCircleIcon(AppAssets.appleIcon),
        label: const Text(
          AppStrings.loginWithApple,
          style: TextStyle(color: AppColors.white), // no font size
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
        color: AppColors.onPrimary,
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
      child: const Text.rich(
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
      ),
    );
  }
}
