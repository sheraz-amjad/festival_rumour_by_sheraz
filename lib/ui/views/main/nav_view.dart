import 'package:festival_rumour/ui/views/discover/discover_view.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/utils/custom_navbar.dart';
import '../ProfileView/profile_view.dart';
import '../homeview/home_view.dart';
import 'nav_view_model.dart';

class NavView extends BaseView<NavViewModel> {
  const NavView({super.key});

  @override
  NavViewModel createViewModel() => NavViewModel();

  @override
  Widget buildView(BuildContext context, NavViewModel viewModel) {
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
