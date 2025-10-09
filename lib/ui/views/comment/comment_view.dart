import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'comment_viewmodel.dart';

class CommentView extends BaseView<CommentViewModel> {
  const CommentView({super.key});

  @override
  CommentViewModel createViewModel() => CommentViewModel();

  @override
  Widget buildView(BuildContext context, CommentViewModel viewModel) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Fullscreen background image
          Positioned.fill(
            child: Image.asset(
              AppAssets.bottomsheet,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Dark overlay for readability
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          /// 🔹 Main content
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context, viewModel),
                Expanded(
                  child: Column(
                    children: [
          // Comment input area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.grey800,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TextField(
                controller: viewModel.commentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: "Ask a question, gather people or share your thoughts 💡",
                  hintStyle: TextStyle(
                    color: AppColors.grey600,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          
          // Emoji bar
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: AppColors.grey800,
              border: Border(
                top: BorderSide(color: AppColors.grey700, width: 0.5),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.emojis.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => viewModel.insertEmoji(viewModel.emojis[index]),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Text(
                      viewModel.emojis[index],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Keyboard toolbar
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: AppColors.grey800,
              border: Border(
                top: BorderSide(color: AppColors.grey700, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                _buildToolbarIcon(Icons.grid_on, () {}),
                const SizedBox(width: 16),
                _buildToolbarIcon(Icons.attach_file, () {}),
                const SizedBox(width: 16),
                _buildToolbarText("GIF", () {}),
                const SizedBox(width: 16),
                _buildToolbarIcon(Icons.emoji_emotions, () {}),
                const SizedBox(width: 16),
                _buildToolbarIcon(Icons.photo_library, () {}),
                const SizedBox(width: 16),
                _buildToolbarIcon(Icons.mic, () {}),
              ],
            ),
          ),
          
          // Bottom input bar
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: AppColors.grey800,
              border: Border(
                top: BorderSide(color: AppColors.grey700, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                _buildBottomButton("!?123", () {}),
                const SizedBox(width: 8),
                _buildBottomButton("😊", () {}),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.grey700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: viewModel.commentController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(color: AppColors.grey600),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildBottomButton("@", () {}),
                const SizedBox(width: 8),
                _buildBottomButton("-", () {}),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: viewModel.postComment,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.black,
                      size: 20,
                    ),
                  ),
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
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, CommentViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.white, size: 24),
            onPressed: viewModel.closeCommentView,
          ),
          Expanded(
            child: Text(
              'Comment',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: viewModel.postComment,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'POST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: AppColors.grey600,
        size: 24,
      ),
    );
  }

  Widget _buildToolbarText(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.grey600,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBottomButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.grey700,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
