import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class ActionTile extends StatelessWidget {
  final String iconPath; // image path (PNG/JPG)
  final String text;
  final VoidCallback? onTap;

  const ActionTile({
    super.key,
    required this.iconPath,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // ensures bounded width
        decoration: BoxDecoration(
          color: AppColors.onSurface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingM,
          horizontal: AppDimensions.paddingM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      iconPath,
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceM),
                  Flexible(
                    child: Text(
                      text,
                      style: const TextStyle(color: AppColors.primary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.white, size: 12),
          ],
        ),
      ),
    );
  }
}
