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
              onTap: () => _showBadgesDialog(context),
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
        activeColor: Colors.black,
        onChanged: onChanged,
      ),
    );
  }
  void _showBadgesDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 8,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Badges",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.onPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                // 🏅 Each badge item
                _buildBadgeItem(
                  icon: Icons.emoji_events,
                  title: "1  Top Rumour Spotter",
                  subtitle: "          For viral or trending posts",
                  color: Colors.orangeAccent,
                ),
                _buildBadgeItem(
                  icon: Icons.workspace_premium,
                  title: "2  Media Master",
                  subtitle: "          For contributing quality photos/videos",
                  color: Colors.purpleAccent,
                ),
                _buildBadgeItem(
                  icon: Icons.star,
                  title: "3  Crowd Favourite",
                  subtitle: "          For most liked/reacted content",
                  color: Colors.amber,
                ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.onPrimary,
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildBadgeItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 👈 text left-aligned
        children: [
          Center( // 👈 icon stays centered
            child: CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 50),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 25,
              color: AppColors.grey900,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }


}
