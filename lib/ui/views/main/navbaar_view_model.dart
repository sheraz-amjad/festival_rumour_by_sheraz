import '../../../core/viewmodels/base_view_model.dart';

class NavBaarViewModel extends BaseViewModel {
  int _currentIndex = 0;

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
}
