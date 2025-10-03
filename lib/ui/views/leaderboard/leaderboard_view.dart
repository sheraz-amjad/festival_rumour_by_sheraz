import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/leaderboard_tile.dart';
import 'leaderboard_view_model.dart';

class LeaderboardView extends BaseView<LeaderboardViewModel> {
  const LeaderboardView({super.key});

  @override
  LeaderboardViewModel createViewModel() => LeaderboardViewModel();

  @override
  Widget buildView(BuildContext context, LeaderboardViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.leaderboard)),
      body: ListView.builder(
        itemCount: viewModel.items.length,
        itemBuilder: (context, i) => LeaderboardTile(data: viewModel.items[i]),
      ),
    );
  }
}
