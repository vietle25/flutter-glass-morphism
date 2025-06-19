import 'package:flutter/material.dart';
import '../materials/glass_morphism_material.dart';
import '../theme/glass_morphism_theme.dart';

/// A container with glass morphism material design.
///
/// This container provides a glass-like background with blur effects
/// and adaptive coloring based on the surrounding content.
class GlassMorphismContainer extends StatelessWidget {
  /// Creates a glass morphism container.
  const GlassMorphismContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.constraints,
    this.blurIntensity,
    this.opacity,
    this.glassThickness,
    this.tintColor,
    this.borderRadius,
    this.border,
    this.shadows,
    this.adaptToBackground,
    this.enableBackgroundDistortion,
    this.enableGlassBorder,
    this.enableSpecularHighlights,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// Empty space to inscribe inside the container.
  final EdgeInsets? padding;

  /// Empty space to surround the container.
  final EdgeInsets? margin;

  /// How to align the child within the container.
  final AlignmentGeometry? alignment;

  /// Additional constraints to apply to the child.
  final BoxConstraints? constraints;

  /// The intensity of the backdrop blur effect.
  final double? blurIntensity;

  /// The opacity of the glass material.
  final double? opacity;

  /// The thickness of the glass effect.
  final double? glassThickness;

  /// Optional tint color for the glass.
  final Color? tintColor;

  /// The border radius of the container.
  final BorderRadius? borderRadius;

  /// Optional border for the container.
  final Border? border;

  /// Optional shadows for depth effect.
  final List<BoxShadow>? shadows;

  /// Whether to adapt the glass color to the background.
  final bool? adaptToBackground;

  /// Whether to enable background distortion through the glass.
  final bool? enableBackgroundDistortion;

  /// Whether to enable the glass border effect.
  final bool? enableGlassBorder;

  /// Whether to enable specular highlights.
  final bool? enableSpecularHighlights;

  @override
  Widget build(BuildContext context) {
    final theme = GlassMorphismTheme.of(context);

    Widget container = GlassMorphismMaterial(
      blurIntensity: blurIntensity ?? 18.0,
      opacity: opacity ?? 0.16,
      glassThickness: glassThickness ?? 1.0,
      tintColor: tintColor,
      borderRadius: borderRadius ?? theme.defaultBorderRadius,
      shadows: shadows,
      adaptToBackground: adaptToBackground ?? theme.adaptiveColoring,
      enableBackgroundDistortion: enableBackgroundDistortion ?? true,
      enableGlassBorder: enableGlassBorder ?? true,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        alignment: alignment,
        constraints: constraints,
        child: child,
      ),
    );

    if (margin != null) {
      container = Padding(
        padding: margin!,
        child: container,
      );
    }

    return container;
  }
}
