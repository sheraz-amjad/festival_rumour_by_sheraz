import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import 'posts_view_model.dart';

class PostsView extends BaseView<PostsViewModel> {
  final VoidCallback? onBack;
  const PostsView({super.key, this.onBack});

  @override
  PostsViewModel createViewModel() => PostsViewModel();

  @override
  Widget buildView(BuildContext context, PostsViewModel viewModel) {
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
                _buildAppBar(context),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: viewModel.posts.length,
                    itemBuilder: (context, index) {
                      final post = viewModel.posts[index];
                      return _buildPostCard(context, post, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () {
          if (onBack != null) {
            onBack!();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      title: const Text(
        'Posts',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppColors.white),
          onPressed: () {
            // Handle more options
          },
        ),
      ],
    );
  }

  Widget _buildPostCard(BuildContext context, Map<String, dynamic> post, int index) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool _showReactions = false;
        String? _selectedReaction;
        Color _reactionColor = Colors.white;

        void _toggleReactions() {
          setState(() {
            _showReactions = !_showReactions;
          });
        }

        void _handleLike() {
          setState(() {
            post['likes'] = (post['likes'] ?? 0) + 1;
          });
        }

        void _handleComment() {
          // Navigate to comments or handle comment action
          debugPrint("Comment button tapped for post $index");
        }

        void _handleReaction(String emoji) {
          setState(() {
            _selectedReaction = emoji;
            _reactionColor = (emoji == "👍") ? Colors.blue : Colors.black;
            _showReactions = false;
            post['likes'] = (post['likes'] ?? 0) + 1;
          });
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.postBackground.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.postBorderRadius),
              topRight: Radius.circular(AppDimensions.postBorderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.postShadow.withOpacity(AppDimensions.postBoxShadowOpacity),
                blurRadius: AppDimensions.postBoxShadowBlur,
                offset: const Offset(0, AppDimensions.postBoxShadowOffsetY),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(post['userImage'] ?? ''),
                ),
                title: Text(
                  post['username'] ?? 'Unknown User',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accent),
                ),
                subtitle: Text(post['timeAgo'] ?? '2 hours ago'),
                trailing: const Icon(Icons.more_horiz),
              ),

              // Post Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.postContentPaddingHorizontal,
                ),
                child: Text(
                  post['description'] ?? '',
                  style: const TextStyle(color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppDimensions.reactionIconSpacing),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.postBorderRadius),
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.asset(
                          post['image'] ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),

                      // Floating Likes/Comments
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: _handleLike,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    _selectedReaction == null
                                        ? const Icon(Icons.thumb_up, color: Colors.white, size: 20)
                                        : Text(
                                      _selectedReaction!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: _reactionColor,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text("${post['likes'] ?? 0}",
                                        style: const TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: _handleComment,
                                child: Row(
                                  children: [
                                    const Icon(Icons.comment_outlined, color: Colors.white, size: 18),
                                    const SizedBox(width: 4),
                                    Text("${post['comments'] ?? 0}",
                                        style: const TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Reactions Popup
                      if (_showReactions)
                        Positioned(
                          bottom: 60,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildEmojiReaction("👍", "Like", Colors.blue, _handleReaction),
                                _buildEmojiReaction("❤️", "Love", Colors.red, _handleReaction),
                                _buildEmojiReaction("😂", "Haha", Colors.yellow, _handleReaction),
                                _buildEmojiReaction("😮", "Wow", Colors.orange, _handleReaction),
                                _buildEmojiReaction("😢", "Sad", Colors.blue, _handleReaction),
                                _buildEmojiReaction("😡", "Angry", Colors.red, _handleReaction),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingL),

              // Reaction Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite, color: AppColors.reactionLike, size: AppDimensions.reactionIconSize),
                  const SizedBox(width: AppDimensions.reactionIconSpacing),
                  const Icon(Icons.thumb_up, color: AppColors.reactionLove, size: AppDimensions.reactionIconSize),
                  const SizedBox(width: AppDimensions.reactionIconSpacing),
                  Text("${post['likes'] ?? 0}", style: const TextStyle(color: AppColors.white)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                  Text("${post['comments'] ?? 0} ", style: const TextStyle(color: AppColors.white)),
                  const SizedBox(width: AppDimensions.reactionIconSpacing),
                  const Text("Comments ", style: TextStyle(color: AppColors.white)),
                ],
              ),
              const SizedBox(height: AppDimensions.reactionIconSpacing),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    int? count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.white,
              size: 20,
            ),
            if (count != null && count > 0)
              Text(
                _formatCount(count),
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionEmoji(String emoji) {
    return GestureDetector(
      onTap: () {
        // Handle emoji reaction
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.grey800,
          shape: BoxShape.circle,
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  Widget _buildEmojiReaction(String emoji, String label, Color color, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(emoji),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 28, color: color),
        ),
      ),
    );
  }
}
