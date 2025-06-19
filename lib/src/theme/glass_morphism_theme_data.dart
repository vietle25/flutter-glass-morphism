import 'package:flutter/material.dart';

/// Configuration data for the Glass Morphism theme.
///
/// This class defines the visual properties and behavior of glass morphism
/// components throughout the application.
@immutable
class GlassMorphismThemeData {
  /// Creates a glass morphism theme data.
  const GlassMorphismThemeData({
    this.defaultGlassColor = const Color(0x80FFFFFF),
    this.lightGlassColor = const Color(0x80FFFFFF),
    this.darkGlassColor = const Color(0x80000000),
    this.defaultBlurIntensity = 10.0,
    this.defaultOpacity = 0.8,
    this.defaultBorderRadius = const BorderRadius.all(Radius.circular(12)),
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableSpecularHighlights = true,
    this.adaptiveColoring = true,
    this.buttonTheme = const GlassMorphismButtonThemeData(),
    this.cardTheme = const GlassMorphismCardThemeData(),
    this.appBarTheme = const GlassMorphismAppBarThemeData(),
  });

  /// Default glass color when not adapting to background.
  final Color defaultGlassColor;

  /// Glass color for light backgrounds.
  final Color lightGlassColor;

  /// Glass color for dark backgrounds.
  final Color darkGlassColor;

  /// Default blur intensity for glass effects.
  final double defaultBlurIntensity;

  /// Default opacity for glass materials.
  final double defaultOpacity;

  /// Default border radius for glass components.
  final BorderRadius defaultBorderRadius;

  /// Default animation duration for transitions.
  final Duration animationDuration;

  /// Whether to enable specular highlights by default.
  final bool enableSpecularHighlights;

  /// Whether to enable adaptive coloring by default.
  final bool adaptiveColoring;

  /// Theme data for glass morphism buttons.
  final GlassMorphismButtonThemeData buttonTheme;

  /// Theme data for glass morphism cards.
  final GlassMorphismCardThemeData cardTheme;

  /// Theme data for glass morphism app bars.
  final GlassMorphismAppBarThemeData appBarTheme;

  /// Creates a copy of this theme data with the given fields replaced.
  GlassMorphismThemeData copyWith({
    Color? defaultGlassColor,
    Color? lightGlassColor,
    Color? darkGlassColor,
    double? defaultBlurIntensity,
    double? defaultOpacity,
    BorderRadius? defaultBorderRadius,
    Duration? animationDuration,
    bool? enableSpecularHighlights,
    bool? adaptiveColoring,
    GlassMorphismButtonThemeData? buttonTheme,
    GlassMorphismCardThemeData? cardTheme,
    GlassMorphismAppBarThemeData? appBarTheme,
  }) {
    return GlassMorphismThemeData(
      defaultGlassColor: defaultGlassColor ?? this.defaultGlassColor,
      lightGlassColor: lightGlassColor ?? this.lightGlassColor,
      darkGlassColor: darkGlassColor ?? this.darkGlassColor,
      defaultBlurIntensity: defaultBlurIntensity ?? this.defaultBlurIntensity,
      defaultOpacity: defaultOpacity ?? this.defaultOpacity,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      enableSpecularHighlights:
          enableSpecularHighlights ?? this.enableSpecularHighlights,
      adaptiveColoring: adaptiveColoring ?? this.adaptiveColoring,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      appBarTheme: appBarTheme ?? this.appBarTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassMorphismThemeData &&
        other.defaultGlassColor == defaultGlassColor &&
        other.lightGlassColor == lightGlassColor &&
        other.darkGlassColor == darkGlassColor &&
        other.defaultBlurIntensity == defaultBlurIntensity &&
        other.defaultOpacity == defaultOpacity &&
        other.defaultBorderRadius == defaultBorderRadius &&
        other.animationDuration == animationDuration &&
        other.enableSpecularHighlights == enableSpecularHighlights &&
        other.adaptiveColoring == adaptiveColoring &&
        other.buttonTheme == buttonTheme &&
        other.cardTheme == cardTheme &&
        other.appBarTheme == appBarTheme;
  }

  @override
  int get hashCode {
    return Object.hash(
      defaultGlassColor,
      lightGlassColor,
      darkGlassColor,
      defaultBlurIntensity,
      defaultOpacity,
      defaultBorderRadius,
      animationDuration,
      enableSpecularHighlights,
      adaptiveColoring,
      buttonTheme,
      cardTheme,
      appBarTheme,
    );
  }
}

/// Theme data for glass morphism buttons.
@immutable
class GlassMorphismButtonThemeData {
  const GlassMorphismButtonThemeData({
    this.height = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.blurIntensity = 8.0,
    this.opacity = 0.9,
  });

  final double height;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final double blurIntensity;
  final double opacity;

  GlassMorphismButtonThemeData copyWith({
    double? height,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    double? blurIntensity,
    double? opacity,
  }) {
    return GlassMorphismButtonThemeData(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassMorphismButtonThemeData &&
        other.height == height &&
        other.padding == padding &&
        other.borderRadius == borderRadius &&
        other.blurIntensity == blurIntensity &&
        other.opacity == opacity;
  }

  @override
  int get hashCode {
    return Object.hash(height, padding, borderRadius, blurIntensity, opacity);
  }
}

/// Theme data for glass morphism cards.
@immutable
class GlassMorphismCardThemeData {
  const GlassMorphismCardThemeData({
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.blurIntensity = 12.0,
    this.opacity = 0.85,
  });

  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final double blurIntensity;
  final double opacity;

  GlassMorphismCardThemeData copyWith({
    EdgeInsets? margin,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    double? blurIntensity,
    double? opacity,
  }) {
    return GlassMorphismCardThemeData(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassMorphismCardThemeData &&
        other.margin == margin &&
        other.padding == padding &&
        other.borderRadius == borderRadius &&
        other.blurIntensity == blurIntensity &&
        other.opacity == opacity;
  }

  @override
  int get hashCode {
    return Object.hash(margin, padding, borderRadius, blurIntensity, opacity);
  }
}

/// Theme data for glass morphism app bars.
@immutable
class GlassMorphismAppBarThemeData {
  const GlassMorphismAppBarThemeData({
    this.height = 56.0,
    this.blurIntensity = 15.0,
    this.opacity = 0.95,
    this.enableDynamicSizing = true,
  });

  final double height;
  final double blurIntensity;
  final double opacity;
  final bool enableDynamicSizing;

  GlassMorphismAppBarThemeData copyWith({
    double? height,
    double? blurIntensity,
    double? opacity,
    bool? enableDynamicSizing,
  }) {
    return GlassMorphismAppBarThemeData(
      height: height ?? this.height,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      opacity: opacity ?? this.opacity,
      enableDynamicSizing: enableDynamicSizing ?? this.enableDynamicSizing,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassMorphismAppBarThemeData &&
        other.height == height &&
        other.blurIntensity == blurIntensity &&
        other.opacity == opacity &&
        other.enableDynamicSizing == enableDynamicSizing;
  }

  @override
  int get hashCode {
    return Object.hash(height, blurIntensity, opacity, enableDynamicSizing);
  }
}
