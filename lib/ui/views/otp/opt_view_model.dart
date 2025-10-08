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

  String get otpCode => _otpCode;
  String? get errorText => _errorText;
  bool get isLoading => _isLoading;

  bool get isOtpValid => _otpCode.length == 4;

  /// 🔹 Called when OTP input changes
  void onCodeChanged(String value) {
    _otpCode = value;
    if (value.length == 4) {
      _errorText = null;
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

      // Example check
      if (_otpCode != "1234") {
        _errorText = AppStrings.otpMismatch;
        _isLoading = false;
        notifyListeners();
        return;
      }

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
}
