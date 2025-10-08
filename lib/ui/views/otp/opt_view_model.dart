import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class OtpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String _otpCode = "";
  String? _errorText;
  bool _isLoading = false;
  final FocusNode _otpFocus = FocusNode();
  bool _isFocusChanging = false;

  String get otpCode => _otpCode;
  String? get errorText => _errorText;
  bool get isLoading => _isLoading;
  FocusNode get otpFocus => _otpFocus;

  bool get isOtpValid => _otpCode.length == 4;

  /// Auto-focus OTP field when screen loads
  void focusOtpField() {
    if (!_isFocusChanging && !_otpFocus.hasFocus) {
      _isFocusChanging = true;
      _otpFocus.requestFocus();
      Future.delayed(const Duration(milliseconds: 100), () {
        _isFocusChanging = false;
      });
    }
  }

  /// Unfocus OTP field
  void unfocusOtpField() {
    if (!_isFocusChanging && _otpFocus.hasFocus) {
      _isFocusChanging = true;
      _otpFocus.unfocus();
      Future.delayed(const Duration(milliseconds: 100), () {
        _isFocusChanging = false;
      });
    }
  }

  @override
  void init() {
    super.init();
    // Auto-focus OTP field when screen loads (only once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_otpFocus.hasFocus) {
        focusOtpField();
      }
    });
  }

  /// 🔹 Called when OTP input changes
  void onCodeChanged(String value) {
    _otpCode = value;
    if (value.length == 4) {
      _errorText = null;
      // Don't change focus here - let onCompleted handle it
    } else {
      _errorText = null; // clear any old error when typing
    }
    notifyListeners();
  }

  /// 🔹 Verify entered OTP
  Future<void> verifyCode() async {
    if (!isOtpValid) {
      _errorText = AppStrings.invalidOtpError;
      notifyListeners();
      return;
    }

    await handleAsync(() async {
      _isLoading = true;
      notifyListeners();

      // Simulate verification delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual OTP verification API call
      // For now, accept any 4-digit OTP
      _errorText = null;
      _isLoading = false;
      notifyListeners();

      // ✅ Navigate to next screen
      _navigationService.navigateTo(AppRoutes.firstname);
    }, errorMessage: AppStrings.otpVerificationError);
  }

  /// 🔹 Resend OTP Code
  Future<void> resendCode() async {
    await handleAsync(() async {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      notifyListeners();
    }, errorMessage: AppStrings.resendCodeError);
  }

  @override
  void onDispose() {
    _otpFocus.dispose();
    super.onDispose();
  }
}
