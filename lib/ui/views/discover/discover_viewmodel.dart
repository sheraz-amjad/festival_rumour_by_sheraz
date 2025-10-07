import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/constants/app_strings.dart';
import 'app_festivals.dart';

class DiscoverViewModel extends BaseViewModel {
  String selected = AppStrings.live;

  List<Map<String, String>> festivals = AppFestivals.festivals;

  void select(String category) {
    selected = category;
    notifyListeners();
  }

  void onBottomNavTap(int index) {
    // Navigate between tabs
  }
}
