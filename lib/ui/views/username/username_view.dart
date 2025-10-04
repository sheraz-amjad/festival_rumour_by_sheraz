import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_assets.dart';
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
          final isTablet = screenWidth > 600;
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                /// 🔹 Background
                Image.asset(AppAssets.usernameback, fit: BoxFit.cover),

                /// 🔹 Overlay
                Container(color: Colors.black.withOpacity(0.5)),

                /// 🔹 Content (moves up on keyboard)
                AnimatedPadding(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.only(bottom: keyboardHeight * 0.6),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? screenWidth * 0.2 : 20,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Logo
                          SvgPicture.asset(
                            AppAssets.logo,
                            height: screenHeight * 0.18,
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
                                  children: const [
                                    Text(
                                      AppStrings.username,
                                      style: TextStyle(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " *",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppDimensions.spaceS),

                                /// Username Field
                                Focus(
                                  onFocusChange: viewModel.onUsernameFocusChange,
                                  child: TextField(
                                    controller: viewModel.emailController,
                                    cursorColor: Colors.white,

                                    onChanged: viewModel.onUsernameChanged,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primary.withOpacity(0.3),
                                      hintText: "Enter your email",
                                      hintStyle: const TextStyle(color: Colors.white70),
                                      errorText: viewModel.emailError,
                                      errorStyle: const TextStyle(
                                        color: AppColors.accent, // ✅ white validation message
                                        fontSize: AppDimensions.textS,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                        const BorderSide(color: Colors.white, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                        const BorderSide(color: Colors.white60, width: 1),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: AppDimensions.spaceM),

                                /// Password Label
                                Row(
                                  children: const [
                                    Text(
                                      AppStrings.password,
                                      style: TextStyle(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " *",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppDimensions.spaceS),

                                /// Password Field
                                Focus(
                                  onFocusChange: viewModel.onPasswordFocusChange,
                                  child: TextField(
                                    controller: viewModel.passwordController,
                                    obscureText: !viewModel.isPasswordVisible,
                                    cursorColor: Colors.white,
                                    onChanged: viewModel.onPasswordChanged,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primary.withOpacity(0.3),
                                      hintText: "********",
                                      hintStyle: const TextStyle(color: Colors.white70),
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
                                        const BorderSide(color: Colors.white, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                        const BorderSide(color: Colors.white60, width: 1),
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
                                          activeColor: AppColors.primary,
                                        ),
                                        const Text(
                                          AppStrings.rememberMe,
                                          style: TextStyle(color: AppColors.grey300),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      AppStrings.forgotPassword,
                                      style: TextStyle(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                    color: AppColors.onPrimary,
                                  )
                                      : const Text(
                                    AppStrings.login,
                                    style: TextStyle(
                                      color: AppColors.onPrimary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: AppDimensions.spaceM),

                                /// Sign Up Text
                                /// Sign Up Text
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      AppStrings.dontHaveAccount,
                                      style: TextStyle(color: AppColors.primary),
                                    ),
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () => viewModel.goToSignUp(context),
                                      child: const Text(
                                        AppStrings.signUp,
                                        style: TextStyle(
                                          color: AppColors.accent,
                                          fontWeight: FontWeight.bold,
                                        ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
