import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_durations.dart';

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
    if (isDisposed || _isFocusChanging || _otpFocus.hasFocus) return;
    
    try {
      _isFocusChanging = true;
      _otpFocus.requestFocus();
      Future.delayed(AppDurations.shortDelay, () {
        if (!isDisposed) {
          _isFocusChanging = false;
        }
      });
    } catch (e) {
      if (kDebugMode) print('Error focusing OTP field: $e');
      _isFocusChanging = false;
    }
  }

  /// Unfocus OTP field
  void unfocusOtpField() {
    if (isDisposed || _isFocusChanging || !_otpFocus.hasFocus) return;
    
    try {
      _isFocusChanging = true;
      _otpFocus.unfocus();
      Future.delayed(AppDurations.shortDelay, () {
        if (!isDisposed) {
          _isFocusChanging = false;
        }
      });
    } catch (e) {
      if (kDebugMode) print('Error unfocusing OTP field: $e');
      _isFocusChanging = false;
    }
  }

  @override
  void init() {
    super.init();
    // Auto-focus OTP field when screen loads (only once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isDisposed && !_otpFocus.hasFocus) {
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
      // Simulate verification delay
      await Future.delayed(AppDurations.otpVerificationDuration);

      // TODO: Replace with actual OTP verification API call
      // For now, accept any 4-digit OTP
      _errorText = null;

      // ✅ Navigate to next screen
      _navigationService.navigateTo(AppRoutes.name);
    }, 
    errorMessage: AppStrings.otpVerificationError,
    minimumLoadingDuration: AppDurations.otpVerificationDuration);
  }

  /// 🔹 Resend OTP Code
  Future<void> resendCode() async {
    await handleAsync(() async {
      await Future.delayed(AppDurations.buttonLoadingDuration);
    }, 
    errorMessage: AppStrings.resendCodeError,
    minimumLoadingDuration: AppDurations.buttonLoadingDuration);
  }

  @override
  void onDispose() {
    _otpFocus.dispose();
    super.onDispose();
  }
}
