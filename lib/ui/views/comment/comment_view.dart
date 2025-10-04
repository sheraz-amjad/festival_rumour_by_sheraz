import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Full screen background image
            Positioned.fill(
              child: Image.asset(
                AppAssets.bottomsheet, // From app constants
                fit: BoxFit.cover,
              ),
            ),

            // Back button
            BackButton(onPressed: viewModel.closeCommentView),

            // Comment box at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Reaction emoji grid (shown when comment box is focused)
                  if (viewModel.showEmojiGrid)
                    Container(
                      height: 150,
                      color: Colors.black.withOpacity(0.5),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(AppDimensions.paddingS),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          mainAxisSpacing: AppDimensions.paddingS,
                          crossAxisSpacing: AppDimensions.paddingS,
                        ),
                        itemCount: viewModel.emojis.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => viewModel.insertEmoji(viewModel.emojis[index]),
                            child: Center(
                              child: Text(
                                viewModel.emojis[index],
                                style: const TextStyle(fontSize: AppDimensions.size20),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // Comment input field
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                      vertical: AppDimensions.paddingS,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: viewModel.commentController,
                            maxLines: null,
                            onTap: viewModel.showEmojiKeyboard,
                            decoration: const InputDecoration(
                              hintText: AppStrings.commentHint,
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: AppDimensions.size16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: AppColors.info),
                          onPressed: viewModel.postComment,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
