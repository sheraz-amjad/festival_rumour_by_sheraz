import 'package:festival_rumour/ui/views/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/setting_tile.dart';
import '../../../core/utils/base_view.dart';

class SettingsView extends BaseView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  SettingsViewModel createViewModel() => SettingsViewModel();

  @override
  Widget buildView(BuildContext context, SettingsViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: ListView(
        children: [
          SettingTile(
            title: AppStrings.notifications,
            trailing: Switch(
              value: model!.notifications,
              onChanged: (v) => model!.toggleNotifications(v),
            ),
          ),
          SettingTile(
            title: AppStrings.primarySettings,
            trailing: Switch(
              value: model!.primarySettings,
              onChanged: (v) => model!.togglePrimary(v),
            ),
          ),
          SettingTile(
            title: AppStrings.logout,
            onTap: model?.logout,
            trailing: const Icon(Icons.logout, color: AppColors.error),
          ),
        ],
      ),
    );
  }
}
