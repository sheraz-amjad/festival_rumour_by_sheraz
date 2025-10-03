import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'tickets_view_model.dart';

class TicketsView extends BaseView<TicketsViewModel> {
  const TicketsView({super.key});

  @override
  TicketsViewModel createViewModel() => TicketsViewModel();

  @override
  Widget buildView(BuildContext context, TicketsViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.tickets)),
    );
  }
}


