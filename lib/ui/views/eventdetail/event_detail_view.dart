import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'event_detail_view_model.dart';

class EventDetailView extends BaseView<EventDetailViewModel> {
  const EventDetailView({super.key});

  @override
  EventDetailViewModel createViewModel() => EventDetailViewModel();

  @override
  Widget buildView(BuildContext context, EventDetailViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.eventDetail)),
    );
  }
}


