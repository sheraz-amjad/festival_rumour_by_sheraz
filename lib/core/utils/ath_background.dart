// lib/core/utils/auth_background.dart
import 'package:festival_rumour/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AutBackground extends StatelessWidget {
  const AutBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          // background image
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.background,
              fit: BoxFit.cover,
            ),
          ),

          // small top-left circle (like your mock)
          const Positioned(
            left: 16,
            top: 16,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white70,
            ),
          ),

          // logo + title
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.logoPng),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
