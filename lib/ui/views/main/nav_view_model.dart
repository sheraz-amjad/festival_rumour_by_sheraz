import '../../../core/viewmodels/base_view_model.dart';

class NavViewModel extends BaseViewModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void goToHome() => setIndex(0);
  void goToDiscover() => setIndex(1);
  void goToProfile() => setIndex(2);
}


