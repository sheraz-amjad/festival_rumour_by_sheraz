import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/di/locator.dart';
import '../../../core/viewmodels/base_view_model.dart';

class SignupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController phoneController = TextEditingController();
  String? phoneError;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool validatePhone() {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      phoneError = "*Phone number is required";
      notifyListeners();
      return false;
    } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(phone)) {
      phoneError = "*Enter a valid phone number (10–15 digits)";
      notifyListeners();
      return false;
    }

    phoneError = null;
    notifyListeners();
    return true;
  }

  Future<void> goToOtp() async {
    if (!validatePhone()) return;

    setLoading(true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate API
    setLoading(false);

    _navigationService.navigateTo(AppRoutes.otp);
  }
}
