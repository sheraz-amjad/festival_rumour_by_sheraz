# MVVM Architecture Implementation

This document outlines the MVVM (Model-View-ViewModel) architecture implementation in the Festival Rumour Flutter application, based on the tour_guide project structure.

## Architecture Overview

The application follows a clean MVVM architecture with the following layers:

```
lib/
├── core/                    # Core functionality
│   ├── constants/           # App constants (colors, sizes, strings)
│   ├── di/                 # Dependency injection
│   ├── router/             # Navigation routing
│   ├── services/           # Business services
│   ├── theme/              # App theming
│   ├── utils/              # Utility classes
│   └── viewmodels/         # Base ViewModel
├── data/                    # Data layer
│   └── repositories/       # Repository implementations
├── domain/                  # Domain layer
│   ├── models/            # Domain models
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Business use cases
├── shared/                  # Shared components
│   ├── extensions/        # Dart extensions
│   └── widgets/           # Reusable widgets
└── ui/                     # Presentation layer
    └── views/             # Views and ViewModels
```

## Core Components

### 1. BaseViewModel

The `BaseViewModel` class provides common functionality for all ViewModels:

```dart
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDisposed = false;
  String? _errorMessage;

  // Loading state management
  bool get isLoading => _isLoading;
  void setLoading(bool loading);

  // Error handling
  String? get errorMessage => _errorMessage;
  void setError(String? error);
  void clearError();

  // Async operation handling
  Future<T?> handleAsync<T>(
    Future<T> Function() operation, {
    bool showLoading = true,
    String? errorMessage,
    void Function(String error)? onError,
  });

  // Lifecycle methods
  void init();
  void onDispose();
}
```

### 2. BaseView

The `BaseView` class provides common functionality for all Views:

```dart
abstract class BaseView<T extends BaseViewModel> extends StatefulWidget {
  T createViewModel();
  Widget buildView(BuildContext context, T viewModel);
  void onViewModelReady(T viewModel);
  void onError(BuildContext context, String error);
}
```

### 3. Responsive Design

The application includes comprehensive responsive design patterns:

#### Context Extensions
```dart
extension ContextExtensions on BuildContext {
  // Screen information
  Size get screenSize;
  double get screenWidth;
  double get screenHeight;
  
  // Device type detection
  bool get isTablet;
  bool get isPhone;
  bool get isLandscape;
  bool get isPortrait;
  
  // Responsive utilities
  double widthPercent(double percent);
  double heightPercent(double percent);
  double sizePercent(double percent);
  
  // Responsive breakpoints
  bool get isSmallScreen;
  bool get isMediumScreen;
  bool get isLargeScreen;
}
```

#### Responsive Widgets
- `ResponsiveWidget`: Adapts layout based on screen size
- `ResponsiveBuilder`: Provides different widgets based on constraints
- `ResponsiveGrid`: Responsive grid layout
- `ResponsivePadding`: Adaptive padding
- `ResponsiveText`: Adaptive text sizing
- `ResponsiveContainer`: Adaptive container constraints

### 4. App Constants

#### AppDimensions
```dart
class AppDimensions {
  // Padding and Margins
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  
  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  
  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;
  
  // Screen Breakpoints
  static const double mobileBreakpoint = 480.0;
  static const double tabletBreakpoint = 768.0;
  static const double desktopBreakpoint = 1024.0;
}
```

#### AppColors
```dart
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF003C32);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF4DD6B1);
  static const Color onPrimaryContainer = Color(0xFF002019);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFDABE79);
  static const Color onSecondary = Color(0xFF000000);
  static const Color secondaryContainer = Color(0xFFFFF1D0);
  static const Color onSecondaryContainer = Color(0xFF2B2000);
  
  // Tertiary Colors
  static const Color tertiary = Color(0xFFF3EFE8);
  static const Color onTertiary = Color(0xFF000000);
  static const Color tertiaryContainer = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFF2A2620);
}
```

### 5. App Theme

The application includes comprehensive theming with light and dark modes:

```dart
class AppTheme {
  static ThemeData get lightTheme;
  static ThemeData get darkTheme;
}
```

## Usage Examples

