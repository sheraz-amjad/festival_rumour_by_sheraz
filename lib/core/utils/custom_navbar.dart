import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {"icon": Icons.home, "label": "Home"},
      {"icon": Icons.explore, "label": "Discover"},
      {"icon": Icons.person, "label": "Profile"},
    ];
    final bool isWide = MediaQuery.of(context).size.width >= AppDimensions.tabletBreakpoint;
    final double horizontalPadding = isWide ? AppDimensions.paddingL : AppDimensions.paddingM;
    final double verticalPadding = isWide ? AppDimensions.paddingM : AppDimensions.paddingS;
    final double iconSize = isWide ? AppDimensions.iconL : AppDimensions.iconM;

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusXL)),
          boxShadow: [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final bool selected = currentIndex == index;
            final item = items[index];

            final Color iconColor = selected ? AppColors.primary : AppColors.onSurfaceVariant;
            final Color chipColor = selected ? AppColors.primary.withOpacity(0.08) : Colors.transparent;
            final TextStyle labelStyle = TextStyle(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: isWide ? 14 : 12,
            );

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: EdgeInsets.symmetric(
                  horizontal: selected && isWide ? AppDimensions.paddingS : 0,
                  vertical: AppDimensions.paddingS,
                ),
                decoration: BoxDecoration(
                  color: chipColor,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
                ),
                child: Row(
                  children: [
                    Icon(
                      item["icon"] as IconData,
                      color: iconColor,
                      size: iconSize,
                    ),
                    if (selected && isWide) ...[
                      const SizedBox(width: AppDimensions.spaceS),
                      Text(
                        item["label"] as String,
                        style: labelStyle,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
