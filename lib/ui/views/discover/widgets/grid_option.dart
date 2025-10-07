import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class GridOption extends StatelessWidget {
  final String title;
  final String icon; // only image path

  const GridOption({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.2, // 20% of screen height
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

            // Bottom overlay with text
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppDimensions.spaceS),
              //  color: Colors.black.withOpacity(0.4), // semi-transparent overlay
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 25, // dynamic font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
