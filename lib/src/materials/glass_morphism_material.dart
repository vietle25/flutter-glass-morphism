import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/glass_morphism_theme.dart';
import '../theme/glass_morphism_theme_data.dart';

/// The core material that provides the glassmorphism effect.
///
/// This widget creates a translucent glass-like surface that shows the background
/// content through multiple layers of blur and distortion, creating the signature
/// glassmorphism appearance with advanced visual effects.
class GlassMorphismMaterial extends StatefulWidget {
  /// Creates a glass morphism material.
  const GlassMorphismMaterial({
    super.key,
    required this.child,
    this.blurIntensity = 20.0,
    this.opacity = 0.15,
    this.backgroundOpacity = 0.8,
    this.glassThickness = 1.0,
    this.tintColor,
    this.borderRadius,
    this.shadows,
    this.adaptToBackground = true,
    this.enableBackgroundDistortion = true,
    this.enableGlassBorder = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The intensity of the backdrop blur effect.
  final double blurIntensity;

  /// The opacity of the glass surface layer.
  final double opacity;

  /// The opacity of the background content showing through.
  final double backgroundOpacity;

  /// The thickness of the glass effect (affects distortion and depth).
  final double glassThickness;

  /// Optional tint color for the glass.
  final Color? tintColor;

  /// The border radius of the glass surface.
  final BorderRadius? borderRadius;

  /// Optional shadows for depth effect.
  final List<BoxShadow>? shadows;

  /// Whether to adapt the glass color to the background.
  final bool adaptToBackground;

  /// Whether to enable subtle background distortion through the glass.
  final bool enableBackgroundDistortion;

  /// Whether to enable the subtle glass border effect.
  final bool enableGlassBorder;

  /// Duration for animations when properties change.
  final Duration animationDuration;

  @override
  State<GlassMorphismMaterial> createState() => _GlassMorphismMaterialState();
}

class _GlassMorphismMaterialState extends State<GlassMorphismMaterial>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _surfaceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _surfaceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassMorphismTheme.of(context);
    final effectiveColor = _getEffectiveColor(context, theme);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background blur layer
              _buildBackgroundBlur(),

              // Glass surface layer with tint
              _buildGlassSurface(effectiveColor),

              // Glass border effect
              if (widget.enableGlassBorder) _buildGlassBorder(),

              // Content layer
              widget.child,
            ],
          ),
        );
      },
    );
  }

  /// Builds the background blur layer that creates the glass effect
  Widget _buildBackgroundBlur() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: widget.blurIntensity,
          sigmaY: widget.blurIntensity,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  /// Builds the glass surface with translucent tint
  Widget _buildGlassSurface(Color effectiveColor) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          // Multiple layers to create depth
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              effectiveColor.withOpacity(widget.opacity * 0.6),
              effectiveColor.withOpacity(widget.opacity),
              effectiveColor.withOpacity(widget.opacity * 0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          // Subtle inner shadow for depth
          boxShadow: widget.shadows ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
        ),
        // Additional blur for glass thickness effect
        child: widget.enableBackgroundDistortion
            ? BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.glassThickness * 2,
                  sigmaY: widget.glassThickness * 2,
                ),
                child: Container(
                  color: effectiveColor.withOpacity(widget.opacity * 0.3),
                ),
              )
            : Container(
                color: effectiveColor.withOpacity(widget.opacity * 0.3),
              ),
      ),
    );
  }

  /// Builds the subtle glass border effect
  Widget _buildGlassBorder() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2 * _surfaceAnimation.value),
            width: 0.5,
          ),
          // Subtle outer glow
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1 * _surfaceAnimation.value),
              blurRadius: 4,
              spreadRadius: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  Color _getEffectiveColor(BuildContext context, GlassMorphismThemeData theme) {
    if (widget.tintColor != null) {
      return widget.tintColor!;
    }

    if (widget.adaptToBackground) {
      final brightness = Theme.of(context).brightness;
      return brightness == Brightness.dark
          ? theme.darkGlassColor
          : theme.lightGlassColor;
    }

    return theme.defaultGlassColor;
  }
}
