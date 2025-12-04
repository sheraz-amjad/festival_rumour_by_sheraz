import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/di/locator.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/viewmodels/base_view_model.dart';

class WelcomeViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<String> _googleEmails = [];
  List<String> get googleEmails => _googleEmails;

  Future<void> loginWithGoogle() async {
    setLoading(true);

    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // User signed in successfully
        _googleEmails = [account.email]; // store email
        notifyListeners();

        // Optional: you could also fetch more accounts if supported
        print("Signed in as: ${account.email}");
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }

    setLoading(false);
  }

  Future<void> loginWithEmail() async {
    _navigationService.navigateTo(AppRoutes.username);
  }

  Future<void> loginWithApple() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
  }

  void goToSignup() {
    _navigationService.navigateTo(AppRoutes.signupEmail);
  }
}
