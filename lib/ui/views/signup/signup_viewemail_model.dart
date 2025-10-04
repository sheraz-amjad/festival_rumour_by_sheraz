import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/di/locator.dart';
import '../../../core/viewmodels/base_view_model.dart';

class SignupViewEmailModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// ✅ Validate fields
  bool validateFields() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    bool isValid = true;

    // Email validation
    if (email.isEmpty) {
      emailError = "*Email is required";
      isValid = false;
    } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(email)) {
      emailError = "Enter a valid email";
      isValid = false;
    } else {
      emailError = null;
    }

    // Password validation
    if (password.isEmpty) {
      passwordError = "*Password is required";
      isValid = false;
    } else if (password.length < 8) {
      passwordError = "*Password must be at least 8 characters";
      isValid = false;
    } else {
      passwordError = null;
    }

    // Confirm password validation
    if (confirmPassword.isEmpty) {
      confirmPasswordError = "*Please confirm your password";
      isValid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError = "*Passwords do not match";
      isValid = false;
    } else {
      confirmPasswordError = null;
    }

    notifyListeners();
    return isValid;
  }

  /// ✅ Navigate if valid
  Future<void> goToOtp() async {
    if (!validateFields()) return;

    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);

    _navigationService.navigateTo(AppRoutes.signup);
  }
}
