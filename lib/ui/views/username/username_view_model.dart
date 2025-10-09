import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';

class UsernameViewModel extends ChangeNotifier {
  /// Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// State variables
  bool rememberMe = false;
  bool isLoading = false;
  bool isPasswordVisible = false;

  /// Error messages
  String? emailError;
  String? passwordError;

  /// ---------------------------
  /// 🔹 Input Handlers
  /// ---------------------------
  void onUsernameChanged(String value) {
    if (value.isNotEmpty) emailError = null;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    if (value.isNotEmpty) passwordError = null;
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

  /// Focus handlers (optional)
  void onUsernameFocusChange(bool hasFocus) {}
  void onPasswordFocusChange(bool hasFocus) {}

  /// ---------------------------
  /// 🔹 Validation + Login Logic
  /// ---------------------------
  Future<void> validateAndLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Reset errors
    emailError = null;
    passwordError = null;

    // Validate input
    if (email.isEmpty) {
      emailError = "*Email is required";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      emailError = "*Enter a valid email address";
    }

    if (password.isEmpty) {
      passwordError = "*Password is required";
    } else if (password.length < 6) {
      passwordError = "*Password must be at least 6 characters";
    }

    // If any error found
    if (emailError != null || passwordError != null) {
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Please fix the highlighted errors")),
      );
      return;
    }

    // Start loading
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    // Dummy login credentials
    if (email.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Login Successful")),
      );

      // Navigate to Home Screen
      Navigator.pushReplacementNamed(context, AppRoutes.festivals);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Invalid email or password")),
      );
    }

    // Stop loading
    isLoading = false;
    notifyListeners();
  }

  /// ---------------------------
  /// 🔹 Navigate to Sign Up
  /// ---------------------------
  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupEmail);
  }
}
