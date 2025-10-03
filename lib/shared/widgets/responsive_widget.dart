import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../../core/constants/app_sizes.dart';

/// Responsive widget that adapts its layout based on screen size
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isLargeScreen && desktop != null) {
      return desktop!;
    } else if (context.isMediumScreen && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

/// Responsive builder that provides different widgets based on screen size
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints) builder;

  const ResponsiveBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, constraints);
      },
    );
  }
}

/// Responsive grid that adapts columns based on screen size
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int columns = _getColumns(context);
    
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: children.map((child) {
        return SizedBox(
          width: (context.screenWidth - (spacing * (columns - 1))) / columns,
          child: child,
        );
      }).toList(),
    );
  }

  int _getColumns(BuildContext context) {
    if (context.isLargeScreen && desktopColumns != null) {
      return desktopColumns!;
    } else if (context.isMediumScreen && tabletColumns != null) {
      return tabletColumns!;
    } else if (mobileColumns != null) {
      return mobileColumns!;
    } else {
      // Default responsive columns
      if (context.isLargeScreen) return 4;
      if (context.isMediumScreen) return 3;
      return 2;
    }
  }
}

/// Responsive padding that adapts based on screen size
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;

  const ResponsivePadding({
    Key? key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = _getPadding(context);
    return Padding(
      padding: padding,
      child: child,
    );
  }

  EdgeInsets _getPadding(BuildContext context) {
    if (context.isLargeScreen && desktopPadding != null) {
      return desktopPadding!;
    } else if (context.isMediumScreen && tabletPadding != null) {
      return tabletPadding!;
    } else if (mobilePadding != null) {
      return mobilePadding!;
    } else {
      // Default responsive padding
      if (context.isLargeScreen) {
        return const EdgeInsets.all(AppDimensions.paddingXL);
      } else if (context.isMediumScreen) {
        return const EdgeInsets.all(AppDimensions.paddingL);
      } else {
        return const EdgeInsets.all(AppDimensions.paddingM);
      }
    }
  }
}

/// Responsive text that adapts font size based on screen size
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scaleFactor = _getScaleFactor(context);
    
    TextStyle? responsiveStyle = style?.copyWith(
      fontSize: (style?.fontSize ?? 14) * scaleFactor,
    );

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  double _getScaleFactor(BuildContext context) {
    if (context.isLargeScreen) return 1.2;
    if (context.isMediumScreen) return 1.1;
    return 1.0;
  }
}

/// Responsive container that adapts its constraints based on screen size
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final double? desktopMaxWidth;
  final EdgeInsets? padding;
  final Color? color;
  final Decoration? decoration;

  const ResponsiveContainer({
    Key? key,
    required this.child,
    this.mobileMaxWidth,
    this.tabletMaxWidth,
    this.desktopMaxWidth,
    this.padding,
    this.color,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = _getMaxWidth(context);
    
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: padding,
      color: color,
      decoration: decoration,
      child: child,
    );
  }

  double _getMaxWidth(BuildContext context) {
    if (context.isLargeScreen && desktopMaxWidth != null) {
      return desktopMaxWidth!;
    } else if (context.isMediumScreen && tabletMaxWidth != null) {
      return tabletMaxWidth!;
    } else if (mobileMaxWidth != null) {
      return mobileMaxWidth!;
    } else {
      // Default responsive max widths
      if (context.isLargeScreen) return 1200;
      if (context.isMediumScreen) return 800;
      return double.infinity;
    }
  }
}
