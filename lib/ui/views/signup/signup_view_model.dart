import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class SignupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  /// 🔹 Continue to OTP screen
  void goToOtp() {
    _navigationService.navigateTo(AppRoutes.otp);
  }

  /// 🔹 Sign in with Google
  Future<void> loginWithGoogle() async {
    await handleAsync(
          () async {
        // TODO: Implement Google login logic here
        await Future.delayed(const Duration(seconds: 2));
      },
      errorMessage: AppStrings.failedtosignwithgoogle,
    );
  }

  /// 🔹 Sign in with Email
  Future<void> loginWithEmail() async {
    await handleAsync(
          () async {
        // TODO: Implement Email login logic here
        await Future.delayed(const Duration(seconds: 2));
      },
      errorMessage: AppStrings.faildtosignwithmail,
    );
  }

  /// 🔹 Sign in with Apple
  Future<void> loginWithApple() async {
    await handleAsync(
          () async {
        // TODO: Implement Apple login logic here
        await Future.delayed(const Duration(seconds: 2));
      },
      errorMessage: AppStrings.appleLoginError,
    );
  }
}
