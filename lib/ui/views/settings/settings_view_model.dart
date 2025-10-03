
import '../../../core/viewmodels/base_view_model.dart';

class SettingsViewModel extends BaseViewModel {
  bool notifications = true;
  bool primarySettings = false;

  void toggleNotifications(bool v) {
    notifications = v;
    notifyListeners();
  }

  void togglePrimary(bool v) {
    primarySettings = v;
    notifyListeners();
  }

  void logout() {
    // implement logout
  }
}
