import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../post_model.dart';
class PostWidget extends StatefulWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _showReactions = false;
  String? _selectedReaction; // stores emoji / icon selected
  Color _reactionColor = Colors.white; // default Like color

  void _toggleReactions() {
    setState(() {
      _showReactions = !_showReactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Container(
      height: context.isLargeScreen 
        ? MediaQuery.of(context).size.height * 0.5
        : context.isMediumScreen 
          ? MediaQuery.of(context).size.height * 0.45
          : MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: AppColors.postBackground.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.postBorderRadius),
          topRight: Radius.circular(AppDimensions.postBorderRadius),
        ),        boxShadow: [
          BoxShadow(
            color: AppColors.postShadow.withOpacity(AppDimensions.postBoxShadowOpacity),
            blurRadius: AppDimensions.postBoxShadowBlur,
            offset: const Offset(0, AppDimensions.postBoxShadowOffsetY),
          ),
        ],
      ),
      child: Column(
        children: [
//          Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(post.imagePath),
            ),
            title: Text(
              post.username,
              style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.accent),
            ),
            subtitle: Text(post.timeAgo),
            trailing: const Icon(Icons.more_horiz),
          ),

          // Post Content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.postContentPaddingHorizontal,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                post.content,
                style: const TextStyle(color: AppColors.primary),
                textAlign: TextAlign.left,
              ),
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
                      post.imagePath,
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
                          onTap: _toggleReactions,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                _selectedReaction == null
                                    ? Icon(Icons.thumb_up,
                                    color: Colors.white, 
                                    size: context.isLargeScreen ? 24 : context.isMediumScreen ? 22 : 20)
                                    : Text(
                                  _selectedReaction!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _reactionColor,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text("${post.likes}",
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
                          child:
                          InkWell(
                            onTap: () {
                              // Navigate to comment screen using your app router
                              Navigator.pushNamed(
                                context,
                                AppRoutes.comments, // 👈 Define this route
                                arguments: post,    // optional: pass the post if needed
                              );
                            },
                          child: Row(
                            children: [
                              Icon(Icons.comment_outlined,
                                  color: Colors.white, 
                                  size: context.isLargeScreen ? 22 : context.isMediumScreen ? 20 : 18),
                              const SizedBox(width: 4),
                              Text("${post.comments}",
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
                            _buildEmojiReaction("👍", "Like", Colors.blue), // blue like
                            _buildEmojiReaction("❤️", "Love"),
                            _buildEmojiReaction("😂", "Haha"),
                            _buildEmojiReaction("😮", "Wow"),
                            _buildEmojiReaction("😢", "Sad"),
                            _buildEmojiReaction("😡", "Angry"),
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
              Icon(Icons.favorite,
                  color: AppColors.reactionLike,
                  size: context.isLargeScreen ? AppDimensions.reactionIconSize + 4 : context.isMediumScreen ? AppDimensions.reactionIconSize + 2 : AppDimensions.reactionIconSize),
              const SizedBox(width: AppDimensions.reactionIconSpacing),
              Icon(Icons.thumb_up,
                  color: AppColors.reactionLove,
                  size: context.isLargeScreen ? AppDimensions.reactionIconSize + 4 : context.isMediumScreen ? AppDimensions.reactionIconSize + 2 : AppDimensions.reactionIconSize),
              const SizedBox(width: AppDimensions.reactionIconSpacing),
              Text("${post.likes}",style: TextStyle(color: AppColors.white),),

               SizedBox(width: context.isLargeScreen 
                 ? MediaQuery.of(context).size.width * 0.4
                 : context.isMediumScreen 
                   ? MediaQuery.of(context).size.width * 0.35
                   : MediaQuery.of(context).size.width * 0.3),

              Text("${post.comments} ",style: TextStyle(color: AppColors.white),),
              const SizedBox(width: AppDimensions.reactionIconSpacing),

              Text("${AppStrings.comments} ",style: TextStyle(color: AppColors.white),),

            ],
          ),





          const SizedBox(height: AppDimensions.reactionIconSpacing),
        ],
      ));
  }

  Widget _buildEmojiReaction(String emoji, String label, [Color color = Colors.black]) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedReaction = emoji;
          _reactionColor = (emoji == "👍") ? Colors.blue : Colors.black;
          _showReactions = false;
        });
        debugPrint("User reacted with $label");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 28, color: (emoji == "👍") ? Colors.blue : null),
        ),
      ),
    );
  }
}

// class PostWidget extends StatelessWidget {
//   final PostModel post;
//
//   const PostWidget({super.key, required this.post});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.5,
//       margin: const EdgeInsets.symmetric(
//         // horizontal: AppDimensions.postMarginHorizontal,
//         // vertical: AppDimensions.postMarginVertical,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.postBackground.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(AppDimensions.postBorderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.postShadow.withOpacity(AppDimensions.postBoxShadowOpacity),
//             blurRadius: AppDimensions.postBoxShadowBlur,
//             offset: const Offset(0, AppDimensions.postBoxShadowOffsetY),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           ListTile(
//             leading: CircleAvatar(
//               backgroundImage: AssetImage(post.imagePath),
//             ),
//             title: Text(
//               post.username,
//               style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.accent),
//             ),
//             subtitle: Text(post.timeAgo),
//             trailing: const Icon(Icons.more_horiz),
//           ),
//
//           // Post Content
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: AppDimensions.postContentPaddingHorizontal,
//             ),
//             child: Text(post.content,style: const TextStyle(color: AppColors.primary), ),
//           ),
//           const SizedBox(height: AppDimensions.reactionIconSpacing),
//
//           // Post Image
//           // Post Image with overlayed likes/comments
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(AppDimensions.postBorderRadius),
//               child: Stack(
//                 children: [
//                   // The actual post image
//                   Positioned.fill(
//                     child: Image.asset(
//                       post.imagePath,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                   ),
//
//                   // Floating Likes/Comments container
//                   Positioned(
//                     bottom: 12, // distance from bottom
//                     right: 12,  // distance from right
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.6),
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Like count
//                           Column(
//                             children: [
//                               const Icon(Icons.thumb_up,
//                                   color: Colors.white, size: 20),
//                               const SizedBox(width: 4),
//                               Text(
//                                 "${post.likes}",
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           // Comment count
//                           Column(
//                             children: [
//                               const Icon(Icons.comment_outlined,
//                                   color: Colors.white, size: 20),
//                               const SizedBox(width: 4),
//                               Text(
//                                 "${post.comments}",
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//
//
//           const SizedBox(height: AppDimensions.reactionIconSpacing),
//
//           // Reaction Row
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: AppDimensions.postContentPaddingHorizontal,
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.favorite,
//                     color: AppColors.reactionLike,
//                     size: AppDimensions.reactionIconSize),
//                 const SizedBox(width: AppDimensions.reactionIconSpacing),
//                 const Icon(Icons.thumb_up,
//                     color: AppColors.reactionLove,
//                     size: AppDimensions.reactionIconSize),
//                 const SizedBox(width: AppDimensions.reactionIconSpacing),
//                 Text("${post.likes}"),
//                 const Spacer(),
//                 Text("${post.comments}${AppStrings.comments}"),
//               ],
//             ),
//           ),
//
//           const Divider(),
//
//           // Actions Row
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: AppDimensions.actionRowSpacing,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: const [
//                 Icon(Icons.thumb_up_alt_outlined),
//                 Icon(Icons.comment_outlined),
//                 Icon(Icons.share_outlined),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: AppDimensions.reactionIconSpacing),
//         ],
//       ),
//     );
//   }
// }
