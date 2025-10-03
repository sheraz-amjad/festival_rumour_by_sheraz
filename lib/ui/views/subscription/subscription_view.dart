import 'package:festival_rumour/core/constants/app_assets.dart';
import 'package:festival_rumour/core/constants/app_strings.dart';
import 'package:festival_rumour/ui/views/subscription/widgets/subscription_plan_tile.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/base_view.dart';
import 'subscription_viewmodel.dart';

class SubscriptionView extends BaseView<SubscriptionViewModel> {
  const SubscriptionView({super.key});

  @override
  SubscriptionViewModel createViewModel() => SubscriptionViewModel();

  @override
  Widget buildView(BuildContext context, SubscriptionViewModel viewModel) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          // 🔹 Top Half (Background + Overlay + Text)
          SizedBox(
            height: screenHeight * 0.45, // 50% of screen
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.proback,
                    fit: BoxFit.cover,
                  ),
                ),

                // Close button
                Positioned(
                  top: 40,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.grey300, // ✅ grey fill
                     // border: Border.all(color: AppColors.grey500, width: 2), // ✅ grey border
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: AppColors.black), // ✅ black icon
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),


                // Centered Logo + Text
                Align(
                  alignment: Alignment.center,
                  child: Column(
                   // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Row(
                       // mainAxisSize: MainAxisSize.min,

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.diamond, color: Colors.white, size: 40),
                          SizedBox(width: 8),
                          Text(
                            AppStrings.upgradetoprimium,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppDimensions.textDisplay,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Bottom Half (Plans + Buttons)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ), // ✅ scrollable if content overflows
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubscriptionPlanTile(
                      label: 'Monthly',
                      price: viewModel.getPrice(SubscriptionPlan.monthly),
                      isSelected:
                      viewModel.selectedPlan == SubscriptionPlan.monthly,
                      onTap: () =>
                          viewModel.selectPlan(SubscriptionPlan.monthly),
                    ),
                    SubscriptionPlanTile(
                      label: 'Yearly',
                      price: viewModel.getPrice(SubscriptionPlan.yearly),
                      isSelected:
                      viewModel.selectedPlan == SubscriptionPlan.yearly,
                      onTap: () =>
                          viewModel.selectPlan(SubscriptionPlan.yearly),
                    ),
                    SubscriptionPlanTile(
                      label: 'Lifetime',
                      price: viewModel.getPrice(SubscriptionPlan.lifetime),
                      isSelected:
                      viewModel.selectedPlan == SubscriptionPlan.lifetime,
                      onTap: () =>
                          viewModel.selectPlan(SubscriptionPlan.lifetime),
                    ),

                    const SizedBox(height: 20),

                    // Subscription details
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Subscription Details\n"
                            "• Users can join anonymously and remain hidden\n"
                            "• Posts and comments will show as 'Anonymous'\n"
                            "• Only available to users who purchase this as an in-app premium feature.",
                        style: TextStyle(color: AppColors.white, fontSize: AppDimensions.textS),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Subscribe button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: viewModel.subscribe,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.warning,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(AppStrings.subscribeNow),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Privacy Policy
                    Text.rich(
                      TextSpan(
                        text: 'By continuing you agree with the ',
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
