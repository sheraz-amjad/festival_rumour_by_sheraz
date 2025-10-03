import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';

class SignupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> loginWithGoogle() async {
    await handleAsync(() async {
      // TODO: Implement Google login
      await Future.delayed(const Duration(seconds: 2));
    }, errorMessage: 'Failed to sign in with Google');
  }

  Future<void> loginWithEmail() async {
    await handleAsync(() async {
      // TODO: Implement Email login
      await Future.delayed(const Duration(seconds: 2));
    }, errorMessage: 'Failed to sign in with email');
  }

  Future<void> loginWithApple() async {
    await handleAsync(() async {
      // TODO: Implement Apple login
      await Future.delayed(const Duration(seconds: 2));
    }, errorMessage: 'Failed to sign in with Apple');
  }

  void goToOtp() {
    _navigationService.navigateTo(AppRoutes.otp);
  }
}


