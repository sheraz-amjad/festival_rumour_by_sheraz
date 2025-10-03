import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import 'comment_viewmodel.dart';

class CommentView extends BaseView<CommentViewModel> {
  const CommentView({super.key});

  @override
  CommentViewModel createViewModel() => CommentViewModel();

  @override
  Widget buildView(BuildContext context, CommentViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: viewModel.postComment,
        ),
        title: const Text(AppStrings.comment),
        actions: [
          TextButton(
            onPressed: viewModel.postComment,
            child: const Text(AppStrings.post, style: TextStyle(color: AppColors.info)),
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: viewModel.commentController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: "Ask a question, gather people or share your thoughts",
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(AppDimensions.paddingM),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: viewModel.emojis.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => viewModel.insertEmoji(viewModel.emojis[index]),
                  child: Center(child: Text(viewModel.emojis[index], style: const TextStyle(fontSize: AppDimensions.textTitle))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
