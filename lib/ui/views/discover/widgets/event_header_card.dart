import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_sizes.dart';

class EventHeaderCard extends StatelessWidget {
  const EventHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onSurface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Luna Fest 2025",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.textXL,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "SATURDAY  OCT 11 \nREVELSTORK, UK\n2:00 PM - 2:00",
                  style: TextStyle(
                    color: AppColors.grey400,
                    fontSize: AppDimensions.textS,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.calendar_month, color: AppColors.accent, size: 18),
                    SizedBox(width: 10),
                    Icon(Icons.location_on, color: AppColors.accent, size: 18),
                    SizedBox(width: 10),
                    Icon(Icons.map, color: AppColors.accent, size: 18),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            child: Image.asset(
              AppAssets.post,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
