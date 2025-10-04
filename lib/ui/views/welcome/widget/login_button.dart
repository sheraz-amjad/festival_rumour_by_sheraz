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
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(AppDimensions.loginButtonBorderRadius),
          ),
          elevation: 2,
          padding: EdgeInsets.zero,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🔹 Centered Text
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.loginButtonFontSize,
              ),
            ),

            // 🔹 Left Circular Icon
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                const EdgeInsets.only(left: AppDimensions.loginButtonPadding),
                child: _buildCircularIcon(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularIcon() {
    final double iconSize = AppDimensions.loginButtonIconSize;

    return Container(
      height: iconSize + 10,
      width: iconSize + 10,
      decoration: BoxDecoration(
        color: Colors.white, // background color for circle
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white, // white border
          width: 1.5,
        ),
      ),
      child: Center(
        child: iconPath.endsWith(".svg")
            ? SvgPicture.asset(iconPath, height: iconSize, width: iconSize)
            : Image.asset(iconPath, height: iconSize, width: iconSize),
      ),
    );
  }
}
