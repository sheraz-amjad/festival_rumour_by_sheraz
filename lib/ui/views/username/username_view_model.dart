import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/viewmodels/base_view_model.dart';

class UsernameViewModel extends BaseViewModel {
  /// Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// State variables
  bool rememberMe = false;
  bool isPasswordVisible = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isFormValid = false;

  /// Error messages
  String? emailError;
  String? passwordError;

  /// Password strength
  String passwordStrength = '';
  Color passwordStrengthColor = AppColors.grey600;

  /// ---------------------------
  /// 🔹 Input Handlers
  /// ---------------------------
  void onUsernameChanged(String value) {
    _validateEmail(value);
    _updateFormValidity();
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _validatePassword(value);
    _updateFormValidity();
    notifyListeners();
  }

  /// Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  /// Focus handlers
  void onUsernameFocusChange(bool hasFocus) {
    if (!hasFocus && emailController.text.isNotEmpty) {
      _validateEmail(emailController.text);
      _updateFormValidity();
      notifyListeners();
    }
  }

  void onPasswordFocusChange(bool hasFocus) {
    if (!hasFocus && passwordController.text.isNotEmpty) {
      _validatePassword(passwordController.text);
      _updateFormValidity();
      notifyListeners();
    }
  }

  /// Focus management methods
  void focusEmailField() {
    // This will be called from the view to focus email field
  }

  void focusPasswordField() {
    // This will be called from the view to focus password field
  }

  /// ---------------------------
  /// 🔹 Validation Methods
  /// ---------------------------
  void _validateEmail(String email) {
    if (email.isEmpty) {
      emailError = AppStrings.emailRequired;
      isEmailValid = false;
    } else if (!_isValidEmail(email)) {
      emailError = AppStrings.emailInvalid;
      isEmailValid = false;
    } else {
      emailError = null;
      isEmailValid = true;
    }
  }

  void _validatePassword(String password) {
    if (password.isEmpty) {
      passwordError = AppStrings.passwordRequired;
      passwordStrength = '';
      passwordStrengthColor = AppColors.grey600;
      isPasswordValid = false;
    } else if (password.length < 6) {
      passwordError = AppStrings.passwordMinLength;
      passwordStrength = AppStrings.passwordWeak;
      passwordStrengthColor = AppColors.error;
      isPasswordValid = false;
    } else if (password.length > 50) {
      passwordError = AppStrings.passwordMaxLength;
      passwordStrength = AppStrings.passwordWeak;
      passwordStrengthColor = AppColors.error;
      isPasswordValid = false;
    } else {
      passwordError = null;
      _calculatePasswordStrength(password);
      isPasswordValid = true;
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void _calculatePasswordStrength(String password) {
    int score = 0;
    
    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Character variety checks
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;
    
    if (score <= 2) {
      passwordStrength = AppStrings.passwordWeak;
      passwordStrengthColor = AppColors.error;
    } else if (score <= 4) {
      passwordStrength = AppStrings.passwordMedium;
      passwordStrengthColor = AppColors.warning;
    } else {
      passwordStrength = AppStrings.passwordStrong;
      passwordStrengthColor = AppColors.success;
    }
  }

  void _updateFormValidity() {
    isFormValid = isEmailValid && isPasswordValid;
  }

  /// ---------------------------
  /// 🔹 Validation + Login Logic
  /// ---------------------------
  Future<void> validateAndLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate all fields
    _validateEmail(email);
    _validatePassword(password);
    _updateFormValidity();

    // If any error found
    if (!isFormValid) {
      notifyListeners();
      _showErrorSnackBar(context, AppStrings.fixErrors);
      return;
    }

    await handleAsync(() async {
      // Simulate API delay
      await Future.delayed(AppDurations.loginLoadingDuration);

      // Simulate login validation
      if (await _performLogin(email, password)) {
        _showSuccessSnackBar(context, AppStrings.loginSuccess);
        // Navigate to Home Screen
        Navigator.pushReplacementNamed(context, AppRoutes.festivals);
      } else {
        _showErrorSnackBar(context, AppStrings.loginFailed);
      }
    }, 
    errorMessage: 'Login failed. Please try again.',
    minimumLoadingDuration: AppDurations.loginLoadingDuration);
  }

  Future<bool> _performLogin(String email, String password) async {
    // Simulate API call
    await Future.delayed(AppDurations.apiCallDuration);
    
    // Dummy validation - in real app, this would be an API call
    return email.isNotEmpty && password.isNotEmpty;
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.success),
            const SizedBox(width: AppDimensions.spaceS),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.success.withOpacity(0.1),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: AppColors.error),
            const SizedBox(width: AppDimensions.spaceS),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.error.withOpacity(0.1),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// ---------------------------
  /// 🔹 Navigate to Sign Up
  /// ---------------------------
  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupEmail);
  }

  /// ---------------------------
  /// 🔹 Cleanup
  /// ---------------------------
  @override
  void onDispose() {
    emailController.dispose();
    passwordController.dispose();
    super.onDispose();
  }
}
