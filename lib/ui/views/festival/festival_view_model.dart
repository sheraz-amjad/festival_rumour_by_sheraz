import 'dart:async';
import 'package:flutter/material.dart';
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
  final List<FestivalModel> allFestivals = []; // Store all festivals
  List<FestivalModel> filteredFestivals = []; // Filtered festivals for search
  int currentPage = 0;
  String searchQuery = ''; // Search query
  late FocusNode searchFocusNode; // Search field focus node

  final PageController pageController = PageController(viewportFraction: AppDimensions.pageViewportFraction);
  Timer? _autoSlideTimer;

  FestivalViewModel() {
    searchFocusNode = FocusNode();
  }

  Future<void> loadFestivals() async {
    await handleAsync(() async {
      await Future.delayed(AppDurations.loadFestivalDelay);

      allFestivals.addAll([
        FestivalModel(
          title: "Electric Music Festival",
          location: "Miami, Florida",
          date: "March 15-17, 2024",
          imagepath: AppAssets.festivalimage,
          isLive: true,
        ),
        FestivalModel(
          title: "Coachella Valley Music Festival",
          location: "Indio, California",
          date: "April 12-14, 2024",
          imagepath: AppAssets.festivalimage,
          isLive: false,
        ),
        FestivalModel(
          title: "Tomorrowland Electronic Festival",
          location: "Boom, Belgium",
          date: "July 19-21, 2024",
          imagepath: AppAssets.festivalimage,
          isLive: false,
        ),
        FestivalModel(
          title: "Burning Man Festival",
          location: "Black Rock City, Nevada",
          date: "August 25-September 2, 2024",
          imagepath: AppAssets.festivalimage,
          isLive: false,
        ),
        FestivalModel(
          title: "Ultra Music Festival",
          location: "Miami, Florida",
          date: "March 22-24, 2024",
          imagepath: AppAssets.festivalimage,
          isLive: true,
        ),
        FestivalModel(
          title: "Glastonbury Festival",
          location: "Pilton, England",
          date: "June 26-30, 2024",
          imagepath: AppAssets.festivalimage,
          isLive: false,
        ),
      ]);
      
      // Initially show all festivals
      festivals.addAll(allFestivals);
      filteredFestivals.addAll(allFestivals);
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

  // Search methods
  void setSearchQuery(String query) {
    searchQuery = query;
    _applySearchFilter();
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = '';
    _applySearchFilter();
    notifyListeners();
  }

  void unfocusSearch() {
    searchFocusNode.unfocus();
  }

  void _applySearchFilter() {
    if (searchQuery.isEmpty) {
      filteredFestivals = List.from(allFestivals);
    } else {
      filteredFestivals = allFestivals.where((festival) {
        return festival.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
               festival.location.toLowerCase().contains(searchQuery.toLowerCase()) ||
               festival.date.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
  }

  String get currentSearchQuery => searchQuery;

  @override
  void onDispose() {
    _autoSlideTimer?.cancel();
    pageController.dispose();
    searchFocusNode.dispose();
    super.onDispose();
  }
}
