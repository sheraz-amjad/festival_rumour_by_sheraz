import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class FirstNameViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final FocusNode nameFocusNode = FocusNode();
  final TextEditingController nameController = TextEditingController();

  String _firstName = "";
  String? _nameError;
  bool _showWelcome = false;

  String get firstName => _firstName;
  String? get nameError => _nameError;
  bool get showWelcome => _showWelcome;
  bool get isNameEntered => _firstName.trim().isNotEmpty;

  void onNameChanged(String value) {
    _firstName = value;
    _nameError = null; // clear error when typing
    notifyListeners();
  }

  /// ✅ Validation logic
  bool validateName() {
    final name = _firstName.trim();
    if (name.isEmpty) {
      _nameError = "*First name is required.";
    } else if (name.length < 3) {
      _nameError = "*Name must be at least 4 characters.";
    } else {
      _nameError = null;
    }
    notifyListeners();
    return _nameError == null;
  }

  /// ✅ Called when user presses "Next"
  Future<void> onNextPressed() async {
    if (!validateName()) return; // 🚫 Stop if invalid

    await handleAsync(() async {
      await Future.delayed(const Duration(seconds: 1)); // simulate API
      _showWelcome = true;
      notifyListeners();
    }, errorMessage: AppStrings.saveNameError);
  }

  /// 🧭 Continue button in welcome dialog
  Future<void> continueToNext() async {
    await handleAsync(() async {
      _navigationService.navigateTo(AppRoutes.uploadphotos);
    }, errorMessage: AppStrings.continueError);
  }

  /// ✏️ Edit Name handler
  void onEditName(BuildContext context) {
    _showWelcome = false;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(nameFocusNode);
    });
  }

  void goBack() => _navigationService.pop();

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }
}
