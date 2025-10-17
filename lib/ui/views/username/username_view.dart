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


class UsernameView extends StatefulWidget {
  const UsernameView({super.key});

  @override
  State<UsernameView> createState() => _UsernameViewState();
}

class _UsernameViewState extends State<UsernameView> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus on email field when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
                                    focusNode: _emailFocusNode,
                                    cursorColor: AppColors.white,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onChanged: viewModel.onUsernameChanged,
                                    onSubmitted: (_) {
                                      // Move focus to password field when user presses next
                                      _passwordFocusNode.requestFocus();
                                    },
                                    style: const TextStyle(color: AppColors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: viewModel.isEmailValid 
                                        ? AppColors.success.withOpacity(0.1)
                                        : AppColors.primary.withOpacity(0.3),
                                      hintText: AppStrings.enterYourEmail,
                                      hintStyle: const TextStyle(color: AppColors.white70),
                                      errorText: viewModel.emailError,
                                      errorStyle: const TextStyle(
                                        color: AppColors.error,
                                        fontSize: AppDimensions.textS,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: viewModel.isEmailValid 
                                          ? AppColors.success 
                                          : AppColors.white70,
                                        size: AppDimensions.iconS,
                                      ),
                                      suffixIcon: viewModel.isEmailValid
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: AppColors.success,
                                            size: AppDimensions.iconS,
                                          )
                                        : null,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                        borderSide: BorderSide(
                                          color: viewModel.isEmailValid 
                                            ? AppColors.success 
                                            : AppColors.white, 
                                          width: AppDimensions.borderWidthS,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                        borderSide: BorderSide(
                                          color: viewModel.isEmailValid 
                                            ? AppColors.success 
                                            : AppColors.white60, 
                                          width: AppDimensions.dividerThickness,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                        borderSide: const BorderSide(
                                          color: AppColors.error, 
                                          width: AppDimensions.borderWidthS,
                                        ),
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
                                    focusNode: _passwordFocusNode,
                                    obscureText: !viewModel.isPasswordVisible,
                                    cursorColor: AppColors.white,
                                    textInputAction: TextInputAction.done,
                                    onChanged: viewModel.onPasswordChanged,
                                    onSubmitted: (_) {
                                      // Attempt login when user presses done on password field
                                      if (viewModel.isFormValid && !viewModel.isLoading) {
                                        viewModel.validateAndLogin(context);
                                      }
                                    },
                                    style: const TextStyle(color: AppColors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: viewModel.isPasswordValid 
                                        ? AppColors.success.withOpacity(0.1)
                                        : AppColors.primary.withOpacity(0.3),
                                      hintText: AppStrings.passwordPlaceholder,
                                      hintStyle: const TextStyle(color: AppColors.white70),
                                      errorText: viewModel.passwordError,
                                      errorStyle: const TextStyle(
                                        color: AppColors.error,
                                        fontSize: AppDimensions.textS,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: viewModel.isPasswordValid 
                                          ? AppColors.success 
                                          : AppColors.white70,
                                        size: AppDimensions.iconS,
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (viewModel.passwordStrength.isNotEmpty)
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: AppDimensions.paddingXS,
                                                vertical: AppDimensions.paddingXS,
                                              ),
                                              margin: const EdgeInsets.only(right: AppDimensions.spaceXS),
                                              decoration: BoxDecoration(
                                                color: viewModel.passwordStrengthColor.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
                                              ),
                                              child: Text(
                                                viewModel.passwordStrength,
                                                style: TextStyle(
                                                  color: viewModel.passwordStrengthColor,
                                                  fontSize: AppDimensions.textXS,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          IconButton(
                                            icon: Icon(
                                              viewModel.isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: AppColors.white70,
                                              size: AppDimensions.iconS,
                                            ),
                                            onPressed: viewModel.togglePasswordVisibility,
                                          ),
                                        ],
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                        borderSide: BorderSide(
                                          color: viewModel.isPasswordValid 
                                            ? AppColors.success 
                                            : AppColors.white, 
                                          width: AppDimensions.borderWidthS,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                        borderSide: BorderSide(
                                          color: viewModel.isPasswordValid 
                                            ? AppColors.success 
                                            : AppColors.white60, 
                                          width: AppDimensions.dividerThickness,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                        borderSide: const BorderSide(
                                          color: AppColors.error, 
                                          width: AppDimensions.borderWidthS,
                                        ),
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
                                    backgroundColor: viewModel.isFormValid 
                                      ? AppColors.accent 
                                      : AppColors.grey600,
                                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                    ),
                                    elevation: viewModel.isFormValid ? 4 : 0,
                                  ),
                                  onPressed: viewModel.isLoading
                                      ? null
                                      : () => viewModel.validateAndLogin(context),
                                  child: viewModel.isLoading
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: AppDimensions.iconS,
                                              height: AppDimensions.iconS,
                                              child: CircularProgressIndicator(
                                                color: AppColors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                            const SizedBox(width: AppDimensions.spaceS),
                                            const ResponsiveTextWidget(
                                              AppStrings.loggingIn,
                                              textType: TextType.body,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              viewModel.isFormValid 
                                                ? Icons.login 
                                                : Icons.lock,
                                              color: AppColors.white,
                                              size: AppDimensions.iconS,
                                            ),
                                            const SizedBox(width: AppDimensions.spaceS),
                                            ResponsiveTextWidget(
                                              viewModel.isFormValid 
                                                ? AppStrings.login 
                                                : AppStrings.completeFormToLogin,
                                              textType: TextType.body,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
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
                                    const SizedBox(width: AppDimensions.spaceXS),
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
