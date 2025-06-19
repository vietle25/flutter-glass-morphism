import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/color_utils.dart';

/// Collection of glass effects for liquid glass components.
/// 
/// This class provides various visual effects that simulate
/// the optical properties of glass materials.
class GlassEffects {
  GlassEffects._();

  /// Creates a frosted glass effect with blur and opacity.
  static Widget frostedGlass({
    required Widget child,
    double blurIntensity = 10.0,
    double opacity = 0.8,
    Color? tintColor,
    BorderRadius? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: (tintColor ?? Colors.white).withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Creates a reflective glass effect with gradient overlays.
  static Widget reflectiveGlass({
    required Widget child,
    double reflectionIntensity = 0.3,
    Color? baseColor,
    BorderRadius? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(reflectionIntensity),
                    Colors.transparent,
                    (baseColor ?? Colors.white).withOpacity(reflectionIntensity * 0.5),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Creates a refractive glass effect that distorts the background.
  static Widget refractiveGlass({
    required Widget child,
    double refractionStrength = 2.0,
    BorderRadius? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: refractionStrength,
          sigmaY: refractionStrength,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.1),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Creates a layered glass effect with multiple blur levels.
  static Widget layeredGlass({
    required Widget child,
    List<double> blurLayers = const [5.0, 10.0, 15.0],
    List<double> opacities = const [0.3, 0.5, 0.2],
    Color? baseColor,
    BorderRadius? borderRadius,
  }) {
    assert(blurLayers.length == opacities.length,
        'Blur layers and opacities must have the same length');

    Widget result = child;
    final effectiveColor = baseColor ?? Colors.white;

    for (int i = blurLayers.length - 1; i >= 0; i--) {
      result = ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurLayers[i],
            sigmaY: blurLayers[i],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: effectiveColor.withOpacity(opacities[i]),
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
            child: result,
          ),
        ),
      );
    }

    return result;
  }

  /// Creates a dynamic glass effect that responds to interactions.
  static Widget dynamicGlass({
    required Widget child,
    required Animation<double> animation,
    double maxBlur = 20.0,
    double minBlur = 5.0,
    double maxOpacity = 0.9,
    double minOpacity = 0.6,
    Color? baseColor,
    BorderRadius? borderRadius,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final currentBlur = minBlur + (maxBlur - minBlur) * animation.value;
        final currentOpacity = minOpacity + (maxOpacity - minOpacity) * animation.value;

        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: currentBlur,
              sigmaY: currentBlur,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: (baseColor ?? Colors.white).withOpacity(currentOpacity),
                borderRadius: borderRadius ?? BorderRadius.circular(12),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// Creates a tinted glass effect with color adaptation.
  static Widget tintedGlass({
    required Widget child,
    required Color tintColor,
    double tintStrength = 0.3,
    double blurIntensity = 10.0,
    BorderRadius? borderRadius,
  }) {
    final adaptedColor = ColorUtils.createGlassColor(
      tintColor,
      opacity: tintStrength,
      adaptToBrightness: true,
    );

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: adaptedColor,
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Creates a glass effect with edge highlighting.
  static Widget edgeHighlightGlass({
    required Widget child,
    double blurIntensity = 10.0,
    double opacity = 0.8,
    Color? baseColor,
    Color? highlightColor,
    double highlightWidth = 1.0,
    BorderRadius? borderRadius,
  }) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(12);
    final effectiveHighlightColor = highlightColor ?? Colors.white.withOpacity(0.5);

    return ClipRRect(
      borderRadius: effectiveBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: (baseColor ?? Colors.white).withOpacity(opacity),
            borderRadius: effectiveBorderRadius,
            border: Border.all(
              color: effectiveHighlightColor,
              width: highlightWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Creates a glass effect with inner shadow for depth.
  static Widget depthGlass({
    required Widget child,
    double blurIntensity = 10.0,
    double opacity = 0.8,
    Color? baseColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? innerShadows,
  }) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(12);
    final defaultInnerShadows = innerShadows ?? [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.1),
        blurRadius: 1,
        offset: const Offset(0, -1),
      ),
    ];

    return ClipRRect(
      borderRadius: effectiveBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: (baseColor ?? Colors.white).withOpacity(opacity),
            borderRadius: effectiveBorderRadius,
            boxShadow: defaultInnerShadows,
          ),
          child: child,
        ),
      ),
    );
  }
}
