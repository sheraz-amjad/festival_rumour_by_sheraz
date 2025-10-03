import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'chat_list_view_model.dart';

class ChatListView extends BaseView<ChatListViewModel> {
  const ChatListView({super.key});

  @override
  ChatListViewModel createViewModel() => ChatListViewModel();

  @override
  Widget buildView(BuildContext context, ChatListViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.chat)),
    );
  }
}


