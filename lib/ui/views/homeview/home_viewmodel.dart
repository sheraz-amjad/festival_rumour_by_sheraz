import '../../../core/constants/app_numbers.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import 'post_model.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  List<PostModel> posts = [];

  Future<void> loadPosts() async {
    await handleAsync(() async {
      await Future.delayed(const Duration(seconds: 1));

      posts = [
        PostModel(
          username: AppStrings.username,
          timeAgo: AppStrings.timeAgo,
          content: AppStrings.postContent,
          imagePath: AppAssets.post,
          likes: AppNumbers.likesnumber,
          comments: AppNumbers.commentnumber,

        ),
        PostModel(
          username: AppStrings.username,
          timeAgo: AppStrings.timeAgo,
          content: AppStrings.postContent,
          imagePath: AppAssets.post,
          likes: AppNumbers.likesnumber,
          comments: AppNumbers.commentnumber,
        ),
      ];
    }, errorMessage: AppStrings.failedToLoadPosts);
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
