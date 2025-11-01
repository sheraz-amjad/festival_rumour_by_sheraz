import 'package:festival_rumour/core/router/app_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:festival_rumour/shared/extensions/context_extensions.dart';
import 'package:festival_rumour/ui/views/discover/widgets/action_tile.dart';
import 'package:festival_rumour/ui/views/discover/widgets/event_header_card.dart';
import 'package:festival_rumour/ui/views/discover/widgets/grid_option.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/backbutton.dart';
import '../../../core/utils/base_view.dart';
import '../../../shared/widgets/responsive_text_widget.dart';
import '../../../core/utils/snackbar_util.dart';
import '../../../shared/widgets/responsive_widget.dart';
import 'discover_viewmodel.dart';

class DiscoverView extends BaseView<DiscoverViewModel> {
  final VoidCallback? onBack;
  final Function(String)? onNavigateToSub;
  const DiscoverView({super.key, this.onBack, this.onNavigateToSub});

  @override
  DiscoverViewModel createViewModel() => DiscoverViewModel();

  @override
  Widget buildView(BuildContext context, DiscoverViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        print("🔙 Discover screen back button pressed");
        if (onBack != null) {
          onBack!();
          return false;
        }
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            _buildBackground(),
            SafeArea(
              child: ResponsiveContainer(
                mobileMaxWidth: double.infinity,
                tabletMaxWidth: AppDimensions.tabletWidth,
                desktopMaxWidth: AppDimensions.desktopWidth,
                child: SingleChildScrollView(

                  child: ResponsivePadding(
                    mobilePadding: const EdgeInsets.all(AppDimensions.paddingS),
                    tabletPadding: const EdgeInsets.all(AppDimensions.paddingM),
                    desktopPadding: const EdgeInsets.all(AppDimensions.paddingXL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopBar(context, viewModel),
                        _divider(),
                        const EventHeaderCard(),
                        SizedBox(height: AppDimensions.spaceS),
                        _buildGetReadyText(),
                        SizedBox(height: AppDimensions.spaceS),
                        _buildActionTiles(context),
                        SizedBox(height: AppDimensions.spaceS),
                        _buildGridOptions(context, viewModel),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- BACKGROUND ----------------
  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset(
        AppAssets.bottomsheet,
        fit: BoxFit.cover,
      ),
    );
  }

  /// ---------------- TOP BAR ----------------
  Widget _buildTopBar(BuildContext context, DiscoverViewModel viewModel) {
    return Row(
      children: [
        CustomBackButton(onTap: onBack ?? () {}),
        SizedBox(width: context.getConditionalSpacing()),
        ResponsiveTextWidget(
          AppStrings.overview,
          textType: TextType.title,
          fontSize: context.getConditionalMainFont(),
          color: AppColors.primary,
        ),
        const Spacer(),
        _buildFavoriteButton(context, viewModel),
      ],
    );
  }

  /// ---------------- FAVORITE BUTTON ----------------
  Widget _buildFavoriteButton(BuildContext context, DiscoverViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.toggleFavorite();
        if (viewModel.isFavorited) {
          SnackbarUtil.showSuccessSnackBar(
            context,
            AppStrings.addedToFavorites,
          );
        } else {
          SnackbarUtil.showInfoSnackBar(
            context,
            AppStrings.removedFromFavorites,
          );
        }
      },
      child: Icon(
        viewModel.isFavorited ? Icons.favorite : Icons.favorite_border,
        color: viewModel.isFavorited ? AppColors.error : AppColors.primary,
      ),
    );
  }

  /// ---------------- GET READY TEXT ----------------
  Widget _buildGetReadyText() {
    return const ResponsiveTextWidget(
      AppStrings.getReady,
      textType: TextType.body,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    );
  }

  /// ---------------- ACTION TILES ----------------
  Widget _buildActionTiles(BuildContext context) {
    return Column(
      children: [
        ActionTile(
          iconPath: AppAssets.handicon,
          text: AppStrings.countMeInCatchYaAtLunaFest,
          onTap: () => _showShareLocationDialog(context),
        ),
        SizedBox(height: AppDimensions.spaceS),
        ActionTile(
          iconPath: AppAssets.iconcharcter,
          text: AppStrings.inviteYourFestieBestie,
          onTap: () => _shareFestival(context),
        ),
      ],
    );
  }

  /// ---------------- GRID OPTIONS ----------------
  Widget _buildGridOptions(BuildContext context, DiscoverViewModel viewModel) {
    return GridView.count(
      crossAxisCount: context.isLargeScreen ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppDimensions.spaceM,
      crossAxisSpacing: context.isLargeScreen ? AppDimensions.spaceL : AppDimensions.spaceM,
      childAspectRatio: context.isLargeScreen ? 1.3 : context.isMediumScreen ? 1.2 : 1.1,
      children: [
        GridOption(
          title: AppStrings.location,
          icon: AppAssets.mapicon,
          onNavigateToSub: onNavigateToSub,
        ),
        GridOption(
          title: AppStrings.chatRooms,
          icon: AppAssets.chaticon,
          onNavigateToSub: onNavigateToSub,
        ),
        GridOption(
          title: AppStrings.rumors,
          icon: AppAssets.rumors,
          onTap: () => viewModel.goToRumors(context),
        ),
        GridOption(
          title: AppStrings.detail,
          icon: AppAssets.detailicon,
          onNavigateToSub: onNavigateToSub,
        ),
      ],
    );
  }

  /// ---------------- HELPERS ----------------
  void _showShareLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ShareLocationPopup(),
    );
  }

  Future<void> _shareFestival(BuildContext context) async {
    await Share.share(
      AppStrings.shareMessage,
      subject: AppStrings.shareSubject,
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 0),
    );
  }
  Widget _divider(){
    return  Container(
      width: double.infinity,
      // Remove any outer spacing
      child: const Divider(
        color: AppColors.primary,
        thickness: 1,
        height: 20, // 👈 end at very right
      ),
    );
  }
}
/// ---------------- SHARE LOCATION POPUP ----------------
class ShareLocationPopup extends StatelessWidget {
  const ShareLocationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.onPrimary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: context.responsivePadding,
      child: Padding(
        padding: context.responsivePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCloseButton(context),
            const Icon(
              Icons.location_on,
              color: AppColors.accent,
              size: 60,
            ),
            SizedBox(height: AppDimensions.spaceS),
            _buildTitle(),
            SizedBox(height: context.getConditionalSpacing()),
            _buildShareButton(context),
            SizedBox(height: context.getConditionalSpacing()),
            _buildCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.close, color: AppColors.primary),
      ),
    );
  }

  Widget _buildTitle() {
    return const ResponsiveTextWidget(
      AppStrings.shareLocation,
      textType: TextType.body,
      color: AppColors.accent,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        SnackbarUtil.showSuccessSnackBar(
          context,
          AppStrings.locationSharingEnabled,
        );
      },
      child: Container(
        width: double.infinity,
        padding: context.responsivePadding,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const ResponsiveTextWidget(
          AppStrings.locationSharingDescription,
          textAlign: TextAlign.center,
          textType: TextType.body,
          color: AppColors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const ResponsiveTextWidget(
          AppStrings.hidingMyVibe,
          textAlign: TextAlign.center,
          textType: TextType.body,
          color: AppColors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
