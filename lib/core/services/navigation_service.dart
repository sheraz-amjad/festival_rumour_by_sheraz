import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to a new screen
  Future<T?> navigateTo<T extends Object?>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate to a new screen and replace current
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
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
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// Pop current screen
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  /// Pop until specific route
  void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState!.popUntil(predicate);
  }

  /// Check if can pop
  bool get canPop => navigatorKey.currentState!.canPop();

  /// Navigate to home and clear stack
  Future<T?> navigateToHome<T extends Object?>() {
    return pushNamedAndRemoveUntil<T>('/home', (route) => false);
  }

  /// Navigate to login and clear stack
  Future<T?> navigateToLogin<T extends Object?>() {
    return pushNamedAndRemoveUntil<T>('/welcome', (route) => false);
  }
}




