import 'package:festival_rumour/ui/views/welcome/widget/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:festival_rumour/ui/views/welcome/welcome_view_model.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/auth_background.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_widget.dart';

class WelcomeView extends BaseView<WelcomeViewModel> {
  const WelcomeView({super.key});

  @override
  WelcomeViewModel createViewModel() => WelcomeViewModel();

  @override
  Widget buildView(BuildContext context, WelcomeViewModel viewModel) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardVisible = mediaQuery.viewInsets.bottom > 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            /// 🖼️ Background
            const AuthBackground(),

            /// 🌫️ Overlay for dim effect
            Container(color: Colors.black.withOpacity(0.5)),

            /// 🧱 Bottom Login Section
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  reverse: true,
                  padding: EdgeInsets.only(
                    bottom: keyboardVisible ? mediaQuery.viewInsets.bottom : 0,
                  ),
                  child: ResponsiveContainer(
                    mobileMaxWidth: double.infinity,
                    tabletMaxWidth: AppDimensions.tabletWidth,
                    desktopMaxWidth: AppDimensions.desktopWidth,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.bottomsheet),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppDimensions.radiusL),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingL,
                        vertical: AppDimensions.paddingXXL,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// 🔹 Google Login
                          LoginButton(
                            iconPath: AppAssets.googleIcon,
                            text: AppStrings.loginWithGoogle,
                            bgColor: Colors.red,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "🧠 Google Sign-In is under development",
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          /// 🔹 Email Login
                          LoginButton(
                            iconPath: AppAssets.phoneIcon,
                            text: AppStrings.loginWithEmailPhone,
                            bgColor: const Color.fromARGB(255, 55, 92, 161),
                            onTap: viewModel.loginWithEmail,
                          ),

                          const SizedBox(height: 20),

                          /// 🔹 Apple Login
                          LoginButton(
                            iconPath: AppAssets.appleIcon,
                            text: AppStrings.loginWithApple,
                            bgColor: AppColors.black,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "🍏 Apple Sign-In is under development",
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 25),

                          /// 🔹 Signup Text
                          _buildSignupText(viewModel),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// ⏳ Loader
            if (viewModel.isLoading)
              Container(
                color: Colors.black45,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Signup Text
  Widget _buildSignupText(WelcomeViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.goToSignup,
      child: const Center(
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
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
