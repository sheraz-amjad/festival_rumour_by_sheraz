import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'compose_view_model.dart';

class ComposeView extends BaseView<ComposeViewModel> {
  const ComposeView({super.key});

  @override
  ComposeViewModel createViewModel() => ComposeViewModel();

  @override
  Widget buildView(BuildContext context, ComposeViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.compose)),
    );
  }
}


