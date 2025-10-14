import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/constants/app_strings.dart';

class ChatRoomViewModel extends BaseViewModel {
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      // Handle sending message
      print("${AppStrings.sendingMessage}${messageController.text}");
      messageController.clear();
      notifyListeners();
    }
  }

  void inviteFriends() {
    // Handle invite friends action
    print(AppStrings.invitingFriendsToChatRoom);
  }
}
