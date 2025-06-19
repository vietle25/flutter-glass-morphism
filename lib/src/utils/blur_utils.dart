import 'dart:ui';
import 'package:flutter/material.dart';

/// Utility functions for blur effects in liquid glass components.
class BlurUtils {
  BlurUtils._();

  /// Creates a backdrop filter with the specified blur intensity.
  static Widget createBackdropBlur({
    required Widget child,
    double sigmaX = 10.0,
    double sigmaY = 10.0,
    TileMode tileMode = TileMode.clamp,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
        tileMode: tileMode,
      ),
      child: child,
    );
  }

  /// Creates a layered blur effect with multiple intensities.
  static Widget createLayeredBlur({
    required Widget child,
    List<double> blurLayers = const [5.0, 10.0, 15.0],
    List<double> opacities = const [0.3, 0.5, 0.2],
  }) {
    assert(blurLayers.length == opacities.length,
        'Blur layers and opacities must have the same length');

    Widget result = child;

    for (int i = blurLayers.length - 1; i >= 0; i--) {
      result = BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurLayers[i],
          sigmaY: blurLayers[i],
        ),
        child: Container(
          color: Colors.white.withOpacity(opacities[i]),
          child: result,
        ),
      );
    }

    return result;
  }

  /// Calculates optimal blur intensity based on content and context.
  static double calculateOptimalBlur({
    required double baseIntensity,
    double contentComplexity = 1.0,
    bool isInteractive = false,
    double distanceFromBackground = 1.0,
  }) {
    double intensity = baseIntensity;

    // Adjust for content complexity
    intensity *= contentComplexity;

    // Reduce blur for interactive elements for better readability
    if (isInteractive) {
      intensity *= 0.8;
    }

    // Adjust based on distance from background
    intensity *= distanceFromBackground;

    return intensity.clamp(0.0, 50.0);
  }

  /// Creates an animated blur effect.
  static Widget createAnimatedBlur({
    required Widget child,
    required Animation<double> animation,
    double maxBlur = 20.0,
    double minBlur = 0.0,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final currentBlur = minBlur + (maxBlur - minBlur) * animation.value;
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: currentBlur,
            sigmaY: currentBlur,
          ),
          child: child,
        );
      },
    );
  }

  /// Creates a directional blur effect.
  static Widget createDirectionalBlur({
    required Widget child,
    double horizontalBlur = 10.0,
    double verticalBlur = 10.0,
    BlurDirection direction = BlurDirection.all,
  }) {
    double sigmaX = horizontalBlur;
    double sigmaY = verticalBlur;

    switch (direction) {
      case BlurDirection.horizontal:
        sigmaY = 0.0;
        break;
      case BlurDirection.vertical:
        sigmaX = 0.0;
        break;
      case BlurDirection.all:
        // Keep both values as provided
        break;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: child,
    );
  }

  /// Creates a blur effect that adapts to the device's performance.
  static Widget createAdaptiveBlur({
    required Widget child,
    required double targetBlur,
    bool highPerformanceDevice = true,
  }) {
    final effectiveBlur = highPerformanceDevice 
        ? targetBlur 
        : targetBlur * 0.7; // Reduce blur on lower-end devices

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: effectiveBlur,
        sigmaY: effectiveBlur,
      ),
      child: child,
    );
  }

  /// Creates a blur mask for selective blurring.
  static Widget createMaskedBlur({
    required Widget child,
    required Widget mask,
    double blurIntensity = 10.0,
  }) {
    return Stack(
      children: [
        child,
        ClipPath(
          clipper: _MaskClipper(mask),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurIntensity,
              sigmaY: blurIntensity,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  /// Determines if blur effects should be enabled based on platform capabilities.
  static bool shouldEnableBlur() {
    // In a real implementation, you might check platform capabilities
    // For now, we'll assume blur is always supported
    return true;
  }

  /// Gets the recommended blur intensity for different UI elements.
  static double getRecommendedBlur(BlurContext context) {
    switch (context) {
      case BlurContext.button:
        return 8.0;
      case BlurContext.card:
        return 12.0;
      case BlurContext.dialog:
        return 15.0;
      case BlurContext.appBar:
        return 20.0;
      case BlurContext.bottomSheet:
        return 25.0;
      case BlurContext.background:
        return 30.0;
    }
  }
}

/// Directions for directional blur effects.
enum BlurDirection {
  horizontal,
  vertical,
  all,
}

/// Contexts for determining appropriate blur intensity.
enum BlurContext {
  button,
  card,
  dialog,
  appBar,
  bottomSheet,
  background,
}

/// Custom clipper for masked blur effects.
class _MaskClipper extends CustomClipper<Path> {
  final Widget mask;

  _MaskClipper(this.mask);

  @override
  Path getClip(Size size) {
    // This is a simplified implementation
    // In a real scenario, you'd extract the path from the mask widget
    return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
