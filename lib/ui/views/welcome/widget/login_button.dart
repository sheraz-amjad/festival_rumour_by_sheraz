import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final String iconPath; // SVG or PNG asset path
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const LoginButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    required this.bgColor,
    this.textColor = AppColors.loginButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.loginButtonHeight,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.loginButtonBorderRadius),
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.loginButtonPadding),
        ),
        icon: _buildIcon(),
        label: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.loginButtonFontSize,
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.loginButtonIconPadding),
      child: iconPath.endsWith(".svg")
          ? SvgPicture.asset(
        iconPath,
        height: AppDimensions.loginButtonIconSize,
        width: AppDimensions.loginButtonIconSize,
      )
          : Image.asset(
        iconPath,
        height: AppDimensions.loginButtonIconSize,
        width: AppDimensions.loginButtonIconSize,
      ),
    );
  }
}
