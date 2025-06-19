import 'package:flutter/material.dart';
import 'glass_morphism_theme_data.dart';

/// An inherited widget that provides glass morphism theme data to its descendants.
/// 
/// This widget should be placed near the root of your widget tree to provide
/// consistent glass morphism styling throughout your application.
class GlassMorphismTheme extends InheritedWidget {
  /// Creates a glass morphism theme.
  const GlassMorphismTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The glass morphism theme data.
  final GlassMorphismThemeData data;

  /// Returns the glass morphism theme data from the closest [GlassMorphismTheme] ancestor.
  /// 
  /// If no [GlassMorphismTheme] ancestor is found, returns a default theme.
  static GlassMorphismThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GlassMorphismTheme>();
    return theme?.data ?? const GlassMorphismThemeData();
  }

  /// Returns the glass morphism theme data from the closest [GlassMorphismTheme] ancestor,
  /// or null if no ancestor is found.
  static GlassMorphismThemeData? maybeOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GlassMorphismTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(GlassMorphismTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// A widget that applies a glass morphism theme to its descendants.
/// 
/// This is a convenience widget that wraps [GlassMorphismTheme] and provides
/// additional functionality for theme management.
class GlassMorphismThemeProvider extends StatelessWidget {
  /// Creates a glass morphism theme provider.
  const GlassMorphismThemeProvider({
    super.key,
    this.data,
    required this.child,
  });

  /// The glass morphism theme data. If null, uses default theme.
  final GlassMorphismThemeData? data;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effectiveData = data ?? _createDefaultTheme(context);
    
    return GlassMorphismTheme(
      data: effectiveData,
      child: child,
    );
  }

  /// Creates a default theme based on the current Flutter theme.
  GlassMorphismThemeData _createDefaultTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;
    
    return GlassMorphismThemeData(
      defaultGlassColor: brightness == Brightness.dark
          ? const Color(0x80FFFFFF)
          : const Color(0x80000000),
      lightGlassColor: colorScheme.surface.withOpacity(0.8),
      darkGlassColor: colorScheme.surface.withOpacity(0.8),
    );
  }
}
