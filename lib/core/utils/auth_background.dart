import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_strings.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background Image
        SizedBox(
          width: double.infinity,
          height: 900,
          child: Image.asset(
            AppAssets.background,
            fit: BoxFit.cover,
          ),
        ),

        /// Black Overlay
        Container(
          width: double.infinity,
          height: 800,
          color: Colors.black.withOpacity(0.4), // change opacity as needed
        ),

        /// Logo + Welcome text
        SizedBox(
          width: double.infinity,
          height: 553,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: SvgPicture.asset(
                    AppAssets.logoPng,
                    color: Colors.white,
                    height: 180,
                  ),
                ),
              ),
              const Positioned(
                top: 277,
                left: 43,
                right: 43,
                child: Column(
                  children: [
                    Text(
                      AppStrings.welcome,
                      style: TextStyle(
                        fontFamily: 'Helix',
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      AppStrings.FestivalRumour,
                      style: TextStyle(
                        fontFamily: 'Helix',
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
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
  }
}
