import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/backbutton.dart';
import '../../../core/utils/base_view.dart';
import 'settings_view_model.dart';

class SettingsView extends BaseView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  SettingsViewModel createViewModel() => SettingsViewModel();

  @override
  Widget buildView(BuildContext context, SettingsViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        title: const Text(
          AppStrings.settings,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.onPrimary,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: viewModel.goToSubscription,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent, // ✅ Changed button color to black
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: const Text(
                AppStrings.proLabel,
                style: TextStyle(
                  color: Colors.white, // ✅ White text on black background
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.textS,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 General Section
            const Text(
              "General",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.grey700,
              ),
            ),
            const SizedBox(height: 10),

            _buildTile(
              icon: Icons.person_outline,
              iconColor: Colors.amber,
              title: "Edit Account Details",
              onTap: viewModel.editAccount,
            ),
            _buildSwitchTile(
              icon: Icons.notifications_none,
              iconColor: Colors.teal,
              title: "Notification",
              value: viewModel.notifications,
              onChanged: viewModel.toggleNotifications,
              subtitle: "Enable or disable notifications",
            ),
            _buildSwitchTile(
              icon: Icons.lock_outline,
              iconColor: Colors.purple,
              title: "Privacy Settings PRO",
              subtitle: "Including Anonymous toggle",
              value: viewModel.privacy,
              onChanged: viewModel.togglePrivacy,
            ),
            _buildTile(
              icon: Icons.military_tech_outlined,
              iconColor: Colors.orange,
              title: "Badges",
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 18, color: AppColors.grey600),
              onTap: viewModel.openBadges,
            ),
            _buildTile(
              icon: Icons.leaderboard_outlined,
              iconColor: Colors.brown,
              title: "Leader board",
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 18, color: AppColors.grey600),
              onTap: viewModel.openLeaderboard,
            ),
            _buildTile(
              icon: Icons.logout,
              iconColor: Colors.red,
              title: "Logout",
              titleColor: Colors.red,
              onTap: viewModel.logout,
            ),

            const SizedBox(height: 20),

            /// 🔹 Others Section
            const Text(
              "Others",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.grey700,
              ),
            ),
            const SizedBox(height: 10),
            _buildTile(
              icon: Icons.help_outline,
              iconColor: Colors.cyan,
              title: "How to use ?",
              onTap: viewModel.openHelp,
            ),
            _buildTile(
              icon: Icons.star_outline,
              iconColor: Colors.yellow.shade700,
              title: "Rate Us",
              onTap: viewModel.rateApp,
            ),
            _buildTile(
              icon: Icons.share_outlined,
              iconColor: Colors.blueAccent,
              title: "Share App",
              onTap: viewModel.shareApp,
            ),
            _buildTile(
              icon: Icons.privacy_tip_outlined,
              iconColor: Colors.pink,
              title: "Privacy Policy",
              onTap: viewModel.openPrivacyPolicy,
            ),
            _buildTile(
              icon: Icons.article_outlined,
              iconColor: Colors.deepOrange,
              title: "Terms & Conditions",
              onTap: viewModel.openTerms,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔸 Normal List Tile
  Widget _buildTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    Color? titleColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.15),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? AppColors.grey900,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  /// 🔸 Switch Tile
  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.15),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.grey900,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.grey600,
          fontSize: 12,
        ),
      )
          : null,
      trailing: Switch(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }
}
