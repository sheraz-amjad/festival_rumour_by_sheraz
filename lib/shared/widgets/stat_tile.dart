import 'package:flutter/material.dart';

/// A reusable widget for showing profile statistics like Posts, Followers, etc.
class StatTile extends StatelessWidget {
  final String count;
  final String label;
  final VoidCallback? onTap;

  const StatTile({
    super.key,
    required this.count,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
