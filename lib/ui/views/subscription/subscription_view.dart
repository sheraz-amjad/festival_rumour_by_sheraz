import 'package:flutter/material.dart';
import 'package:festival_rumour/core/constants/app_assets.dart';
import 'package:festival_rumour/core/constants/app_strings.dart';
import 'package:festival_rumour/core/constants/app_colors.dart';
import 'package:festival_rumour/core/constants/app_sizes.dart';
import 'package:festival_rumour/core/utils/base_view.dart';
import 'package:festival_rumour/ui/views/subscription/widgets/subscription_plan_tile.dart';
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
          _HeaderSection(screenHeight: screenHeight),
          _BottomSection(viewModel: viewModel),
        ],
      ),
    );
  }
}

/// Header Section
class _HeaderSection extends StatelessWidget {
  final double screenHeight;

  const _HeaderSection({required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.45,
      child: Stack(
        children: [
          _BackgroundImage(),
          _CloseButton(),
          _Title(),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        AppAssets.proback,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey300,
        ),
        child: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
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
    );
  }
}

/// Bottom Section
class _BottomSection extends StatelessWidget {
  final SubscriptionViewModel viewModel;

  const _BottomSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: const BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlanTiles(viewModel: viewModel),
              const SizedBox(height: 20),
              const _SubscriptionDetails(),
              const SizedBox(height: 20),
              _SubscribeButton(viewModel: viewModel),
              const SizedBox(height: 12),
              const _PrivacyText(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Plan Tiles
class _PlanTiles extends StatelessWidget {
  final SubscriptionViewModel viewModel;

  const _PlanTiles({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubscriptionPlanTile(
          label: 'Monthly',
          price: viewModel.getPrice(SubscriptionPlan.monthly),
          isSelected: viewModel.selectedPlan == SubscriptionPlan.monthly,
          onTap: () => viewModel.selectPlan(SubscriptionPlan.monthly),
        ),
        SubscriptionPlanTile(
          label: 'Yearly',
          price: viewModel.getPrice(SubscriptionPlan.yearly),
          isSelected: viewModel.selectedPlan == SubscriptionPlan.yearly,
          onTap: () => viewModel.selectPlan(SubscriptionPlan.yearly),
        ),
        SubscriptionPlanTile(
          label: 'Lifetime',
          price: viewModel.getPrice(SubscriptionPlan.lifetime),
          isSelected: viewModel.selectedPlan == SubscriptionPlan.lifetime,
          onTap: () => viewModel.selectPlan(SubscriptionPlan.lifetime),
        ),
      ],
    );
  }
}

/// Subscription Details
class _SubscriptionDetails extends StatelessWidget {
  const _SubscriptionDetails();

  @override
  Widget build(BuildContext context) {
    return Container(
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
        style: TextStyle(
          color: AppColors.white,
          fontSize: AppDimensions.textS,
        ),
      ),
    );
  }
}

/// Subscribe Button
class _SubscribeButton extends StatelessWidget {
  final SubscriptionViewModel viewModel;

  const _SubscribeButton({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}

/// Privacy Text
class _PrivacyText extends StatelessWidget {
  const _PrivacyText();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'By continuing you agree with the ',
        style: const TextStyle(color: Colors.white),
        children: [
          TextSpan(
            text: 'Privacy Policy.',
            style: const TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              color: Colors.white,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
