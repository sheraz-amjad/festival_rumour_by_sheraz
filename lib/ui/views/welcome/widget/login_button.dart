import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final String iconPath; // SVG or PNG
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const LoginButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    required this.bgColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: Container(
          padding: const EdgeInsets.all(8),
          child: iconPath.endsWith(".svg")
              ? SvgPicture.asset(iconPath, height: 22, width: 22)
              : Image.asset(iconPath, height: 22, width: 22),
        ),
        label: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
