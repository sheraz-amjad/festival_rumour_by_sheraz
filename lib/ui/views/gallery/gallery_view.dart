import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'gallery_view_model.dart';

class GalleryView extends BaseView<GalleryViewModel> {
  const GalleryView({super.key});

  @override
  GalleryViewModel createViewModel() => GalleryViewModel();

  @override
  Widget buildView(BuildContext context, GalleryViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.gallery)),
    );
  }
}


