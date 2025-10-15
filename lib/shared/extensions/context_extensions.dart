import 'package:flutter/material.dart';

/// Extension methods for BuildContext to provide easy access to common properties
extension ContextExtensions on BuildContext {
  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get media query data
  MediaQueryData? get mediaQuery => MediaQuery.maybeOf(this);

  /// Get screen size
  Size get screenSize => mediaQuery?.size ?? const Size(0, 0);

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Get device pixel ratio
  double get devicePixelRatio => mediaQuery?.devicePixelRatio ?? 1.0;

  /// Get status bar height
  double get statusBarHeight => mediaQuery?.padding.top ?? 0.0;

  /// Get bottom safe area height
  double get bottomSafeArea => mediaQuery?.padding.bottom ?? 0.0;

  /// Get keyboard height
  double get keyboardHeight => mediaQuery?.viewInsets.bottom ?? 0.0;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => keyboardHeight > 0;

  /// Check if device is in landscape mode
  bool get isLandscape => mediaQuery?.orientation == Orientation.landscape;

  /// Check if device is in portrait mode
  bool get isPortrait => mediaQuery?.orientation == Orientation.portrait;

  /// Check if device is a tablet (width > 600)
  bool get isTablet => screenWidth > 600;

  /// Check if device is a phone
  bool get isPhone => !isTablet;

  /// Check if device is in dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if device is in light mode
  bool get isLightMode => theme.brightness == Brightness.light;

  /// Get responsive width based on percentage
  double widthPercent(double percent) => screenWidth * (percent / 100);

  /// Get responsive height based on percentage
  double heightPercent(double percent) => screenHeight * (percent / 100);

  /// Get responsive size (minimum of width and height percentage)
  double sizePercent(double percent) {
    final w = widthPercent(percent);
    final h = heightPercent(percent);
    return w < h ? w : h;
  }

  /// Show a snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textColor != null ? TextStyle(color: textColor) : null,
        ),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        action: action,
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Show warning snackbar
  void showWarningSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  /// Show info snackbar
  void showInfoSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  /// Navigate to a new screen
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate to a new screen and replace current
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Navigate to a new screen and clear stack
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// Pop current screen
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// Pop until specific route
  void popUntil(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// Check if can pop
  bool get canPop => Navigator.of(this).canPop();

  /// Show loading dialog
  void showLoadingDialog({String? message}) {
    showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(message),
            ],
          ],
        ),
      ),
    );
  }

  /// Hide loading dialog
  void hideLoadingDialog() {
    Navigator.of(this).pop();
  }

  /// Show confirmation dialog
  Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: confirmColor != null
                ? TextButton.styleFrom(foregroundColor: confirmColor)
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Show alert dialog
  Future<void> showAlertDialog({
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog<void>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  /// Show bottom sheet
  Future<T?> showCustomBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
    );
  }

  /// Get localization
  // Localizations get localizations => Localizations.of(this);

  /// Focus/unfocus
  void requestFocus(FocusNode focusNode) {
    FocusScope.of(this).requestFocus(focusNode);
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  /// Check if specific focus node has focus
  bool hasFocus(FocusNode focusNode) {
    return FocusScope.of(this).focusedChild == focusNode;
  }

  /// Get primary focus
  FocusNode? get primaryFocus => FocusScope.of(this).focusedChild;

  /// Responsive breakpoints - optimized for high-resolution phones
  bool get isSmallScreen => screenWidth < 400;
  bool get isHighResPhone => screenWidth >= 400 && screenWidth < 600;
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 1200;
  bool get isLargeScreen => screenWidth >= 1200;
  
  /// Check if device is a high-resolution phone (like Pixel 6 Pro, iPhone Pro models)
  bool get isHighResolutionPhone => (screenWidth >= 400 && screenWidth < 600) || devicePixelRatio >= 3.0;

  /// Get responsive padding
  EdgeInsets get responsivePadding {
    if (isSmallScreen) {
      return const EdgeInsets.all(16);
    } else if (isMediumScreen) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(32);
    }
  }

  /// Get responsive margin
  EdgeInsets get responsiveMargin {
    if (isSmallScreen) {
      return const EdgeInsets.all(8);
    } else if (isMediumScreen) {
      return const EdgeInsets.all(16);
    } else {
      return const EdgeInsets.all(24);
    }
  }

  /// Get app bar height
  double get appBarHeight => AppBar().preferredSize.height;

  /// Get total app bar height (including status bar)
  double get totalAppBarHeight => appBarHeight + statusBarHeight;

  /// Get available screen height (excluding app bar and status bar)
  double get availableScreenHeight => screenHeight - totalAppBarHeight;

  /// Get safe area height
  double get safeAreaHeight => screenHeight - statusBarHeight - bottomSafeArea;
}