### Creating a ViewModel

```dart
class HomeViewModel extends BaseViewModel {
  List<PostModel> posts = [];

  @override
  void init() {
    super.init();
    loadPosts();
  }

  Future<void> loadPosts() async {
    await handleAsync(() async {
      // API call logic
      posts = await _repository.getPosts();
    }, errorMessage: 'Failed to load posts');
  }

  void likePost(int index) {
    if (index < posts.length) {
      posts[index] = posts[index].copyWith(
        likes: posts[index].likes + 1,
      );
      notifyListeners();
    }
  }
}
```

### Creating a View

```dart
class HomeView extends BaseView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel createViewModel() => HomeViewModel();

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: ResponsivePadding(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildSearchBar(context),
            Expanded(
              child: _buildFeedList(context, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedList(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isLoading && viewModel.posts.isEmpty) {
      return const LoadingWidget(message: 'Loading posts...');
    }

    return RefreshIndicator(
      onRefresh: viewModel.refreshPosts,
      child: ListView.builder(
        itemCount: viewModel.posts.length,
        itemBuilder: (context, index) {
          final post = viewModel.posts[index];
          return PostWidget(
            post: post,
            onLike: () => viewModel.likePost(index),
          );
        },
      ),
    );
  }
}
```

### Using Responsive Design

```dart
// Responsive layout
ResponsiveWidget(
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
)

// Responsive padding
ResponsivePadding(
  mobilePadding: EdgeInsets.all(16),
  tabletPadding: EdgeInsets.all(24),
  desktopPadding: EdgeInsets.all(32),
  child: ContentWidget(),
)

// Responsive text
ResponsiveText(
  "Hello World",
  style: TextStyle(fontSize: 16),
)

// Responsive grid
ResponsiveGrid(
  children: items,
  mobileColumns: 2,
  tabletColumns: 3,
  desktopColumns: 4,
)
```

## Dependency Injection

The application uses GetIt for dependency injection:

```dart
final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  
  // Repositories
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator<AuthService>()));
  
  // Use cases
  locator.registerFactory<SignInWithGoogle>(() => SignInWithGoogle(locator<AuthRepository>()));
}
```

## Best Practices

### 1. ViewModel Guidelines
- Always extend `BaseViewModel`
- Use `handleAsync()` for async operations
- Implement proper error handling
- Use `notifyListeners()` for state changes
- Override `init()` for initialization logic
- Override `onDispose()` for cleanup

### 2. View Guidelines
- Always extend `BaseView<T>`
- Implement `createViewModel()` and `buildView()`
- Use responsive widgets for layout
- Handle loading and error states
- Use proper naming conventions for helper methods

### 3. Responsive Design Guidelines
- Use `AppDimensions` for consistent spacing
- Use `AppColors` for consistent colors
- Use responsive widgets for adaptive layouts
- Test on different screen sizes
- Use context extensions for screen information

### 4. Error Handling
- Use `handleAsync()` for automatic error handling
- Provide meaningful error messages
- Show user-friendly error messages
- Log errors for debugging

### 5. Loading States
- Use `setLoading()` for loading states
- Show loading indicators appropriately
- Handle empty states
- Provide refresh functionality

## Migration from Old Structure

To migrate existing views to the new MVVM structure:

1. **Update ViewModel**: Change from `ChangeNotifier` to `BaseViewModel`
2. **Update View**: Change from `StatelessWidget` to `BaseView<T>`
3. **Remove Provider**: Remove `ChangeNotifierProvider` and `Consumer`
4. **Add Responsive Design**: Use responsive widgets and constants
5. **Update Dependencies**: Use the new dependency injection setup

## Benefits

1. **Consistency**: Standardized architecture across the app
2. **Maintainability**: Clear separation of concerns
3. **Testability**: Easy to unit test ViewModels
4. **Responsiveness**: Adaptive design for all screen sizes
5. **Error Handling**: Centralized error management
6. **Loading States**: Consistent loading state management
7. **Code Reusability**: Shared components and utilities
8. **Performance**: Optimized rendering and state management

This architecture provides a solid foundation for building scalable, maintainable, and responsive Flutter applications.
