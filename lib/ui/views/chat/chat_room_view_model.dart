import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';

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
      print("Sending message: ${messageController.text}");
      messageController.clear();
      notifyListeners();
    }
  }

  void inviteFriends() {
    // Handle invite friends action
    print("Inviting friends to chat room");
  }
}
