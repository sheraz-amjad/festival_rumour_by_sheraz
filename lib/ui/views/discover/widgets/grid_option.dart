import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/navigation_service.dart'; // Make sure locator is registered for NavigationService

class GridOption extends StatelessWidget {
  final String title;
  final String icon; // Image path

  const GridOption({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        _handleNavigation(title, navigationService);
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
                      fontSize: 25,
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
  void _handleNavigation(String title, NavigationService navigationService) {
    switch (title.toUpperCase()) {
      case 'CHAT ROOMS':
        navigationService.navigateTo(AppRoutes.chat);
        break;
      case 'LOCATION':
        navigationService.navigateTo(AppRoutes.map);
        break;
      case 'DETAIL':
        navigationService.navigateTo(AppRoutes.detail);
        break;
      case 'RUMORS':
        navigationService.navigateTo(AppRoutes.home);
        break;
      default:
        navigationService.navigateTo(AppRoutes.home);
        break;
    }
  }
}
