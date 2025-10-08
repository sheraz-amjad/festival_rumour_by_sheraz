import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/constants/app_assets.dart';

/// ViewModel for ProfileListView that manages profile lists (followers, following, festivals)
class ProfileListViewModel extends BaseViewModel {
  int _currentTab = 0;
  bool _showingList = false;
  String _searchQuery = '';

  // Mock data - replace with actual data from repositories
  final List<Map<String, String>> _allFollowers = [
    {'name': 'John Doe', 'username': 'johndoe', 'image': AppAssets.profile},
    {'name': 'Jane Smith', 'username': 'janesmith', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},
  ];

  final List<Map<String, String>> _allFollowing = [
    {'name': 'Mike Johnson', 'username': 'mikej', 'image': AppAssets.profile},
    {'name': 'Sarah Wilson', 'username': 'sarahw', 'image': AppAssets.profile},
    {'name': 'Ayesha Noor', 'username': 'ayeshan', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},
    {'name': 'Ali Khan', 'username': 'alikhan', 'image': AppAssets.profile},

  ];

  final List<Map<String, String>> _allFestivals = [
    {'title': 'Coachella 2024', 'location': 'California'},
    {'title': 'Glastonbury', 'location': 'UK'},
    {'title': 'Burning Man', 'location': 'Nevada'},
    {'title': 'Burning Man', 'location': 'Nevada'},
    {'title': 'Burning Man', 'location': 'Nevada'},
  ];

  // Filtered lists (used for search)
  List<Map<String, String>> _followers = [];
  List<Map<String, String>> _following = [];
  List<Map<String, String>> _festivals = [];

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
      _applySearchFilter();
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

  /// 🔹 Unfollow a user
  void unfollowUser(Map<String, String> user) {
    _following.removeWhere((item) => item['username'] == user['username']);
    notifyListeners();
  }

  /// 🔹 Refresh List (Reset search + reload all data)
  void refreshList() {
    _searchQuery = '';
    _followers = List.from(_allFollowers);
    _following = List.from(_allFollowing);
    _festivals = List.from(_allFestivals);
    notifyListeners();
  }

  /// 🔹 Search by username or name
  void searchUser(String query) {
    _searchQuery = query.toLowerCase();
    _applySearchFilter();
    notifyListeners();
  }

  /// Internal helper to apply search filters to all tabs
  void _applySearchFilter() {
    if (_searchQuery.isEmpty) {
      _followers = List.from(_allFollowers);
      _following = List.from(_allFollowing);
      _festivals = List.from(_allFestivals);
    } else {
      _followers = _allFollowers
          .where((item) =>
      item['name']!.toLowerCase().contains(_searchQuery) ||
          item['username']!.toLowerCase().contains(_searchQuery))
          .toList();

      _following = _allFollowing
          .where((item) =>
      item['name']!.toLowerCase().contains(_searchQuery) ||
          item['username']!.toLowerCase().contains(_searchQuery))
          .toList();

      _festivals = _allFestivals
          .where((item) =>
      item['title']!.toLowerCase().contains(_searchQuery) ||
          item['location']!.toLowerCase().contains(_searchQuery))
          .toList();
    }
  }

  @override
  void init() {
    super.init();
    refreshList(); // initialize data
    _showingList = true;
  }
}
