import 'package:flutter/material.dart';
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
        final navigator = Navigator.of(context);

        // Case 1: If can pop a route inside current tab
        if (navigator.canPop()) {
          navigator.pop();
          return false;
        }

        // Case 2: If not on home tab, go to home tab instead
        if (viewModel.currentIndex != 0) {
          viewModel.setIndex(0);
          return false;
        }

        // Case 3: Already on home tab, prevent exit
        return false;
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
