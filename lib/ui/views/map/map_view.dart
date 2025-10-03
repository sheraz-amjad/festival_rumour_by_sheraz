import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'map_view_model.dart';

class MapView extends BaseView<MapViewModel> {
  const MapView({super.key});

  @override
  MapViewModel createViewModel() => MapViewModel();

  @override
  Widget buildView(BuildContext context, MapViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.map)),
    );
  }
}


