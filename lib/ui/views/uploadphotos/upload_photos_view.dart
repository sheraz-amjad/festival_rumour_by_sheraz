import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
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
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
          ResponsiveContainer(
          mobileMaxWidth: double.infinity,
          tabletMaxWidth: double.infinity,
          desktopMaxWidth: double.infinity,
          child: Container(
            padding:
                context.isLargeScreen
                    ? const EdgeInsets.symmetric(horizontal: 40, vertical: 40)
                    : context.isMediumScreen
                    ? const EdgeInsets.symmetric(horizontal: 30, vertical: 35)
                    : const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.addpic),
                fit: BoxFit.cover,
              ),
             // borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button
                _buildHeader(context),
                const SizedBox(height: AppDimensions.paddingL),

                // Title and subtitle
                _buildTitleSection(context),
                const SizedBox(height: AppDimensions.paddingXL),

                // Image container
                Expanded(child: _buildImageContainer(context, viewModel)),

                const SizedBox(height: AppDimensions.paddingL),

                // Action buttons
                _buildActionButtons(context, viewModel),
              ],
            ),
          ),
        ),
      ]
          ),
    ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CustomBackButton(onTap: () => context.pop()),
        const SizedBox(width: AppDimensions.spaceS),
        ResponsiveText(
          AppStrings.uploadphoto,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
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
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceS),

        ResponsiveText(
          AppStrings.uploadSubtitle,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(
    BuildContext context,
    UploadPhotosViewModel viewModel,
  ) {
    return GestureDetector(
      onTap: () => _showImageSourceFullScreen(context, viewModel),
      child: Stack(
        clipBehavior: Clip.none, // allow circle to be outside
        children: [
          Card(
            color: AppColors.onPrimary.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            ),
            elevation: AppDimensions.elevationS,
            child: DottedBorder(
              color: AppColors.accent,
              strokeWidth: 5,
              borderType: BorderType.RRect,
              radius: Radius.circular(AppDimensions.radiusL),
              dashPattern: const [12, 3],
              child: Container(
               // color: AppColors.onPrimary.withOpacity(0.3),
                width: double.infinity,
                height:
                    490, // ✅ fixed height (same whether empty or with image)
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                   color: AppColors.onPrimary.withOpacity(0.4),
                   // 🔥 light layer background
                  //color: Colors.black.withOpacity(0.9),
                ),
                child:
                    viewModel.hasImage
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusL,
                          ),
                          child: kIsWeb
                              ? Image.network(
                                  viewModel.selectedImage!.path,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Image.file(
                                  File(viewModel.selectedImage!.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                        )
                        : null, // no shrink, just background stays
              ),
            ),
          ),
          // Plus circle outside (bottom right)
          Positioned(
            bottom: -22,
            right: -22,
            child: Container(
              padding: const EdgeInsets.all(2), // border thickness
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary, // white border
                  width: 3, // thickness
                ),
                color: AppColors.onPrimary,
              ),
              child: Icon(Icons.add, color: AppColors.primary, size: 55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    UploadPhotosViewModel viewModel,
  ) {
    return Column(
      children: [
        // Next button
        SizedBox(
          width: double.infinity,
          height: AppDimensions.buttonHeightXL,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  viewModel.hasImage ? AppColors.accent : AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
              ),
            ),
            onPressed:
                viewModel.hasImage && !viewModel.isLoading
                    ? viewModel.continueToNext
                    : null,
            child:
                viewModel.isLoading
                    ? const SizedBox(
                      width: AppDimensions.iconS,
                      height: AppDimensions.iconS,
                      child: CircularProgressIndicator(
                        color: AppColors.accent,
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

        // Skip button
      ],
    );
  }

  void _showImageSourceFullScreen(
    BuildContext context,
    UploadPhotosViewModel viewModel,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    // ✅ Background image (PNG/JPG)
                    Positioned.fill(
                      child: Image.asset(
                        AppAssets.uploadphoto, // must be PNG/JPG
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),

                    // ✅ Custom AppBar inside Stack
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
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

                            const SizedBox(
                              width: 48,
                            ), // spacer to balance the back button
                          ],
                        ),
                      ),
                    ),

                    // ✅ Foreground content
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double width = constraints.maxWidth;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width < 600 ? 20 : 40,
                            vertical:
                                width < 600
                                    ? 80
                                    : 100, // ⬅ leave space for custom appbar
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),

                              // 📸 Camera Option
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
                                        // color: AppColors.onPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text(
                                      AppStrings.camera,
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),
                              const Divider(
                                color: AppColors.accent,
                                thickness: 1.5,
                              ),
                              const SizedBox(height: 20),

                              // 🖼️ Gallery Option
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
                                        // color: AppColors.onPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text(
                                      AppStrings.gallery,
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
