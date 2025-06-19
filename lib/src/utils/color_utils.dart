import 'dart:ui';
import 'package:flutter/material.dart';

/// Utility functions for color manipulation in liquid glass effects.
class ColorUtils {
  ColorUtils._();

  /// Adapts a color to the given background for optimal glass effect.
  static Color adaptToBackground(Color baseColor, Color backgroundColor) {
    final backgroundLuminance = backgroundColor.computeLuminance();
    
    // For dark backgrounds, use lighter glass
    if (backgroundLuminance < 0.5) {
      return baseColor.withOpacity(0.8);
    }
    
    // For light backgrounds, use darker glass
    return baseColor.withOpacity(0.6);
  }

  /// Creates a glass-like color with appropriate opacity and tinting.
  static Color createGlassColor(
    Color baseColor, {
    double opacity = 0.8,
    Color? tint,
    bool adaptToBrightness = true,
  }) {
    Color result = baseColor;

    if (tint != null) {
      result = Color.lerp(result, tint, 0.3) ?? result;
    }

    if (adaptToBrightness) {
      final luminance = result.computeLuminance();
      if (luminance < 0.5) {
        // Brighten dark colors for better glass effect
        result = Color.lerp(result, Colors.white, 0.2) ?? result;
      }
    }

    return result.withOpacity(opacity);
  }

  /// Extracts the dominant color from a background for adaptive theming.
  static Color extractDominantColor(Color backgroundColor) {
    final hsl = HSLColor.fromColor(backgroundColor);
    
    // Adjust saturation and lightness for glass effect
    return hsl.withSaturation(
      (hsl.saturation * 0.3).clamp(0.0, 1.0),
    ).withLightness(
      hsl.lightness > 0.5 ? 0.9 : 0.1,
    ).toColor();
  }

  /// Creates a gradient suitable for specular highlights.
  static LinearGradient createSpecularGradient({
    Color? baseColor,
    double intensity = 0.3,
  }) {
    final highlightColor = (baseColor ?? Colors.white).withOpacity(intensity);
    
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        highlightColor,
        Colors.transparent,
        highlightColor.withOpacity(intensity * 0.5),
      ],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  /// Blends two colors with a glass-like mixing algorithm.
  static Color blendGlassColors(Color color1, Color color2, double ratio) {
    // Use a more sophisticated blending for glass effects
    final hsl1 = HSLColor.fromColor(color1);
    final hsl2 = HSLColor.fromColor(color2);
    
    final blendedHue = lerpDouble(hsl1.hue, hsl2.hue, ratio) ?? hsl1.hue;
    final blendedSaturation = lerpDouble(hsl1.saturation, hsl2.saturation, ratio) ?? hsl1.saturation;
    final blendedLightness = lerpDouble(hsl1.lightness, hsl2.lightness, ratio) ?? hsl1.lightness;
    final blendedAlpha = lerpDouble(color1.opacity, color2.opacity, ratio) ?? color1.opacity;
    
    return HSLColor.fromAHSL(
      blendedAlpha,
      blendedHue,
      blendedSaturation,
      blendedLightness,
    ).toColor();
  }

  /// Determines if a color is considered "light" for theming purposes.
  static bool isLightColor(Color color) {
    return color.computeLuminance() > 0.5;
  }

  /// Determines if a color is considered "dark" for theming purposes.
  static bool isDarkColor(Color color) {
    return color.computeLuminance() <= 0.5;
  }

  /// Creates a color with enhanced vibrancy for glass effects.
  static Color enhanceVibrancy(Color color, {double factor = 1.2}) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withSaturation(
      (hsl.saturation * factor).clamp(0.0, 1.0),
    ).toColor();
  }

  /// Creates a subtle tint color based on the primary color.
  static Color createSubtleTint(Color primaryColor, {double opacity = 0.1}) {
    return primaryColor.withOpacity(opacity);
  }

  /// Generates a complementary color for contrast in glass effects.
  static Color getComplementaryColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    final complementaryHue = (hsl.hue + 180) % 360;
    
    return hsl.withHue(complementaryHue).toColor();
  }
}
