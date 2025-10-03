

import '../../../core/viewmodels/base_view_model.dart';

class DiscoverViewModel extends BaseViewModel {
  String selected = "Live";

  List<Map<String, String>> festivals = [
    {"title": "Luna Fest 2025", "date": "SEP 19 - SEP 21", "image": "assets/images/Rectangle_2593.png"},
    {"title": "Sunburn 2025", "date": "DEC 10 - DEC 12", "image": "assets/images/Rectangle_2593.png"},
  ];

  void select(String category) {
    selected = category;
    notifyListeners();
  }

  void onBottomNavTap(int index) {
    // Navigate between tabs
  }
}
