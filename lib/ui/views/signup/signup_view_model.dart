import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class SignupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  /// 🔹 Controllers
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();

  /// 🔹 Validation error
  String? phoneNumberError;

  /// 🔹 Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Focus node getter
  FocusNode get phoneFocus => _phoneFocus;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Focus management methods
  void focusPhone() {
    _phoneFocus.requestFocus();
  }

  void unfocusPhone() {
    _phoneFocus.unfocus();
  }

  @override
  void init() {
    super.init();
    // Auto-focus phone field when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusPhone();
    });
  }

  /// 🔹 Validate phone number
  bool validatePhone() {
    final phone = phoneNumberController.text.trim();

    if (phone.isEmpty) {
      phoneNumberError = "*Phone number is required";
    } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(phone)) {
      phoneNumberError = "Enter a valid phone number";
    } else {
      phoneNumberError = null;
    }

    notifyListeners();
    return phoneNumberError == null;
  }

  /// 🔹 Continue to OTP screen
  Future<void> goToOtp() async {
    if (!validatePhone()) return; // Stop if invalid

    // Dismiss keyboard when continue is clicked
    unfocusPhone();

    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);

    _navigationService.navigateTo(AppRoutes.otp);
  }

  @override
  void onDispose() {
    phoneNumberController.dispose();
    _phoneFocus.dispose();
    super.onDispose();
  }
}
