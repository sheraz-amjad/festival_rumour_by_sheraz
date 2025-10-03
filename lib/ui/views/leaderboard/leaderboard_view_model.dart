
import '../../../core/services/dummy_services.dart';
import '../../../core/viewmodels/base_view_model.dart';

class LeaderboardViewModel extends BaseViewModel {
  final DummyService _service = DummyService();
  List<Map<String, dynamic>> items = [];

  LeaderboardViewModel() {
    load();
  }

  void load() {
    items = _service.getLeaderboard();
    notifyListeners();
  }
}
