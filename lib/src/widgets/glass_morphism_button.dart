import 'package:flutter/material.dart';
import '../materials/glass_morphism_material.dart';
import '../theme/glass_morphism_theme.dart';
import '../theme/glass_morphism_theme_data.dart';

/// A button with glass morphism material design.
///
/// This button provides a glass-like appearance with blur effects,
/// dynamic coloring, and smooth animations.
class GlassMorphismButton extends StatefulWidget {
  /// Creates a glass morphism button.
  const GlassMorphismButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.onLongPress,
    this.style,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  });

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Customizes this button's appearance.
  final GlassMorphismButtonStyle? style;

  /// Whether this button should focus itself if nothing else is already focused.
  final bool autofocus;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  @override
  State<GlassMorphismButton> createState() => _GlassMorphismButtonState();
}

class _GlassMorphismButtonState extends State<GlassMorphismButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _scaleController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _scaleController.reverse();
  }

  void _handleTapCancel() {
    _scaleController.reverse();
  }

  void _handleHoverEnter(PointerEvent event) {
    setState(() => _isHovered = true);
    _glowController.forward();
  }

  void _handleHoverExit(PointerEvent event) {
    setState(() => _isHovered = false);
    _glowController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassMorphismTheme.of(context);
    final effectiveStyle =
        widget.style ?? GlassMorphismButtonStyle.defaultStyle(theme);

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleController, _glowController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: _handleHoverEnter,
            onExit: _handleHoverExit,
            child: GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              onTap: widget.onPressed,
              onLongPress: widget.onLongPress,
              child: Container(
                height: effectiveStyle.height,
                constraints: effectiveStyle.constraints,
                child: GlassMorphismMaterial(
                  blurIntensity: 15.0,
                  opacity: 0.12,
                  glassThickness: 0.8,
                  tintColor: effectiveStyle.backgroundColor,
                  borderRadius: effectiveStyle.borderRadius,
                  shadows: _buildShadows(effectiveStyle),
                  child: Container(
                    padding: effectiveStyle.padding,
                    alignment: Alignment.center,
                    child: DefaultTextStyle(
                      style: effectiveStyle.textStyle ??
                          Theme.of(context).textTheme.labelLarge!,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<BoxShadow>? _buildShadows(GlassMorphismButtonStyle style) {
    final baseShadows = style.shadows ?? [];

    if (_isHovered && _glowAnimation.value > 0) {
      return [
        ...baseShadows,
        BoxShadow(
          color: (style.backgroundColor ?? Colors.white)
              .withOpacity(0.3 * _glowAnimation.value),
          blurRadius: 20 * _glowAnimation.value,
          spreadRadius: 2 * _glowAnimation.value,
        ),
      ];
    }

    return baseShadows.isEmpty ? null : baseShadows;
  }
}

/// Defines the visual properties of a [GlassMorphismButton].
@immutable
class GlassMorphismButtonStyle {
  /// Creates a glass morphism button style.
  const GlassMorphismButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.padding,
    this.height,
    this.constraints,
    this.borderRadius,
    this.border,
    this.shadows,
    this.blurIntensity,
    this.opacity,
  });

  /// The button's background color.
  final Color? backgroundColor;

  /// The button's foreground color.
  final Color? foregroundColor;

  /// The button's text style.
  final TextStyle? textStyle;

  /// The button's padding.
  final EdgeInsets? padding;

  /// The button's height.
  final double? height;

  /// Additional constraints to apply to the button.
  final BoxConstraints? constraints;

  /// The button's border radius.
  final BorderRadius? borderRadius;

  /// The button's border.
  final Border? border;

  /// The button's shadows.
  final List<BoxShadow>? shadows;

  /// The blur intensity for the glass effect.
  final double? blurIntensity;

  /// The opacity of the glass material.
  final double? opacity;

  /// Creates a default button style based on the theme.
  static GlassMorphismButtonStyle defaultStyle(GlassMorphismThemeData theme) {
    return GlassMorphismButtonStyle(
      height: theme.buttonTheme.height,
      padding: theme.buttonTheme.padding,
      borderRadius: theme.buttonTheme.borderRadius,
      blurIntensity: theme.buttonTheme.blurIntensity,
      opacity: theme.buttonTheme.opacity,
    );
  }

  /// Creates a copy of this style with the given fields replaced.
  GlassMorphismButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    double? height,
    BoxConstraints? constraints,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? shadows,
    double? blurIntensity,
    double? opacity,
  }) {
    return GlassMorphismButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      height: height ?? this.height,
      constraints: constraints ?? this.constraints,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      shadows: shadows ?? this.shadows,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      opacity: opacity ?? this.opacity,
    );
  }
}
