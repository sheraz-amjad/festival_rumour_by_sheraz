import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';

class CommentViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController commentController = TextEditingController();

  final List<String> emojis = ["😀", "😂", "😍", "🔥", "🥳", "👍", "🙏", "🎉", "😎", "❤️"];

  void insertEmoji(String emoji) {
    commentController.text += emoji;
    notifyListeners();
  }

  void postComment() {
    // Handle post logic
    _navigationService.pop();
  }
}
