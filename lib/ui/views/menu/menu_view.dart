import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'menu_view_model.dart';

class MenuView extends BaseView<MenuViewModel> {
  const MenuView({super.key});

  @override
  MenuViewModel createViewModel() => MenuViewModel();

  @override
  Widget buildView(BuildContext context, MenuViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.menu)),
    );
  }
}


