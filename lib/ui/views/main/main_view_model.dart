import '../../../core/viewmodels/base_view_model.dart';

/// ViewModel for MainView that manages navigation between tabs
class MainViewModel extends BaseViewModel {
  int _currentIndex = 0;

  /// Current selected tab index
  int get currentIndex => _currentIndex;

  /// Set the current tab index and notify listeners
  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  @override
  void init() {
    super.init();
    // Initialize with home tab selected
    _currentIndex = 0;
  }
}
