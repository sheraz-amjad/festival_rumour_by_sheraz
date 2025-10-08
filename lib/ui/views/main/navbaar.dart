import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/utils/custom_navbar.dart';
import '../homeview/home_view.dart';
import '../discover/discover_view.dart';
import '../ProfileView/profile_view.dart';
import 'navbaar_view_model.dart';

class NavBaar extends BaseView<NavBaarViewModel> {
  const NavBaar({super.key});

  @override
  NavBaarViewModel createViewModel() => NavBaarViewModel();

  @override
  Widget buildView(BuildContext context, NavBaarViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        // If user is on home screen (index 0), exit the app
        if (viewModel.currentIndex == 0) {
          SystemNavigator.pop();
          return false; // Prevent default back behavior
        }
        // For other screens, allow normal back navigation
        return true;
      },
      child: Scaffold(
        body: _buildBody(viewModel),
        bottomNavigationBar: CustomNavBar(
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.setIndex,
        ),
      ),
    );
  }

  Widget _buildBody(NavBaarViewModel viewModel) {
    switch (viewModel.currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return DiscoverView(onBack: viewModel.goToHome);
      case 2:
        return ProfileView(onBack: viewModel.goToHome);
      default:
        return const HomeView();
    }
  }
}
