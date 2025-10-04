import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/backbutton.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int selectedTab = 0; // 0 = Posts, 1 = Reels, 2 = Reposts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Fullscreen background image
          Positioned.fill(
            child: Image.asset(
              AppAssets.bottomsheet,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Dark overlay for readability
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          /// 🔹 Main content
          SafeArea(
            child: SingleChildScrollView(
          child: ConstrainedBox(
    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
    child: Column(
                children: [
                  _profileTopBarWidget(),
                  const Divider(color: AppColors.white, thickness: 0.5),
                  const SizedBox(height: 10),
                  _profileHeaderSection(),
                  const SizedBox(height: 30),


                  _profileTabs(),

                  /// Dynamic section
                  if (selectedTab == 0) _profileGridWidget(),
                  if (selectedTab == 1) _profileReelsWidget(),
                  if (selectedTab == 2) _profileRepostsWidget(),
                ],
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  /// ---------------- PROFILE HEADER ----------------
  Widget _profileHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile info (Username & followers left — Picture right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(AppAssets.profile),
              ),
              const SizedBox(width: 25), // smaller spacing for better layout
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sheraz Amjad",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildStat("120", "Posts"),
                        const SizedBox(width: 16),
                        _buildStat("5.4K", "Followers"),
                        const SizedBox(width: 16),
                        _buildStat("340", "Following"),
                        const SizedBox(width: 16),
                        _buildStat("3", "Festivals"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),


          const SizedBox(height: 16),

          /// Bio / Description below profile picture
          const Text(
            "Bringing people together through music, color, and culture!",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- TOP BAR ----------------
  Widget _profileTopBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Back button
          CustomBackButton(onTap: () => context.pop()),

          const Text(
            "Profile",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          /// Right-side icons
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_box_outlined,
                    color: AppColors.white, size: 26),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none,
                    color: AppColors.white, size: 26),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings,
                    color: AppColors.white, size: 26),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- GRID / REELS / REPOSTS ----------------
  Widget _profileGridWidget() {
    final List<String> images = AppAssets.profilePosts;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _openFullScreenImage(context, images[index]),
          child: Image.asset(images[index], fit: BoxFit.cover),
        );
      },
    );
  }


  Widget _profileReelsWidget() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          "Reels Section",
          style: TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _profileRepostsWidget() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          "Reposts Section",
          style: TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }

  /// ---------------- HELPERS ----------------
  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMiniStat(String count, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(count,
            style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        Text(label,
            style: const TextStyle(color: AppColors.white, fontSize: 11)),
      ],
    );
  }

  Widget _profileTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _tabIcon(Icons.grid_on, 0),
        _tabIcon(Icons.video_collection_outlined, 1),
        _tabIcon(Icons.repeat, 2),
      ],
    );
  }

  Widget _tabIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: selectedTab == index ? AppColors.primary : AppColors.white,
      ),
      onPressed: () => setState(() => selectedTab = index),
    );
  }

  void _openFullScreenImage(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
