# Responsive Design System

This document outlines the comprehensive responsive design system implemented across the Festival Rumour app to ensure optimal user experience across all device sizes.

## 🎯 **Design Philosophy**

The responsive system is built around **4 key breakpoints**:
- **Small Phones**: < 400px width
- **High-Resolution Phones**: 400-600px width (Pixel 6 Pro, iPhone Pro models)
- **Tablets**: 600-1200px width
- **Desktop**: > 1200px width

## 📱 **Breakpoint Detection**

### Context Extensions
```dart
// Available in any BuildContext
context.isSmallScreen        // < 400px
context.isHighResolutionPhone // 400-600px OR devicePixelRatio >= 3.0
context.isMediumScreen       // 600-1200px
context.isLargeScreen        // > 1200px
context.isHighResolutionPhone // Special detection for premium phones
```

## 🎨 **Responsive Components**

### 1. ResponsiveTextWidget
```dart
ResponsiveTextWidget(
  'Hello World',
  textType: TextType.heading,
  color: AppColors.primary,
  baseFontSize: 18, // Base size, automatically scaled
)
```

### 2. ResponsiveContainer
```dart
ResponsiveContainer(
  mobileMaxWidth: double.infinity,
  tabletMaxWidth: 800,
  desktopMaxWidth: 1200,
  child: YourWidget(),
)
```

### 3. ResponsiveButton
```dart
ResponsiveButton(
  onPressed: () {},
  backgroundColor: AppColors.primary,
  child: Text('Click Me'),
)
```

### 4. ResponsiveCard
```dart
ResponsiveCard(
  child: YourContent(),
)
```

### 5. ResponsiveLayout Helper
```dart
// Get responsive values
double spacing = ResponsiveLayout.getSpacing(context);
EdgeInsets padding = ResponsiveLayout.getPadding(context);
double iconSize = ResponsiveLayout.getIconSize(context);
```

## 📏 **Responsive Sizing Guidelines**

### Icon Sizes
- **Small Phones**: 20px
- **High-Res Phones**: 32px (Pixel 6 Pro optimized)
- **Tablets**: 32px
- **Desktop**: 48px

### Font Sizes
- **Small Phones**: Base size
- **High-Res Phones**: Base size × 1.15
- **Tablets**: Base size × 1.2
- **Desktop**: Base size × 1.3

### Spacing
- **Small Phones**: 8px
- **High-Res Phones**: 24px
- **Tablets**: 16px
- **Desktop**: 32px

### Padding
- **Small Phones**: 8px
- **High-Res Phones**: 16px
- **Tablets**: 16px
- **Desktop**: 24px

## 🎯 **High-Resolution Phone Optimization**

Special attention is given to high-resolution phones like:
- Google Pixel 6 Pro (411px width, 3.5x pixel ratio)
- iPhone Pro models
- Samsung Galaxy S series

These devices get:
- **Larger icons** (32px vs 24px)
- **Better spacing** (24px vs 8px)
- **Improved readability** (1.15x font scaling)
- **Enhanced touch targets**

## 🛠 **Implementation Examples**

### App Bar
```dart
Widget _buildAppBar(BuildContext context) {
  return ResponsivePadding(
    child: Row(
      children: [
        Icon(
          Icons.menu,
          size: ResponsiveLayout.getIconSize(context),
        ),
        SizedBox(width: ResponsiveLayout.getSpacing(context)),
        Expanded(
          child: ResponsiveTextWidget(
            'Title',
            textType: TextType.heading,
          ),
        ),
      ],
    ),
  );
}
```

### Navigation Bar
```dart
CustomNavBar(
  currentIndex: currentIndex,
  onTap: (index) => setState(() => currentIndex = index),
)
// Automatically responsive with larger icons and text on high-res phones
```

### Grid Layout
```dart
ResponsiveColumn(
  children: items.map((item) => ItemWidget(item)).toList(),
  smallColumns: 1,
  mediumColumns: 2,
  largeColumns: 3,
  highResColumns: 2, // Optimized for high-res phones
)
```

## 📱 **Device-Specific Optimizations**

### Google Pixel 6 Pro
- **Screen**: 411px width, 3.5x pixel ratio
- **Icons**: 32px (vs 24px standard)
- **Text**: 1.15x scaling
- **Spacing**: 24px (vs 8px standard)
- **Touch Targets**: 56px minimum height

### iPhone Pro Models
- **Screen**: 393px width, 3x pixel ratio
- **Icons**: 32px
- **Text**: 1.15x scaling
- **Spacing**: 24px
- **Touch Targets**: 56px minimum height

### Tablets
- **Screen**: 600-1200px width
- **Icons**: 32px
- **Text**: 1.2x scaling
- **Spacing**: 16px
- **Layout**: Multi-column support

### Desktop
- **Screen**: > 1200px width
- **Icons**: 48px
- **Text**: 1.3x scaling
- **Spacing**: 32px
- **Layout**: Maximum 1200px container width

## 🎨 **Best Practices**

1. **Always use responsive components** instead of fixed sizes
2. **Test on multiple device sizes** during development
3. **Use semantic sizing** (small, medium, large) rather than pixel values
4. **Consider touch targets** - minimum 44px for mobile
5. **Optimize for high-resolution phones** - they need larger elements
6. **Use consistent spacing** through the responsive system
7. **Test text readability** on all screen sizes

## 🔧 **Migration Guide**

### From Fixed Sizes to Responsive
```dart
// Before
Container(
  padding: EdgeInsets.all(16),
  child: Icon(Icons.home, size: 24),
)

// After
ResponsiveContainer(
  child: Icon(
    Icons.home,
    size: ResponsiveLayout.getIconSize(context),
  ),
)
```

### From Fixed Text to Responsive Text
```dart
// Before
Text(
  'Hello',
  style: TextStyle(fontSize: 16),
)

// After
ResponsiveTextWidget(
  'Hello',
  textType: TextType.body,
  baseFontSize: 16,
)
```

## 📊 **Performance Considerations**

- **Context extensions** are cached and performant
- **Responsive calculations** are done once per build
- **No unnecessary rebuilds** with proper widget structure
- **Efficient breakpoint detection** using screen width and pixel ratio

## 🧪 **Testing**

Test your responsive design on:
1. **Small phones** (< 400px)
2. **High-resolution phones** (400-600px, high pixel ratio)
3. **Tablets** (600-1200px)
4. **Desktop** (> 1200px)

Use Flutter's device preview or test on actual devices for best results.

## 📚 **Resources**

- [Flutter Responsive Design](https://flutter.dev/docs/development/ui/layout/responsive)
- [Material Design Breakpoints](https://material.io/design/layout/responsive-layout-grid.html)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

---

**Note**: This responsive system is designed to provide the best user experience across all devices, with special optimization for high-resolution phones like the Google Pixel 6 Pro.
