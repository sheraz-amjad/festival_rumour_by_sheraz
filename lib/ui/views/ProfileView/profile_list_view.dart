import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/backbutton.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/follower_tile.dart';
import '../../../core/services/festival_tile.dart';

import 'profile_list_view_model.dart';

class ProfileListView extends BaseView<ProfileListViewModel> {
  final int initialTab; // 0 = Followers, 1 = Following, 2 = Festivals
  final String username; // 🔹 show username in AppBar

  const ProfileListView({
    super.key,
    required this.initialTab,
    required this.username,
  });

  @override
  ProfileListViewModel createViewModel() => ProfileListViewModel();

  @override
  void onViewModelReady(ProfileListViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.setTab(initialTab);
  }

  @override
  Widget buildView(BuildContext context, ProfileListViewModel viewModel) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [

          /// 🔹 Background Image
          Positioned.fill(
            child: Image.asset(
              AppAssets.bottomsheet, // change to your image path
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Foreground Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔹 Custom AppBar (Back + Username + Refresh)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomBackButton(onTap: () => Navigator.pop(context)),
                      Text(
                        username,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: AppColors.white),
                        onPressed: viewModel.refreshList,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// 🔹 Scrollable Buttons Row (Posts | Followers | Following | Festivals)
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildStatButton(
                          count: "5.4K",
                          label: "Followers",
                          isActive: viewModel.currentTab == 1,
                          onTap: () => viewModel.setTab(1),
                        ),
                        _buildStatButton(
                          count: "340",
                          label: "Following",
                          isActive: viewModel.currentTab == 2,
                          onTap: () => viewModel.setTab(2),
                        ),
                        _buildStatButton(
                          count: "3",
                          label: "Followed Festival",
                          isActive: viewModel.currentTab == 0,
                          onTap: () => viewModel.setTab(0),
                        ),
                      ],
                    )
                ),

                const SizedBox(height: 30),

                /// 🔹 Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextField(
                    style: const TextStyle(
                      color: AppColors.primary, // ✅ Text color
                      fontSize: 14,
                    ),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      hintText: "Search username...",
                      hintStyle: TextStyle(
                        color: AppColors.primary, // ✅ Hint text color
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primary, // ✅ Icon color
                      ),
                      filled: true,
                      fillColor: AppColors.onPrimary.withOpacity(0.3), // ✅ Background color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:  BorderSide(
                          color: AppColors.onPrimary.withOpacity(0.3), // ✅ Border color (normal)
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: AppColors.onPrimary.withOpacity(0.3), // ✅ Border color (focused)
                          width: 1.2,
                        ),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    onChanged: viewModel.searchUser,
                  ),
                ),


                const SizedBox(height: 25),

                /// 🔹 Profile List (Scrollable)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListView.builder(
                      itemCount: viewModel.getCurrentList().length,
                      itemBuilder: (context, i) {
                        final item = viewModel.getCurrentList()[i];
                        return _buildProfileTile(context, viewModel, item);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Small button row (Posts, Followers, Following, Festivals)
  Widget _buildStatButton({
    required String count,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : AppColors.onPrimary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? AppColors.accent : AppColors.onPrimary,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Text(
                count,
                style: TextStyle(
                  color: isActive ? AppColors.onPrimary : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColors.onPrimary : AppColors.primary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context,
      ProfileListViewModel viewModel,
      Map<String, String> item,) {
    final size = MediaQuery
        .of(context)
        .size;
    final isSmallScreen = size.width < 360;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.007),
      padding: EdgeInsets.all(size.width * 0.035),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isSmallScreen
          ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: _buildTileContent(context, viewModel, item, size),
        ),
      )
          : _buildTileContent(context, viewModel, item, size),
    );
  }

  Widget _buildTileContent(BuildContext context,
      ProfileListViewModel viewModel,
      Map<String, String> item,
      Size size,) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        /// 🔹 Left section (Avatar + Name)
        Flexible(
          child: Row(
            children: [
              CircleAvatar(
                radius: size.width * 0.05,
                backgroundImage:
                AssetImage(item['image'] ?? 'assets/images/profile.png'),
              ),
              SizedBox(width: size.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? 'Unknown',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    Text(
                      '@${item['username'] ?? 'username'}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.grey600,
                        fontSize: size.width * 0.033,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// 🔹 Right section (Buttons + Menu)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (viewModel.currentTab == 1)
              _buildFixedButton(
                label: "Unfollow",
                color: AppColors.accent,
                onTap: () => viewModel.unfollowUser(item),
                size: size,
              )
            else
              if (viewModel.currentTab == 2)
                _buildFixedButton(
                  label: "Message",
                  color: AppColors.grey400,
                  onTap: () {},
                  size: size,
                )
              else
                if (viewModel.currentTab == 3)
                  _buildFixedIconButton(
                    icon: Icons.favorite,
                    label: "Favorite",
                    color: AppColors.accent,
                    onTap: () {},
                    size: size,
                  ),
            SizedBox(width: size.width * 0.02),
            const Icon(Icons.more_vert, color: AppColors.primary),
          ],
        ),
      ],
    );
  }

  /// 🔹 Constrained button to prevent infinite width
  Widget _buildFixedButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
    required Size size,
  }) {
    return SizedBox(
      width: 100, // ✅ Fixed finite width
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.onPrimary,
            fontSize: size.width * 0.04,
          ),
        ),
      ),
    );
  }

  /// 🔹 Constrained icon + label button
  Widget _buildFixedIconButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required Size size,
  }) {
    return SizedBox(
      width: 120, // ✅ Finite width avoids overflow
      height: 36,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.black, size: 14),
        label: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.03,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}