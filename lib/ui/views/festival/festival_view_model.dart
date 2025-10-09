import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_durations.dart';
import 'festival_model.dart';

class FestivalViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final List<FestivalModel> festivals = [];
  int currentPage = 0;

  final PageController pageController = PageController(viewportFraction: AppDimensions.pageViewportFraction);
  Timer? _autoSlideTimer;

  Future<void> loadFestivals() async {
    await handleAsync(() async {
      await Future.delayed(AppDurations.loadFestivalDelay);

      festivals.addAll([
        FestivalModel(
          title: AppStrings.festivalTitle,
          location: AppStrings.location,
          date: AppStrings.festivaldate,
          imagepath: AppAssets.festivalimage,
          isLive: false,
        ),
        FestivalModel(
          title: AppStrings.festivalTitle,
          location: AppStrings.festivallocation,
          date: AppStrings.festivaldate,
          imagepath: AppAssets.festivalimage,
          isLive: true,
        ),
        FestivalModel(
          title: AppStrings.festivalTitle,
          location: AppStrings.festivallocation,
          date: AppStrings.festivaldate,
          imagepath: AppAssets.festivalimage,
          isLive: false,
        ),
      ]);
    }, errorMessage: AppStrings.failedToLoadFestivals);

    if (festivals.isNotEmpty) {
      final int base = (festivals.length * AppDimensions.pageBaseMultiplier) + 1;
      currentPage = base;
      _jumpToInitialWhenReady(base);
      _startAutoSlide();
    }
  }

  void setPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    if (festivals.isEmpty) return;

    _autoSlideTimer = Timer.periodic(AppDurations.autoSlideInterval, (_) {
      if (pageController.positions.isEmpty) return;
      final int nextPage = currentPage + 1;
      pageController.animateToPage(
        nextPage,
        duration: AppDurations.slideAnimationDuration,
        curve: Curves.easeInOut,
      );
      currentPage = nextPage;
      notifyListeners();
    });
  }

  void navigateToHome() {
    _navigationService.navigateTo(AppRoutes.navbaar);
  }

  void goBack() {
    _navigationService.pop();
  }

  void goToNextSlide() {
    if (pageController.positions.isEmpty) return;
    final int nextPage = currentPage + 1;
    pageController.animateToPage(
      nextPage,
      duration: AppDurations.slideAnimationDuration,
      curve: Curves.easeInOut,
    );
    currentPage = nextPage;
    notifyListeners();
  }

  void _jumpToInitialWhenReady(int page) {
    if (pageController.hasClients) {
      pageController.jumpToPage(page);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToInitialWhenReady(page));
    }
  }

  @override
  void onDispose() {
    _autoSlideTimer?.cancel();
    pageController.dispose();
    super.onDispose();
  }
}
