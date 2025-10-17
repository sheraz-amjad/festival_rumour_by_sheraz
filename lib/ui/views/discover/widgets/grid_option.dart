import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/navigation_service.dart'; // Make sure locator is registered for NavigationService

class GridOption extends StatelessWidget {
  final String title;
  final String icon; // Image path
  final Function(String)? onNavigateToSub;
  final VoidCallback? onTap;

  const GridOption({
    super.key,
    required this.title,
    required this.icon,
    this.onNavigateToSub,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        // Call the passed callback first (if provided)
        if (onTap != null) {
          onTap!();
        } else {
          // Otherwise, use your internal navigation handler
          _handleNavigation(title);
        }
      },
      child: Container(
        height: screenHeight * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          color: AppColors.onSurface,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: Stack(
            children: [
              // Background image
              Image.asset(
                icon,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),

              // Text overlay
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDimensions.spaceS),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: AppDimensions.textL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Handles navigation based on title
  void _handleNavigation(String title) {
    if (onNavigateToSub != null) {
      switch (title.toUpperCase()) {
        case 'CHAT ROOMS':
          onNavigateToSub!('chat');
          break;
        case 'LOCATION':
          onNavigateToSub!('map');
          break;
        case 'DETAIL':
          onNavigateToSub!('detail');
          break;
        default:
          // Do nothing for unknown titles
          break;
      }
    }
  }
}
