# Responsive Text System - MVVM Architecture

This document explains how to use the responsive text system that follows MVVM architecture principles.

## 🏗️ Architecture Overview

The responsive text system consists of:

1. **ResponsiveTextService** - Service layer that handles responsive text logic
2. **ResponsiveText Widget** - View layer that consumes the service
3. **TextType Enum** - Model layer that defines text categories

## 📱 Usage Examples

### Basic Responsive Text

```dart
// Instead of hard-coded TextStyle
Text(
  "Hello World",
  style: TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
)

// Use ResponsiveText with MVVM structure
ResponsiveText(
  "Hello World",
  textType: TextType.body,
  color: Colors.black,
  baseFontSize: 16,
  fontWeight: FontWeight.bold,
)
```

### Text Types Available

```dart
enum TextType {
  heading,    // Large headings
  body,       // Regular body text
  label,      // Form labels
  button,     // Button text
  caption,    // Small captions
  title,      // Section titles
  subtitle,   // Subtitles
  error,      // Error messages
  success,    // Success messages
  accent,     // Accent text
  primary,    // Primary text
  secondary,  // Secondary text
  white,      // White text
  grey,       // Grey text
}
```

### Responsive Scaling

The system automatically scales text based on screen size:

- **Mobile** (< 600px): Base font size
- **Tablet** (600px - 1200px): Base font size × 1.1
- **Desktop** (> 1200px): Base font size × 1.2

### Advanced Usage

```dart
// Custom responsive text with all options
ResponsiveText(
  "Custom Text",
  textType: TextType.heading,
  color: AppColors.primary,
  fontWeight: FontWeight.bold,
  baseFontSize: 24,
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)

// Rich text with multiple styles
ResponsiveRichText(
  children: [
    ResponsiveTextSpan(
      text: "Hello ",
      textType: TextType.body,
      color: Colors.black,
    ),
    ResponsiveTextSpan(
      text: "World",
      textType: TextType.accent,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
  ],
)
```

### Service Layer Usage

```dart
// Direct service usage (for custom implementations)
final responsiveService = ResponsiveTextService.instance;

final headingStyle = responsiveService.getHeadingStyle(
  context,
  color: AppColors.primary,
  fontWeight: FontWeight.bold,
  baseFontSize: 24,
);

final bodyStyle = responsiveService.getBodyStyle(
  context,
  color: AppColors.onSurface,
  baseFontSize: 16,
);
```

## 🎯 Benefits

1. **Consistent Scaling**: All text scales uniformly across devices
2. **MVVM Architecture**: Clean separation of concerns
3. **Type Safety**: Enum-based text types prevent errors
4. **Maintainable**: Centralized text styling logic
5. **Responsive**: Automatic adaptation to screen sizes
6. **Theme Integration**: Works with app theme system

## 🔄 Migration Guide

### Before (Hard-coded styles)
```dart
Text(
  "Title",
  style: TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
)
```

### After (Responsive MVVM)
```dart
ResponsiveText(
  "Title",
  textType: TextType.title,
  color: Colors.black,
  baseFontSize: 20,
  fontWeight: FontWeight.bold,
)
```

## 📋 Best Practices

1. **Use appropriate TextType**: Choose the right text type for your content
2. **Set baseFontSize**: Always specify a base font size
3. **Use theme colors**: Prefer AppColors over hard-coded colors
4. **Consistent spacing**: Use responsive spacing with text
5. **Test on all devices**: Verify scaling on mobile, tablet, and desktop

## 🚀 Future Enhancements

- Dark mode text color variants
- Accessibility text scaling
- Custom font family support
- Animation support for text changes
- Localization integration
