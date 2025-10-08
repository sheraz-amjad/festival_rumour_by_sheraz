import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/backbutton.dart';

class ProfileView extends StatefulWidget {
  final VoidCallback? onBack;
  const ProfileView({super.key, this.onBack});

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
                constraints: BoxConstraints(minHeight: MediaQuery
                    .of(context)
                    .size
                    .height),
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
              const SizedBox(width: 20), // smaller spacing for better layout
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
                        _buildClickableStat("120", "Posts", () {
                          // Example: you can open a posts grid or do nothing for now
                        }),
                        const SizedBox(width: 16),
                        _buildClickableStat("5.4K", "Followers", () {
                          Navigator.pushNamed(context, AppRoutes.profileList,
                              arguments: 0);
                        }),
                        const SizedBox(width: 16),
                        _buildClickableStat("340", "Following", () {
                          Navigator.pushNamed(context, AppRoutes.profileList,
                              arguments: 1);
                        }),
                        const SizedBox(width: 16),
                        _buildClickableStat("3", "Festivals", () {
                          Navigator.pushNamed(context, AppRoutes.profileList,
                              arguments: 2);
                        }),
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
          CustomBackButton(
            onTap: widget.onBack ?? () {},
          ),

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
                onPressed: () => _showPostBottomSheet(context),
                icon: const Icon(Icons.add_box_outlined,
                    color: AppColors.white, size: 26),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes
                      .news); // Replace with actual notifications screen route
                },
                icon: const Icon(Icons.notifications_none,
                    color: AppColors.white, size: 26),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.settings);
                },
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

  Widget _buildClickableStat(String count, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: _buildStat(count, label),
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
        builder: (_) =>
            Scaffold(
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
                      icon: const Icon(
                          Icons.close, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }


  void _showPostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.onPrimary.withOpacity(0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "POST JOB",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildJobTile(
                image: AppAssets.job1,
                title: "Festival Gizza Job",
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to add job screen if needed
                },
              ),
              const Divider(color: Colors.yellow, thickness: 1),
              const SizedBox(height: 8),
              _buildJobTile(
                image: AppAssets.job2,
                title: "FestieHeros Job",
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to another add post screen if needed
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJobTile({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
         // color: Colors.white.withOpacity(0.1),
         // borderRadius: BorderRadius.circular(10),
         // border: Border.all(color: Colors.yellow, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            /// Left side (Image + Text)
            Expanded(
              child: Row(
                children: [

                  /// Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Text — flexible and ellipsis
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Chevron icon (outside Expanded)
            const Icon(Icons.chevron_right, color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}
