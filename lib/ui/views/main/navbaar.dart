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
    return Scaffold(
      body: _buildBody(viewModel.currentIndex),
      bottomNavigationBar: CustomNavBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const DiscoverView();
      case 2:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }
}
