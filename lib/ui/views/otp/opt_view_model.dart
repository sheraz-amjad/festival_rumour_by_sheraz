import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class OtpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String code = "";
  bool isCodeEntered = false;

  void onCodeChanged(String value) {
    code = value;
    isCodeEntered = value.length == 4;
    notifyListeners();
  }

  void setCodeEntered(bool value) {
    if (isCodeEntered == value) return;
    isCodeEntered = value;
    notifyListeners();
  }

  Future<void> verifyCode() async {
    await handleAsync(() async {
      // TODO: Replace with actual verification call
      await Future.delayed(const Duration(seconds: 2));

      // On success, navigate to next screen
      _navigationService.navigateTo(AppRoutes.firstname);
    }, errorMessage: AppStrings.otpVerificationError);
  }

  Future<void> resendCode() async {
    await handleAsync(() async {
      // TODO: Implement resend OTP logic
      await Future.delayed(const Duration(seconds: 1));
    }, errorMessage: AppStrings.otpResendError);
  }
}
