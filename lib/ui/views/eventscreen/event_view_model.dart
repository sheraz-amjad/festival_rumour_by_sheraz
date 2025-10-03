import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';
import 'event_model.dart';

class EventViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  
  final List<EventModel> events = [];
  int currentPage = 0;
  // Single centered slide with side peeks. We'll jump to a high initial page after data loads
  final PageController pageController = PageController(viewportFraction: 0.9);
  Timer? _autoSlideTimer;

  Future<void> loadEvents() async {
    await handleAsync(() async {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Example data (replace with API/local data)
      events.addAll([
        EventModel(
            title: "Music Fest",
            location: "Lahore",
            date: "Oct 28, 2025",
            imagepath: "assets/images/Rectangle_2593.png",
            isLive: false),
        EventModel(
            title: "Art Expo",
            location: "Karachi",
            date: "Nov 12, 2025",
            imagepath: "assets/images/Rectangle_2593.png",
            isLive: true),
        EventModel(
            title: "Food Carnival",
            location: "Islamabad",
            date: "Dec 5, 2025",
            imagepath: "assets/images/Rectangle_2593.png",
            isLive: false),
      ]);
    }, errorMessage: 'Failed to load events');
    
    // After data load, set initial page and start auto-slide outside error handling
    if (events.isNotEmpty) {
      final int base = (events.length * 1000) + 1; // start at logical slide 2
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

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (pageController.positions.isEmpty) return;
      final int nextPage = currentPage + 1;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
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
      duration: const Duration(milliseconds: 300),
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
