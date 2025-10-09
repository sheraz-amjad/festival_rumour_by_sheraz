import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/constants/app_assets.dart';

class ChatViewModel extends BaseViewModel {
  int _selectedTab = 0; // 0 = Public, 1 = Private

  int get selectedTab => _selectedTab;

  void setSelectedTab(int tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  // Mock chat rooms data
  final List<Map<String, dynamic>> _chatRooms = [
    {
      'title': 'Luna fest',
      'subtitle': 'Community room',
      'image': AppAssets.post,
      'members': 156,
    },
    {
      'title': 'Music Festival',
      'subtitle': 'Private room',
      'image': AppAssets.post1,
      'members': 89,
    },
    {
      'title': 'Art & Culture',
      'subtitle': 'Community room',
      'image': AppAssets.post2,
      'members': 234,
    },
    {
      'title': 'Food & Drinks',
      'subtitle': 'Community room',
      'image': AppAssets.post3,
      'members': 178,
    },
    {
      'title': 'Photography',
      'subtitle': 'Private room',
      'image': AppAssets.post5,
      'members': 67,
    },
  ];

  List<Map<String, dynamic>> get chatRooms {
    if (_selectedTab == 0) {
      // Public rooms
      return _chatRooms.where((room) => room['subtitle'].contains('Community')).toList();
    } else {
      // Private rooms
      return _chatRooms.where((room) => room['subtitle'].contains('Private')).toList();
    }
  }

  // Private chat conversations
  final List<Map<String, dynamic>> _privateChats = [
    {
      'name': 'Luna',
      'avatar': AppAssets.profile,
      'lastMessage': 'Chutur congratulations',
      'timestamp': '21:08',
      'unreadCount': 4,
      'isActive': true,
    },
    {
      'name': 'Luna 2',
      'avatar': AppAssets.profile,
      'lastMessage': 'tarun: send me css notes',
      'timestamp': '20:45',
      'unreadCount': 0,
      'isActive': true,
    },
    {
      'name': 'Music Group',
      'avatar': AppAssets.profile,
      'lastMessage': 'Great performance tonight!',
      'timestamp': '19:30',
      'unreadCount': 2,
      'isActive': false,
    },
    {
      'name': 'Festival Crew',
      'avatar': AppAssets.profile,
      'lastMessage': 'Meeting at 3 PM tomorrow',
      'timestamp': '18:15',
      'unreadCount': 0,
      'isActive': false,
    },
    {
      'name': 'Art Community',
      'avatar': AppAssets.profile,
      'lastMessage': 'New exhibition opening next week',
      'timestamp': '17:45',
      'unreadCount': 1,
      'isActive': true,
    },
  ];

  List<Map<String, dynamic>> get privateChats => _privateChats;

  void joinRoom(Map<String, dynamic> room) {
    // Handle join room action
    print("Joining room: ${room['title']}");
  }
}
