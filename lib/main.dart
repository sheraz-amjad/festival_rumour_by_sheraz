import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/di/locator.dart';
import 'core/services/navigation_service.dart';

/// Main entry point of the Festival Rumour application
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  await setupLocator();
  
  // Set preferred orientations (portrait only for mobile experience)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  
  runApp(const FestivalRumourApp());
}

/// Main application widget with MVVM architecture
class FestivalRumourApp extends StatelessWidget {
  const FestivalRumourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App Configuration
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      

      
      // Routing Configuration
      initialRoute: AppRoutes.splash,
      onGenerateRoute: onGenerateRoute,
      
      // Navigation Configuration
      navigatorKey: locator<NavigationService>().navigatorKey,
      
      // Builder for additional configuration
      builder: (context, child) {
        return MediaQuery(
          // Prevent text scaling beyond reasonable limits
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
