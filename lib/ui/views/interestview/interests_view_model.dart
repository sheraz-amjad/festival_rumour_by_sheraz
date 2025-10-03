import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';

class InterestsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  
  final List<String> categories = [
    'Culture',
    'Food',
    'Music',
    'Meet People',
    'Socials on weekends',
    'Comedy',
    'Dance',
    'Art',
  ];

  final Set<String> _selected = {};
  Set<String> get selected => Set.unmodifiable(_selected);

  bool isSelected(String category) => _selected.contains(category);

  void toggle(String category) {
    if (_selected.contains(category)) {
      _selected.remove(category);
    } else {
      _selected.add(category);
    }
    notifyListeners();
  }

  bool get hasSelection => _selected.isNotEmpty;

  Future<void> saveInterests() async {
    await handleAsync(() async {
      // Simulate API call to save interests
      await Future.delayed(const Duration(seconds: 1));
      
      // Navigate to next screen
      _navigationService.navigateTo(AppRoutes.event);
    }, errorMessage: 'Failed to save interests. Please try again.');
  }

  Future<void> skipInterests() async {
    await handleAsync(() async {
      // Navigate to next screen without saving
      _navigationService.navigateTo(AppRoutes.event);
    }, errorMessage: 'Failed to continue. Please try again.');
  }
}
