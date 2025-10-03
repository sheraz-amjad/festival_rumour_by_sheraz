import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import 'SplashViewModel.dart';
import 'package:festival_rumour/ui/views/welcome/welcome_view.dart';

class SplashView extends BaseView<SplashViewModel> {
  const SplashView({super.key});

  @override
  SplashViewModel createViewModel() => SplashViewModel();

  @override
  Widget buildView(BuildContext context, SplashViewModel viewModel) {
    if (viewModel.isLoading) {
      // Splash screen with logo + black background
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             // FlutterLogo(size: 120, style: FlutterLogoStyle.markOnly),
              SizedBox(height: 20),
              CircularProgressIndicator(color: AppColors.white),
            ],
          ),
        ),
      );
    } else {
      // Navigate to WelcomeView after loading
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WelcomeView(),
          ),
        );
      });
      return const SizedBox.shrink();
    }
  }
}
