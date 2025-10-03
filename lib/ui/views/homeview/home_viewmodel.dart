import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import 'post_model.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  List<PostModel> posts = [];

  Future<void> loadPosts() async {
    await handleAsync(() async {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      posts = [
        PostModel(
          username: "Sufyan Ch",
          timeAgo: "1 hr ago",
          content: "Lorem Ipsum is simply dummy text of the printing industry.",
          imagePath: "assets/images/Rectangle_2593.png",
          likes: 120,
          comments: 12,
        ),
        PostModel(
          username: "Jeremiah",
          timeAgo: "3 hr ago",
          content: "Lorem Ipsum is simply dummy text of the printing industry.",
          imagePath: "assets/images/Rectangle_2593.png",
          likes: 90,
          comments: 8,
        ),
      ];
    }, errorMessage: 'Failed to load posts');
  }

  Future<void> refreshPosts() async {
    await loadPosts();
  }

  void likePost(int index) {
    if (index < posts.length) {
      posts[index] = posts[index].copyWith(
        likes: posts[index].likes + 1,
      );
      notifyListeners();
    }
  }

  void addComment(int index) {
    if (index < posts.length) {
      posts[index] = posts[index].copyWith(
        comments: posts[index].comments + 1,
      );
      notifyListeners();
    }
  }

  void goToSubscription() {
    _navigationService.navigateTo(AppRoutes.subscription);
  }
}
