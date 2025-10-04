import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import 'event_model.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_durations.dart';

class EventViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final List<EventModel> events = [];
  int currentPage = 0;

  final PageController pageController = PageController(viewportFraction: AppDimensions.pageViewportFraction);
  Timer? _autoSlideTimer;

  Future<void> loadEvents() async {
    await handleAsync(() async {
      await Future.delayed(AppDurations.loadEventsDelay);

      events.addAll([
        EventModel(
          title: AppStrings.eventTitle,
          location: AppStrings.location,
          date: AppStrings.eventdate,
          imagepath: AppAssets.eventimage,
          isLive: false,
        ),
        EventModel(
          title: AppStrings.eventTitle,
          location: AppStrings.eventlocation,
          date: AppStrings.eventdate,
          imagepath: AppAssets.eventimage,
          isLive: true,
        ),
        EventModel(
          title: AppStrings.eventTitle,
          location: AppStrings.eventlocation,
          date: AppStrings.eventdate,
          imagepath: AppAssets.eventimage,
          isLive: false,
        ),
      ]);
    }, errorMessage: AppStrings.failedToLoadEvents);

    if (events.isNotEmpty) {
      final int base = (events.length * AppDimensions.pageBaseMultiplier) + 1;
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
    if (events.isEmpty) return;

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
    _navigationService.navigateTo(AppRoutes.main);
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
