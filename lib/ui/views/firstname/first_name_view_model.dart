import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';

class FirstNameViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  
  String _firstName = "";
  String get firstName => _firstName;

  bool get isNameEntered => _firstName.trim().isNotEmpty;

  bool _showWelcome = false;
  bool get showWelcome => _showWelcome;

  void onNameChanged(String value) {
    _firstName = value;
    notifyListeners();
  }

  Future<void> onNextPressed() async {
    if (isNameEntered) {
      await handleAsync(() async {
        // Simulate API call to save first name
        await Future.delayed(const Duration(seconds: 1));
        
        _showWelcome = true;
        notifyListeners();
        
        // Navigate to next screen after showing welcome
        await Future.delayed(const Duration(seconds: 2));
      //  _navigationService.navigateTo(AppRoutes.uploadphotos);
      }, errorMessage: 'Failed to save name. Please try again.');
    }
  }

  void onEditName() {
    _showWelcome = false;
    notifyListeners();
  }

  Future<void> continueToNext() async {
    await handleAsync(() async {
      // Navigate to next screen
      _navigationService.navigateTo(AppRoutes.uploadphotos);
    }, errorMessage: 'Failed to continue. Please try again.');
  }

  void goBack() {
    _navigationService.pop();
  }
}
