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
      {"icon": Icons.home_outlined, "label": "Home"},
      {"icon": Icons.explore_outlined, "label": "Discover"},
      {"icon": Icons.person_outline, "label": "Profile"},
    ];

    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth / items.length;
    final double iconSize = AppDimensions.iconM;

    return SafeArea(
      top: false,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: List.generate(items.length, (index) {
            final bool selected = currentIndex == index;
            final item = items[index];

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: containerWidth,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.black.withOpacity(0.1) // Light black highlight for selected
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item["icon"] as IconData,
                      color: selected
                          ? AppColors.black // Black for selected
                          : AppColors.lightBlack, // Light black for unselected
                      size: selected ? iconSize + 2 : iconSize, // Slightly larger for selected
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["label"] as String,
                      style: TextStyle(
                        color: selected
                            ? AppColors.black // Black for selected
                            : AppColors.lightBlack, // Light black for unselected
                        fontWeight: selected 
                            ? FontWeight.bold 
                            : FontWeight.w400, // Lighter weight for unselected
                        fontSize: selected ? 12 : 11, // Slightly smaller for unselected
                      ),
                    ),
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
