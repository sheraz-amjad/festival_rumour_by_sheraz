import 'package:flutter/material.dart';
import '../post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(post.imagePath),
            ),
            title: Text(
              post.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.timeAgo),
            trailing: const Icon(Icons.more_horiz),
          ),

          // 🔹 Post Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(post.content),
          ),
          const SizedBox(height: 8),

          // 🔹 Post Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(post.imagePath, fit: BoxFit.cover),
          ),

          const SizedBox(height: 8),

          // 🔹 Reaction Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // Reactions (Like, Love, etc.)
                const Icon(Icons.favorite, color: Colors.red, size: 20),
                const SizedBox(width: 6),
                const Icon(Icons.thumb_up, color: Colors.blue, size: 20),
                const SizedBox(width: 6),
                Text("${post.likes}"),
                const Spacer(),
                Text("${post.comments} Comments"),
              ],
            ),
          ),

          const Divider(),

          // 🔹 Actions Row (Like, Comment, Share)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.thumb_up_alt_outlined),
                Icon(Icons.comment_outlined),
                Icon(Icons.share_outlined),
              ],
            ),
          ),

          
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
