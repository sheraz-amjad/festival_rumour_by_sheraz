import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class FirstNameViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String _firstName = "";
  String get firstName => _firstName;

  String? _nameError;
  String? get nameError => _nameError;

  bool get isNameEntered => _firstName.trim().isNotEmpty;

  bool _showWelcome = false;
  bool get showWelcome => _showWelcome;

  /// ✅ Validate name on change
  void onNameChanged(String value) {
    _firstName = value;
    if (_firstName.trim().isEmpty) {
      _nameError = AppStrings.nameEmptyError;
    } else if (_firstName.trim().length < 4) {
      _nameError = AppStrings.nameTooShortError;
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(_firstName)) {
      _nameError = AppStrings.nameInvalidError;
    } else {
      _nameError = null;
    }
    notifyListeners();
  }

  Future<void> onNextPressed() async {
    if (_nameError != null || _firstName.trim().isEmpty) return;

    await handleAsync(() async {
      await Future.delayed(const Duration(seconds: 1));
      _showWelcome = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));
    }, errorMessage: AppStrings.saveNameError);
  }

  void onEditName() {
    _showWelcome = false;
    notifyListeners();
  }

  Future<void> continueToNext() async {
    await handleAsync(() async {
      _navigationService.navigateTo(AppRoutes.uploadphotos);
    }, errorMessage: AppStrings.continueError);
  }

  void goBack() {
    _navigationService.pop();
  }
}
