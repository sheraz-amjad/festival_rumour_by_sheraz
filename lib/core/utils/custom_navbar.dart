import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../../shared/extensions/context_extensions.dart';

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
      {"icon": Icons.home_outlined, "label": AppStrings.home},
      {"icon": Icons.explore_outlined, "label": AppStrings.discover},
      {"icon": Icons.person_outline, "label": AppStrings.profile},
    ];

    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth / items.length;
    final double iconSize = 24.0;

    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final bool selected = currentIndex == index;
            final item = items[index];

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: containerWidth,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: _buildButton(item, selected, iconSize),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildButton(Map<String, dynamic> item, bool selected, double iconSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected 
            ? AppColors.accent // Use app accent color for selected
            : Colors.transparent, // Transparent for unselected
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item["icon"] as IconData,
            color: selected 
                ? AppColors.black // Black for selected (contrasts well with accent)
                : const Color(0xFF9E9E9E), // Light gray for unselected
            size: iconSize,
          ),
          const SizedBox(width: 6),
          Text(
            item["label"] as String,
            style: TextStyle(
              color: selected 
                  ? AppColors.black // Black for selected (contrasts well with accent)
                  : const Color(0xFF9E9E9E), // Light gray for unselected
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
