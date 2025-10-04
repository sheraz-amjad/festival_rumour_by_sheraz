import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/backbutton.dart';
import '../../../shared/widgets/responsive_widget.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'upload_photos_view_model.dart';

class UploadPhotosViews extends BaseView<UploadPhotosViewModel> {
  const UploadPhotosViews({super.key});

  @override
  UploadPhotosViewModel createViewModel() => UploadPhotosViewModel();

  @override
  Widget buildView(BuildContext context, UploadPhotosViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true, // 👈 allows background behind status bar
      body: Stack(
        children: [
          /// 🔹 Background image covers whole screen, even status bar
          const Positioned.fill(
            child: Image(
              image: AssetImage(AppAssets.addpic),
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Foreground content inside SafeArea
          SafeArea(
            child: ResponsiveContainer(
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: 600,
              desktopMaxWidth: 900,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth < 600
                      ? 20
                      : screenWidth < 900
                      ? 40
                      : 60,
                  vertical: screenWidth < 600
                      ? 25
                      : screenWidth < 900
                      ? 35
                      : 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: AppDimensions.paddingL),
                    _buildTitleSection(context),
                    const SizedBox(height: AppDimensions.paddingXL),
                    Expanded(child: _buildImageContainer(context, viewModel)),
                    const SizedBox(height: AppDimensions.paddingL),
                    _buildActionButtons(context, viewModel),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CustomBackButton(onTap: () => context.pop()),
        const SizedBox(width: AppDimensions.spaceS),
        Flexible(
          child: ResponsiveText(
            AppStrings.uploadphoto,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          AppStrings.picupload,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        ResponsiveText(
          AppStrings.uploadSubtitle,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(
      BuildContext context, UploadPhotosViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    double containerHeight;
    if (screenWidth < 600) {
      containerHeight = 430;
    } else if (screenWidth < 900) {
      containerHeight = 450;
    } else {
      containerHeight = 480;
    }

    return GestureDetector(
      onTap: () => _showImageSourceFullScreen(context, viewModel),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            ),
            elevation: AppDimensions.elevationS,
            child: DottedBorder(
              color: AppColors.accent,
              strokeWidth: 3,
              borderType: BorderType.RRect,
              radius: const Radius.circular(AppDimensions.radiusL),
              dashPattern: const [10, 4],
              child: Container(
                width: double.infinity,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: AppColors.lightBlack,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                ),
                child: viewModel.hasImage
                    ? ClipRRect(
                  borderRadius:
                  BorderRadius.circular(AppDimensions.radiusL),
                  child: Image.file(
                    File(viewModel.selectedImage!.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
                    : null,
              ),
            ),
          ),
          Positioned(
            bottom: -7,
            right: -22,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 3),
                color: AppColors.onPrimary,
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.primary,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, UploadPhotosViewModel viewModel) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: viewModel.hasImage
          ? Column(
        key: const ValueKey('nextButtonVisible'),
        children: [
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeightXL,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(AppDimensions.radiusXL),
                ),
              ),
              onPressed: !viewModel.isLoading
                  ? viewModel.continueToNext
                  : null,
              child: viewModel.isLoading
                  ? const SizedBox(
                width: AppDimensions.iconM,
                height: AppDimensions.iconM,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                AppStrings.next,
                style: TextStyle(
                  fontSize: AppDimensions.textXL,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),
        ],
      )
          : SizedBox(
        key: const ValueKey('nextButtonHidden'),
        height: AppDimensions.buttonHeightXL + AppDimensions.spaceM,
      ),
    );
  }


  void _showImageSourceFullScreen(
      BuildContext context,
      UploadPhotosViewModel viewModel,
      ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;

                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        AppAssets.uploadphoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    // Responsive app bar
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 12 : 24,
                          vertical: isMobile ? 10 : 16,
                        ),
                        color: AppColors.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackButton(
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            const Text(
                              AppStrings.selectsourse,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onPrimary,
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                      ),
                    ),
                    // Foreground options
                    Padding(
                      padding: EdgeInsets.only(
                        top: isMobile ? 120 : 160,
                        left: isMobile ? 20 : 40,
                        right: isMobile ? 20 : 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await viewModel.pickImageFromCamera();
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  child: SvgPicture.asset(
                                    AppAssets.camera,
                                    width: AppDimensions.iconXXL,
                                    height: AppDimensions.iconXXL,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Text(
                                  AppStrings.camera,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: AppColors.accent, thickness: 1.5),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              await viewModel.pickImageFromGallery();
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  child: SvgPicture.asset(
                                    AppAssets.gallary,
                                    width: AppDimensions.iconXXL,
                                    height: AppDimensions.iconXXL,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Text(
                                  AppStrings.gallery,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
