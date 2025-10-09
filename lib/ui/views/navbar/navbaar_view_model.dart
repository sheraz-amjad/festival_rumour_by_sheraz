import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/viewmodels/base_view_model.dart';

class NavBaarViewModel extends BaseViewModel {
  int _currentIndex = 0;
  final NavigationService _navigationService = locator<NavigationService>();


  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void goToHome() {
    setIndex(0);
  }

  @override
  void init() {
    super.init();
    _currentIndex = 0; // Initialize with first tab selected
  }

  NavigationService get navigationService => _navigationService;

}
