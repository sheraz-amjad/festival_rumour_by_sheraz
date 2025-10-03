import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FollowerTile extends StatelessWidget {
  final Map<String, String> data;
  final bool showAction;
  final VoidCallback? onAction;

  const FollowerTile({
    super.key,
    required this.data,
    this.showAction = false,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2, horizontal: -2),
      leading: CircleAvatar(backgroundImage: NetworkImage(data['avatar']!)),
      title: Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(data['username']!, style: TextStyle(color: AppColors.mutedText)),
      trailing: SizedBox(
        width: 110,
        height: 36,
        child: showAction
            ? ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, padding: EdgeInsets.zero),
                child: const Text('Unfollow', overflow: TextOverflow.ellipsis),
              )
            : OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
                child: const Text('Message', overflow: TextOverflow.ellipsis),
              ),
      ),
    );
  }
}
