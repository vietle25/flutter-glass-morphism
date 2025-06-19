import 'package:flutter/material.dart';
import '../materials/glass_morphism_material.dart';
import '../theme/glass_morphism_theme.dart';

/// A card with glass morphism material design.
///
/// This card provides a glass-like surface with blur effects,
/// elevation, and adaptive styling.
class GlassMorphismCard extends StatelessWidget {
  /// Creates a glass morphism card.
  const GlassMorphismCard({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.blurIntensity,
    this.opacity,
    this.glassThickness,
    this.tintColor,
    this.borderRadius,
    this.border,
    this.shadows,
    this.elevation = 4.0,
    this.adaptToBackground,
    this.enableBackgroundDistortion,
    this.enableGlassBorder,
    this.enableSpecularHighlights,
    this.clipBehavior = Clip.antiAlias,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// Empty space to surround the card.
  final EdgeInsets? margin;

  /// Empty space to inscribe inside the card.
  final EdgeInsets? padding;

  /// The intensity of the backdrop blur effect.
  final double? blurIntensity;

  /// The opacity of the glass material.
  final double? opacity;

  /// The thickness of the glass effect.
  final double? glassThickness;

  /// Optional tint color for the glass.
  final Color? tintColor;

  /// The border radius of the card.
  final BorderRadius? borderRadius;

  /// Optional border for the card.
  final Border? border;

  /// Optional shadows for depth effect.
  final List<BoxShadow>? shadows;

  /// The card's elevation.
  final double elevation;

  /// Whether to adapt the glass color to the background.
  final bool? adaptToBackground;

  /// Whether to enable background distortion through the glass.
  final bool? enableBackgroundDistortion;

  /// Whether to enable the glass border effect.
  final bool? enableGlassBorder;

  /// Whether to enable specular highlights.
  final bool? enableSpecularHighlights;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = GlassMorphismTheme.of(context);
    final cardTheme = theme.cardTheme;

    final effectiveShadows = shadows ?? _buildElevationShadows();
    final effectiveBorderRadius = borderRadius ?? cardTheme.borderRadius;
    final effectiveMargin = margin ?? cardTheme.margin;
    final effectivePadding = padding ?? cardTheme.padding;

    Widget card = GlassMorphismMaterial(
      blurIntensity: blurIntensity ?? 22.0,
      opacity: opacity ?? 0.18,
      glassThickness: glassThickness ?? 1.2,
      tintColor: tintColor,
      borderRadius: effectiveBorderRadius,
      shadows: effectiveShadows,
      adaptToBackground: adaptToBackground ?? theme.adaptiveColoring,
      enableBackgroundDistortion: enableBackgroundDistortion ?? true,
      enableGlassBorder: enableGlassBorder ?? true,
      child: Container(
        padding: effectivePadding,
        child: child,
      ),
    );

    if (clipBehavior != Clip.none) {
      card = ClipRRect(
        borderRadius: effectiveBorderRadius,
        clipBehavior: clipBehavior,
        child: card,
      );
    }

    return Container(
      margin: effectiveMargin,
      child: card,
    );
  }

  List<BoxShadow> _buildElevationShadows() {
    if (elevation <= 0) return [];

    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: elevation * 2,
        offset: Offset(0, elevation / 2),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: elevation,
        offset: Offset(0, elevation / 4),
      ),
    ];
  }
}
