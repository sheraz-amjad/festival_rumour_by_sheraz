import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di/locator.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/viewmodels/base_view_model.dart';

/// ViewModel for Welcome screen handling authentication flows
class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = AuthService();

  /// Sign in with Google account
  /// Uses Firebase Authentication with Google Sign-In
  Future<void> loginWithGoogle() async {
    await handleAsync(
      () async {
        final userCredential = await _authService.signInWithGoogle();
        
        if (userCredential == null) {
          // User cancelled the sign-in - don't show error
          return;
        }

        // User signed in successfully
        final user = userCredential.user;
        if (user != null) {
          // Navigate to festivals screen after successful login
          _navigationService.navigateTo(AppRoutes.festivals);
        }
      },
      // Don't provide generic errorMessage - let the actual exception message be shown
      // The AuthService already provides user-friendly error messages
      showLoading: true,
      onError: (error) {
        // Log the actual error for debugging
        // The error message will be shown via BaseView's error handling
      },
    );
  }

  /// Sign in with Apple account
  /// Uses Firebase Authentication with Apple Sign-In
  /// Only available on iOS devices
  Future<void> loginWithApple() async {
    await handleAsync(
      () async {
        final userCredential = await _authService.signInWithApple();
        
        if (userCredential == null) {
          // User cancelled or sign-in failed - error already handled by AuthService
          return;
        }

        // User signed in successfully
        final user = userCredential.user;
        if (user != null) {
          // Navigate to festivals screen after successful login
          _navigationService.navigateTo(AppRoutes.festivals);
        }
      },
      // Don't provide generic errorMessage - let the actual exception message be shown
      // The AuthService already provides user-friendly error messages
      showLoading: true,
      onError: (error) {
        // Log the actual error for debugging
        // The error message will be shown via BaseView's error handling
      },
    );
  }

  /// Navigate to email/phone login screen
  Future<void> loginWithEmail() async {
    _navigationService.navigateTo(AppRoutes.username);
  }

  /// Navigate to signup screen
  void goToSignup() {
    _navigationService.navigateTo(AppRoutes.signupEmail);
  }
}
