import 'package:flutter/material.dart';

/// App color constants with Primary = White, Secondary = Black, Accent = Yellow
class AppColors {
  AppColors._();

  // Primary Colors (White theme base)
  static const Color primary = Color(0xFFFFFFFF);        // White
  static const Color onPrimary = Color(0xFF000000);      // Black text/icons on white
  static const Color primaryContainer = Color(0xFFF5F5F5); // Light grey container
  static const Color onPrimaryContainer = Color(0xFF000000);

  // Accent Colors
  static const Color accent = Color(0xFFFECD00);         // Yellow for buttons/highlights
  static const Color gradientStart = Color(0xFFFFFFFF);  // White
  static const Color gradientEnd = Color(0xFF000000);    // Black

  static const LinearGradient mainGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Secondary Colors (Black theme base)
  static const Color secondary = Color(0xFF000000);        // Black
  static const Color onSecondary = Color(0xFFFFFFFF);      // White text/icons on black
  static const Color secondaryContainer = Color(0xFF212121); // Dark grey container
  static const Color onSecondaryContainer = Color(0xFFFFFFFF);

  // Tertiary Colors (Greyscale for contrast)
  static const Color tertiary = Color(0xFFE0E0E0);         // Light grey
  static const Color onTertiary = Color(0xFF000000);       // Black for contrast
  static const Color tertiaryContainer = Color(0xFF9E9E9E); // Mid grey
  static const Color onTertiaryContainer = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF2F2F2);
  static const Color mutedText = Color(0xFF9B9B9B);
  static const Color lightBlack = Color(0xFF212121);

  // Error Colors
  static const Color error = Color(0xFFB00020);  // Material red
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFCD8DF);
  static const Color onErrorContainer = Color(0xFF370617);


  //Add ME
  //static const Color background = Colors.black;
  static const Color textPrimary = Colors.white;
  static const Color borderPrimary = Colors.white;
  static const Color buttonPrimary = Color(0xFFF3B126); // Yellow tone
  static const Color buttonText = Colors.white;
  static const Color iconPrimary = Colors.white;
  static const Color closeButtonBg = Color(0xFFD6D6D6);
  static const Color closeButtonIcon = Colors.black;
  static const Color overlay = Colors.black45;
  static const Color loginButtonText = Colors.white;


  static const Color postBackground = Colors.black;
  static const Color postShadow = Colors.grey;
  static const Color reactionLike = Colors.red;
  static const Color reactionLove = Colors.blue;
  static const Color proLabelBackground = Colors.orange;
  static const Color proLabelText = Colors.white;
  static const Color eventOverlay = Colors.black54;
  static const Color nowBadge = Colors.black;
  static const Color iconBackground = Colors.grey;
  static const Color iconColor = Colors.black;
  static const Color headlineBackground = Colors.black54;
  static const Color overlayBlack = Colors.black;
  static const Color headingColor = Colors.white;
  static const Color subHeadingColor = Colors.white70;

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);        // White surface
  static const Color onSurface = Color(0xFF000000);      // Black text
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Light grey variant
  static const Color onSurfaceVariant = Color(0xFF616161);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);     // White background
  static const Color onBackground = Color(0xFF000000);   // Black text

  // Outline Colors
  static const Color outline = Color(0xFF9E9E9E);
  static const Color outlineVariant = Color(0xFFBDBDBD);

  // Shadow and Scrim
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  // Custom App Colors
  static const Color success = Color(0xFF4CAF50);  // Green
  static const Color warning = Color(0xFFFF9800);  // Orange
  static const Color info = Color(0xFF2196F3);     // Blue
  static const Color buttonYellow = Color(0xFFFECD00); // Yellow for buttons

  // Neutral Greys
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [white, black],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [white, grey100],
  );
}
