import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'news_view_model.dart';

class NewsView extends BaseView<NewsViewModel> {
  const NewsView({super.key});

  @override
  NewsViewModel createViewModel() => NewsViewModel();

  @override
  Widget buildView(BuildContext context, NewsViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.news)),
    );
  }
}


