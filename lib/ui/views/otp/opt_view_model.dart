import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class OtpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String code = "";
  String? _otpError;
  bool _isLoading = false;

  String? get otpError => _otpError;
  bool get isOtpValid => code.length == 4 && _otpError == null;
  bool get isLoading => _isLoading;

  void onCodeChanged(String value) {
    code = value;
    _otpError = null; // Clear error while typing
    notifyListeners();
  }

  bool validateCode() {
    if (code.isEmpty) {
      _otpError = "OTP cannot be empty";
    } else if (code.length != 4) {
      _otpError = "OTP must be 4 digits";
    } else {
      _otpError = null;
    }
    notifyListeners();
    return _otpError == null;
  }

  Future<void> verifyCode() async {
    if (!validateCode()) return; // Stop if invalid

    _isLoading = true;
    notifyListeners();

    await handleAsync(() async {
      await Future.delayed(const Duration(seconds: 2)); // Simulate verification
      _navigationService.navigateTo(AppRoutes.firstname);
    }, errorMessage: AppStrings.otpVerificationError);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> resendCode() async {
    await handleAsync(() async {
      await Future.delayed(const Duration(seconds: 1)); // Simulate resend
    }, errorMessage: AppStrings.otpResendError);
  }
}
