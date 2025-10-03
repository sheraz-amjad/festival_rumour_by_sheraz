import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/constants/app_assets.dart';

/// ViewModel for ProfileListView that manages profile lists (followers, following, festivals)
class ProfileListViewModel extends BaseViewModel {
  int _currentTab = 0;
  bool _showingList = false;

  // Mock data - replace with actual data from repositories
  final List<Map<String, String>> _followers = [
    {'name': 'John Doe', 'username': '@johndoe', 'avatar': AppAssets.profile},
    {'name': 'Jane Smith', 'username': '@janesmith', 'avatar': AppAssets.profile},
  ];

  final List<Map<String, String>> _following = [
    {'name': 'Mike Johnson', 'username': '@mikej', 'avatar': AppAssets.profile},
    {'name': 'Sarah Wilson', 'username': '@sarahw', 'avatar': AppAssets.profile},
  ];

  final List<Map<String, String>> _festivals = [
    {'title': 'Coachella 2024', 'location': 'California'},
    {'title': 'Glastonbury', 'location': 'UK'},
    {'title': 'Burning Man', 'location': 'Nevada'},
  ];

  /// Current selected tab index
  int get currentTab => _currentTab;

  /// Whether the list is currently showing
  bool get showingList => _showingList;

  /// Get followers list
  List<Map<String, String>> get followers => _followers;

  /// Get following list
  List<Map<String, String>> get following => _following;

  /// Get festivals list
  List<Map<String, String>> get festivals => _festivals;

  /// Get current list based on selected tab
  List<Map<String, String>> getCurrentList() {
    switch (_currentTab) {
      case 0:
        return _followers;
      case 1:
        return _following;
      case 2:
        return _festivals;
      default:
        return _followers;
    }
  }

  /// Set the current tab and notify listeners
  void setTab(int tab) {
    if (_currentTab != tab) {
      _currentTab = tab;
      notifyListeners();
    }
  }

  /// Show the profile list
  void showProfileList() {
    _showingList = true;
    notifyListeners();
  }

  /// Close the profile list
  void closeProfileList() {
    _showingList = false;
    notifyListeners();
  }

  /// Unfollow a user
  void unfollowUser(Map<String, String> user) {
    _following.removeWhere((item) => item['username'] == user['username']);
    notifyListeners();
  }

  @override
  void init() {
    super.init();
    _showingList = true;
  }
}
