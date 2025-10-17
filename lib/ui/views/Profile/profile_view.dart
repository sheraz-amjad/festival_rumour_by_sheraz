import 'package:festival_rumour/core/constants/app_strings.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:festival_rumour/shared/widgets/responsive_widget.dart';
import 'package:festival_rumour/shared/widgets/responsive_text_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/backbutton.dart';

class ProfileView extends StatefulWidget {
  final VoidCallback? onBack;
  final Function(String)? onNavigateToSub;
  const ProfileView({super.key, this.onBack, this.onNavigateToSub});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int selectedTab = 0; // 0 = Posts, 1 = Reels, 2 = Reposts

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("🔙 Profile screen back button pressed");
        if (widget.onBack != null) {
          widget.onBack!(); // Navigate to home tab
          return false; // Prevent default back behavior
        }
        return true;
      },
      child: Scaffold(
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
              child: Container(color: AppColors.overlayBlack45),
            ),

            /// 🔹 Instagram-like scrollable content
            CustomScrollView(
              slivers: [
                /// Top Bar as Sliver
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: _profileTopBarWidget(),
                  ),
                ),

                /// Profile Header (Collapsible)
                SliverAppBar(
                  expandedHeight: context.isLargeScreen ? 350 : context.isMediumScreen ? 300 : 250,
                  floating: false,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildProfileHeader(),
                  ),
                ),

                /// Profile Tabs (Pinned)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _ProfileTabsDelegate(
                    child: Container(
                      height: AppDimensions.buttonHeightXL, // Match the actual content height
                      color: AppColors.black.withOpacity(0.8),
                      child: _profileTabs(),
                    ),
                  ),
                ),

                /// Dynamic Content
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.black.withOpacity(0.8),
                    child: _buildDynamicContent(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- INSTAGRAM-LIKE PROFILE HEADER ----------------
  Widget _buildProfileHeader() {
    final mediaQuery = MediaQuery.maybeOf(context);
    final topPadding = mediaQuery?.padding.top ?? 0.0;

    return Container(
      padding: EdgeInsets.only(
        top: topPadding + 40, // Reduced from 60 to 40
        left: AppDimensions.paddingM,
        right: AppDimensions.paddingM,
        bottom: AppDimensions.paddingM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Profile info (Username & followers left — Picture right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: context.isLargeScreen ? 55 : context.isMediumScreen ? 50 : 45,
                backgroundImage: const AssetImage(AppAssets.profile),
              ),
              SizedBox(width: context.isLargeScreen ? 22 : context.isMediumScreen ? 22 : 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username
                    ResponsiveTextWidget(
                      AppStrings.username,
                      textType: TextType.title,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.textL,
                    ),
                    SizedBox(height: context.isLargeScreen ? 12 : context.isMediumScreen ? 10 : 8),
                    // Stats aligned with profile picture width
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildClickableStat("120", AppStrings.posts, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('posts');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.posts);
                          }
                        }),
                        SizedBox(width: context.isLargeScreen ? 8 : context.isMediumScreen ? 6 : 4),
                        _buildClickableStat("5.4K", AppStrings.followers, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('followers');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.profileList,
                                arguments: 0);
                          }
                        }),
                        SizedBox(width: context.isLargeScreen ? 8 : context.isMediumScreen ? 6 : 4),
                        _buildClickableStat("340", AppStrings.following, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('following');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.profileList,
                                arguments: 1);
                          }
                        }),
                        SizedBox(width: context.isLargeScreen ? 8 : context.isMediumScreen ? 6 : 4),
                        _buildClickableStat("3", AppStrings.festivals, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('festivals');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.profileList,
                                arguments: 2);
                          }
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: context.isLargeScreen ? 12 : context.isMediumScreen ? 10 : 8),

          /// Bio / Description below profile picture
          ResponsiveTextWidget(
            AppStrings.bioDescription,
            textType: TextType.body,
            color: AppColors.white,
            fontSize: AppDimensions.textL,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  /// ---------------- DYNAMIC CONTENT ----------------
  Widget _buildDynamicContent() {
    return Column(
      children: [
       // SizedBox(height: context.isLargeScreen ? 20 : context.isMediumScreen ? 16 : 12),
        if (selectedTab == 0) _profileGridWidget(),
        if (selectedTab == 1) _profileReelsWidget(),
        if (selectedTab == 2) _profileRepostsWidget(),
      ],
    );
  }

  /// ---------------- PROFILE HEADER (OLD METHOD - KEEP FOR REFERENCE) ----------------
  Widget _profileHeaderSection() {
    return ResponsivePadding(
      mobilePadding: const EdgeInsets.all(AppDimensions.paddingM),
      tabletPadding: const EdgeInsets.all(AppDimensions.paddingL),
      desktopPadding: const EdgeInsets.all(AppDimensions.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Profile info (Username & followers left — Picture right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: context.isLargeScreen ? 55 : context.isMediumScreen ? 50 : 45,
                backgroundImage: const AssetImage(AppAssets.profile),
              ),
              SizedBox(width: context.isLargeScreen ? 22 : context.isMediumScreen ? 22 : 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username - full width
                    ResponsiveTextWidget(
                      AppStrings.username,
                      textType: TextType.title,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.textL,
                    ),
                    SizedBox(height: context.isLargeScreen ? 12 : context.isMediumScreen ? 10 : 8),
                    // Stats aligned with profile picture width
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildClickableStat("120", AppStrings.posts, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('posts');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.posts);
                          }
                        }),
                        SizedBox(width: context.isLargeScreen ? 8 : context.isMediumScreen ? 6 : 4),
                        _buildClickableStat("5.4K", AppStrings.followers, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('followers');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.profileList,
                                arguments: 0);
                          }
                        }),
                        SizedBox(width: context.isLargeScreen ? 8 : context.isMediumScreen ? 6 : 4),
                        _buildClickableStat("340", AppStrings.following, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('following');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.profileList,
                                arguments: 1);
                          }
                        }),
                        SizedBox(width: context.isLargeScreen ? 8 : context.isMediumScreen ? 6 : 4),
                        _buildClickableStat("3", AppStrings.festivals, () {
                          if (widget.onNavigateToSub != null) {
                            widget.onNavigateToSub!('festivals');
                          } else {
                            Navigator.pushNamed(context, AppRoutes.profileList,
                                arguments: 2);
                          }
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),


          SizedBox(height: context.isLargeScreen ? 20 : context.isMediumScreen ? 18 : 16),

          /// Bio / Description below profile picture
          ResponsiveTextWidget(
            AppStrings.bioDescription,
            textType: TextType.body,
            color: AppColors.white,
            fontSize: AppDimensions.textM,
            textAlign: TextAlign.left,
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
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        children: [
          /// Back button
          CustomBackButton(
            onTap: widget.onBack ?? () {},
          ),

          SizedBox(width: context.isLargeScreen ? 16 : context.isMediumScreen ? 12 : 8),

          /// Profile title
          ResponsiveTextWidget(
            AppStrings.profile,
            textType: TextType.title,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.textL,
          ),

          /// Spacer to push icons to the right
          const Spacer(),

          /// Right-side icons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showPostBottomSheet(context),
                icon: Icon(Icons.add_box_outlined,
                    color: AppColors.white, 
                    size: context.isHighResolutionPhone ? 28 : 26),
                padding: EdgeInsets.all(context.isHighResolutionPhone ? 8 : 4),
                constraints: BoxConstraints(
                  minWidth: context.isHighResolutionPhone ? 48 : 40,
                  minHeight: context.isHighResolutionPhone ? 48 : 40,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.notification);
                },
                icon: Icon(Icons.notifications_none,
                    color: AppColors.white, 
                    size: context.isHighResolutionPhone ? 28 : 26),
                padding: EdgeInsets.all(context.isHighResolutionPhone ? 8 : 4),
                constraints: BoxConstraints(
                  minWidth: context.isHighResolutionPhone ? 48 : 40,
                  minHeight: context.isHighResolutionPhone ? 48 : 40,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.settings);
                },
                icon: Icon(Icons.settings,
                    color: AppColors.white, 
                    size: context.isHighResolutionPhone ? 28 : 26),
                padding: EdgeInsets.all(context.isHighResolutionPhone ? 8 : 4),
                constraints: BoxConstraints(
                  minWidth: context.isHighResolutionPhone ? 48 : 40,
                  minHeight: context.isHighResolutionPhone ? 48 : 40,
                ),
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.isLargeScreen ? 4 : context.isMediumScreen ? 3 : 3,
        mainAxisSpacing: context.isLargeScreen ? 4 : 2,
        crossAxisSpacing: context.isLargeScreen ? 4 : 2,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (widget.onNavigateToSub != null) {
              widget.onNavigateToSub!('posts');
            } else {
              Navigator.pushNamed(context, AppRoutes.posts);
            }
          },
          child: Image.asset(images[index], fit: BoxFit.cover),
        );
      },
    );
  }


  Widget _profileReelsWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
      ),
    );
  }

  Widget _profileRepostsWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
      ),
    );
  }

  /// ---------------- HELPERS ----------------
  Widget _buildStat(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ResponsiveTextWidget(
          count,
          textType: TextType.title,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: context.isHighResolutionPhone ? 14 : 10,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        ResponsiveTextWidget(
          label,
          textType: TextType.caption,
          color: AppColors.white,
          fontSize: context.isHighResolutionPhone ? 10 : 6,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildClickableStat(String count, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isHighResolutionPhone ? 2 : 1,
          vertical: context.isHighResolutionPhone ? 2 : 1,
        ),
        child: _buildStat(count, label),
      ),
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
                fontSize: AppDimensions.textM)),
        Text(label,
            style: const TextStyle(color: AppColors.white, fontSize: AppDimensions.textXS)),
      ],
    );
  }

  Widget _profileTabs() {
    return Container(
      height: AppDimensions.buttonHeightXL,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _tabIcon(Icons.grid_on, 0),
          ),
          Expanded(
            child: _tabIcon(Icons.video_collection_outlined, 1),
          ),
          Expanded(
            child: _tabIcon(Icons.repeat, 2),
          ),
        ],
      ),
    );
  }

  Widget _tabIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: selectedTab == index ? AppColors.primary : AppColors.white,
        size: context.isHighResolutionPhone ? 24 : 20,
      ),
      onPressed: () => setState(() => selectedTab = index),
      padding: EdgeInsets.all(context.isHighResolutionPhone ? 8 : 6),
      constraints: BoxConstraints(
        minWidth: context.isHighResolutionPhone ? 48 : 40,
        minHeight: context.isHighResolutionPhone ? 48 : 40,
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            Scaffold(
              backgroundColor: AppColors.black,
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
                          Icons.close, color: AppColors.white, size: 30),
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
                    AppStrings.postJob,
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontSize: AppDimensions.textL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildJobTile(
                image: AppAssets.job1,
                title: AppStrings.festivalGizzaJob,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.jobpost);
                  // Navigate to add job screen if needed
                },
              ),
              const Divider(color: AppColors.yellow, thickness: 1),
              const SizedBox(height: AppDimensions.spaceS),
              _buildJobTile(
                image: AppAssets.job2,
                title: AppStrings.festieHerosJob,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.jobpost);
                  //d post screen if needed
                },
              ),
              const SizedBox(height: AppDimensions.paddingS),
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
                      width: AppDimensions.imageM,
                      height: AppDimensions.imageM,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: AppDimensions.paddingS),

                  /// Text — flexible and ellipsis
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textL,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Chevron icon (outside Expanded)
            const Icon(Icons.chevron_right, color: AppColors.yellow),
          ],
        ),
      ),
    );
  }
}

/// ---------------- SLIVER PERSISTENT HEADER DELEGATE ----------------
class _ProfileTabsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _ProfileTabsDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
