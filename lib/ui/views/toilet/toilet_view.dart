import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/backbutton.dart';
import 'toilet_view_model.dart';

class ToiletView extends BaseView<ToiletViewModel> {
  const ToiletView({super.key});

  @override
  ToiletViewModel createViewModel() => ToiletViewModel();

  @override
  Widget buildView(BuildContext context, ToiletViewModel viewModel) {
    if (viewModel.showToiletDetail) {
      return _buildToiletDetail(context, viewModel);
    }
    
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Dark background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.bottomsheet),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                const SizedBox(height: AppDimensions.spaceL),
                Expanded(
                  child: _buildToiletList(context, viewModel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        children: [
          CustomBackButton(
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          const Text(
            'Toilets',
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppDimensions.textL,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToiletList(BuildContext context, ToiletViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      itemCount: viewModel.toilets.length,
      itemBuilder: (context, index) {
        final toilet = viewModel.toilets[index];
        return _buildToiletCard(context, toilet, viewModel);
      },
    );
  }

  Widget _buildToiletCard(BuildContext context, ToiletItem toilet, ToiletViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: AppColors.grey600,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Toilet image
          Container(
            width: 80,
            height: 80,
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              child: Container(
                child: Center(
                  child: Image.asset(
                    AppAssets.toilet1, // 👈 your custom icon path
                    width: AppDimensions.iconXXL,
                    height: AppDimensions.iconXXL,
                   // color: Colors.white, // optional if you want to tint the image
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          const SizedBox(width: AppDimensions.spaceM),
          
          // Toilet name
          Expanded(
            child: Text(
              toilet.name,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: AppDimensions.textL,
                //fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // View Detail button
          GestureDetector(
            onTap: () {
              viewModel.selectedToilet = toilet;
              viewModel.showToiletDetail = true;
              viewModel.notifyListeners();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingS,
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonYellow,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: const Text(
                'View Detail',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppDimensions.textM,
                  //fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildToiletDetail(BuildContext context, ToiletViewModel viewModel) {
    final toilet = viewModel.selectedToilet!;
    
    return Scaffold(

      body: Stack(
        children: [
          // Dark background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.bottomsheet),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildDetailAppBar(context, viewModel),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFestivalInformationSection1(context, toilet),
                        const SizedBox(height: AppDimensions.spaceXS),
                        _buildFestivalInformationSection2(context, toilet),
                       // const SizedBox(height: AppDimensions.spaceL),
                        _buildFestivalInformationSection3(context, toilet),
                       // const SizedBox(height: AppDimensions.spaceL),
                        _buildImageSection(context, toilet),
                       // const SizedBox(height: AppDimensions.spaceL),
                        _buildLocationSection(context, toilet),
                        const SizedBox(height: AppDimensions.spaceXS),
                        _buildLocationSection2(context, toilet),

                      ],
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

  Widget _buildDetailAppBar(BuildContext context, ToiletViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        children: [
          CustomBackButton(
            onTap: () {
              viewModel.showToiletDetail = false;
              viewModel.notifyListeners();
            },
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Text(
            viewModel.selectedToilet?.name ?? 'Toilet Detail',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: AppDimensions.textL,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalInformationSection1(BuildContext context, ToiletItem toilet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Text(
        'Festival Information', // 👈 your display text
        style: const TextStyle(
          color: Colors.white,       // or AppColors.primary if preferred
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center, // optional: center or left alignment
      ),
    );
  }

  Widget _buildFestivalInformationSection2(BuildContext context, ToiletItem toilet) {
    return _buildWhiteCard(
      context,
      '',
      Column(
        children: [
          _buildInfoRow(
            context,
            Icons.people,
            'Festival Name',
            'Magic show',
          ),
        ],
      ),
    );
  }


  Widget _buildFestivalInformationSection3(BuildContext context, ToiletItem toilet) {
    return _buildWhiteCard(
      context,
      '',
      Column(
        children: [
          _buildInfoRow(
            context,
            Icons.wc,
            'Toilet Category',
            'Magic show',
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, ToiletItem toilet) {
    return _buildWhiteCard(
      context,
      'Image',
      Container(
        height: 200,
        decoration: BoxDecoration(
          //color: toilet.color,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: Container(
            child: Center(
              child: Image.asset(
              AppAssets.toiletdetail, // 👈 your custom icon path
              // color: Colors.white, // optional if you want to tint the image
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context, ToiletItem toilet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Location',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: AppDimensions.textL,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle open map action
            },
            child: Row(
              children: [
                const Text(
                  'Open Map',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppDimensions.textS,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceS),
                const Icon(
                  Icons.map,
                  color: AppColors.primary,
                  size: AppDimensions.iconS,
                ),
              ],
            ),
          ),
        ],
      ),
      ],
    ),
    );
  }

  Widget _buildLocationSection2(BuildContext context, ToiletItem toilet) {
    return _buildWhiteCard(
      context,
      '',
      Column(
        children: [
          _buildInfoRow(
            context,
            Icons.location_on,
            'Latitude',
            'Lorem Ipsum',
          ),
          const SizedBox(height: AppDimensions.spaceM),
          _buildInfoRow(
            context,
            Icons.location_on,
            'Longitude',
            'Lorem Ipsum',
          ),
          const SizedBox(height: AppDimensions.spaceM),
          _buildInfoRow(
            context,
            Icons.location_on,
            'What3word',
            'Lorem Ipsum',
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteCard(BuildContext context, String title, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceL),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Only show title if not empty
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: const TextStyle(
                color: AppColors.grey600,
                fontSize: AppDimensions.textL,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.spaceM),
          ],
          content,
        ],
      ),
    );
  }


  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingS),
          decoration: BoxDecoration(
           // color: AppColors.grey600,
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Icon(
            icon,
            color: AppColors.grey600,
            size: AppDimensions.iconM,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.grey600,
                  fontSize: AppDimensions.textS,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceXS),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.grey600,
                  fontSize: AppDimensions.textM,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ToiletItem {
  final String name;
  final String description;
  final Color color;

  ToiletItem({
    required this.name,
    required this.description,
    required this.color,
  });
}
