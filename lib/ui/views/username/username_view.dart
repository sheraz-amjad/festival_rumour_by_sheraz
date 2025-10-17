import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/responsive_widget.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import 'username_view_model.dart';


class UsernameView extends StatelessWidget {
  const UsernameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsernameViewModel(),
      child: Consumer<UsernameViewModel>(
        builder: (context, viewModel, _) {
          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                /// 🔹 Background
                Image.asset(AppAssets.usernameback, fit: BoxFit.cover),

                /// 🔹 Overlay
                Container(color: AppColors.overlayBlack45),

                /// 🔹 Content (moves up on keyboard)
                AnimatedPadding(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.only(bottom: keyboardHeight * 0.6),
                  child: Center(
                    child: ResponsiveContainer(
                      mobileMaxWidth: double.infinity,
                      tabletMaxWidth: AppDimensions.tabletWidth,
                      desktopMaxWidth: AppDimensions.desktopWidth,
                      child: ResponsivePadding(
                        mobilePadding: EdgeInsets.symmetric(
                          horizontal: screenWidth *0.04,
                          vertical: screenHeight * 0.02,
                        ),
                        tabletPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2,
                          vertical: screenHeight * 0.02,
                        ),
                        desktopPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.25,
                          vertical: screenHeight * 0.02,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Logo
                          SvgPicture.asset(
                            AppAssets.logo,
                            height: context.isLargeScreen 
                              ? screenHeight * 0.22
                              : context.isMediumScreen 
                                ? screenHeight * 0.20
                                : screenHeight * 0.18,
                            color: AppColors.primary,
                          ),
                          SizedBox(height: screenHeight * 0.04),

                          /// Login Card
                          Container(
                            padding: const EdgeInsets.all(AppDimensions.paddingM),
                            decoration: BoxDecoration(
                              color: AppColors.onPrimary.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                /// Username Label
                                Row(
                                  children: [
                                    ResponsiveTextWidget(
                                      AppStrings.username,
                                      textType: TextType.body,
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ResponsiveTextWidget(
                                      AppStrings.asterisk,
                                      textType: TextType.body,
                                      color: AppColors.error,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppDimensions.spaceS),

                                /// Username Field
                                Focus(
                                  onFocusChange: viewModel.onUsernameFocusChange,
                                  child: TextField(
                                    controller: viewModel.emailController,
                                    cursorColor: AppColors.white,

                                    onChanged: viewModel.onUsernameChanged,
                                    style: const TextStyle(color: AppColors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primary.withOpacity(0.3),
                                      hintText: AppStrings.enterYourEmail,
                                      hintStyle: const TextStyle(color: AppColors.white70),
                                      errorText: viewModel.emailError,
                                      errorStyle: const TextStyle(
                                        color: AppColors.accent, // ✅ white validation message
                                        fontSize: AppDimensions.textS,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                        const BorderSide(color: AppColors.white, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                        const BorderSide(color: AppColors.white60, width: 1),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: AppDimensions.spaceM),

                                /// Password Label
                                Row(
                                  children: [
                                    ResponsiveTextWidget(
                                      AppStrings.password,
                                      textType: TextType.body,
                                      color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                          ]
                                    ),
                                    ResponsiveTextWidget(
                                      AppStrings.asterisk,
                                      textType: TextType.body,
                                      color: AppColors.error
                                    ),
                                const SizedBox(height: AppDimensions.spaceS),

                                /// Password Field
                                Focus(
                                  onFocusChange: viewModel.onPasswordFocusChange,
                                  child: TextField(
                                    controller: viewModel.passwordController,
                                    obscureText: !viewModel.isPasswordVisible,
                                    cursorColor: AppColors.white,
                                    onChanged: viewModel.onPasswordChanged,
                                    style: const TextStyle(color: AppColors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primary.withOpacity(0.3),
                                      hintText: AppStrings.passwordPlaceholder,
                                      hintStyle: const TextStyle(color: AppColors.white70),
                                      errorText: viewModel.passwordError,
                                      errorStyle: const TextStyle(
                                        color: AppColors.accent, // ✅ white validation message
                                        fontSize: AppDimensions.textS,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          viewModel.isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white70,
                                          size: 20,
                                        ),
                                        onPressed: viewModel.togglePasswordVisibility,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                        const BorderSide(color: AppColors.white, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                        const BorderSide(color: AppColors.white60, width: 1),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: AppDimensions.spaceS),

                                /// Remember + Forgot
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: viewModel.rememberMe,
                                          onChanged: viewModel.toggleRememberMe,
                                          activeColor: AppColors.onPrimary,
                                        ),
                                        const ResponsiveTextWidget(
                                          AppStrings.rememberMe,
                                          textType: TextType.body,
                                      color: AppColors.primary),
                                      ],
                                    ),
                                    const ResponsiveTextWidget(
                                      AppStrings.forgotPassword,
                                      textType: TextType.body,
                                      color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  ],
                                ),

                                const SizedBox(height: AppDimensions.spaceM),

                                /// Login Button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accent,
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  onPressed: viewModel.isLoading
                                      ? null
                                      : () => viewModel.validateAndLogin(context),
                                  child: viewModel.isLoading
                                      ? const CircularProgressIndicator(
                                    color: AppColors.accent,
                                  )
                                      : const ResponsiveTextWidget(
                                    AppStrings.login,
                                    textType: TextType.body,
                                      color: AppColors.onPrimary,
                                     // fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                const SizedBox(height: AppDimensions.spaceM),

                                /// Sign Up Text
                                /// Sign Up Text
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const ResponsiveTextWidget(
                                      AppStrings.dontHaveAccount,
                                      textType: TextType.body,
                                      color: AppColors.primary),
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () => viewModel.goToSignUp(context),
                                      child: const ResponsiveTextWidget(
                                        AppStrings.signUp,
                                        textType: TextType.body,
                                          color: AppColors.accent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
