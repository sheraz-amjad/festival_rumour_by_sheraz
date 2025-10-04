import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';

class CommentViewModel extends BaseViewModel {
  TextEditingController commentController = TextEditingController();
  bool _showEmojiGrid = false;

  List<String> emojis = [
    "😀", "😂", "😍", "👍", "👏", "😢", "🔥", "❤️"
  ];

  bool get showEmojiGrid => _showEmojiGrid;

  void showEmojiKeyboard() {
    _showEmojiGrid = true;
    notifyListeners();
  }

  void hideEmojiKeyboard() {
    _showEmojiGrid = false;
    notifyListeners();
  }

  void insertEmoji(String emoji) {
    commentController.text += emoji;
    commentController.selection = TextSelection.fromPosition(
      TextPosition(offset: commentController.text.length),
    );
    notifyListeners();
  }

  void postComment() {
    print("Comment posted: ${commentController.text}");
    commentController.clear();
    hideEmojiKeyboard();
  }

  void closeCommentView() {
    // Logic to close view
    print("Comment view closed");
  }

  @override
  void onDispose() {
    commentController.dispose();
    super.onDispose();
  }
}
