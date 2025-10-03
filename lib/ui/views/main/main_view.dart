import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/utils/custom_navbar.dart';
import '../../../core/constants/app_strings.dart';
import '../homeview/home_view.dart';
import '../discover/discover_view.dart';
import '../ProfileView/profile_view.dart';
import 'main_view_model.dart';

class MainView extends BaseView<MainViewModel> {
  const MainView({super.key});

  @override
  MainViewModel createViewModel() => MainViewModel();

  @override
  Widget buildView(BuildContext context, MainViewModel viewModel) {
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


