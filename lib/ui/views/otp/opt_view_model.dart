import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';

class OtpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  
  String code = "";
  bool isCodeEntered = false;

  /// Called when the OTP input changes.
  /// Updates the stored code and the `isCodeEntered` flag.
  void onCodeChanged(String value) {
    code = value;
    isCodeEntered = value.length == 4;
    notifyListeners();
  }

  /// Explicit setter for the view to toggle the "code entered" state.
  void setCodeEntered(bool value) {
    if (isCodeEntered == value) return;
    isCodeEntered = value;
    notifyListeners();
  }

  /// Verify the code with proper error handling
  Future<void> verifyCode() async {
    await handleAsync(() async {
      // TODO: Replace with actual verification call
      await Future.delayed(const Duration(seconds: 2));
      
      // On success, navigate to next screen
      _navigationService.navigateTo(AppRoutes.firstname);
    }, errorMessage: 'Failed to verify OTP. Please try again.');
  }

  /// Resend OTP code
  Future<void> resendCode() async {
    await handleAsync(() async {
      // TODO: Implement resend OTP logic
      await Future.delayed(const Duration(seconds: 1));
    }, errorMessage: 'Failed to resend OTP. Please try again.');
  }
}
