import 'package:flutter/material.dart';

/// Animation utilities for glass morphism effects.
/// 
/// This class provides pre-configured animations and curves
/// that match the fluid, glass-like behavior of the design system.
class GlassMorphismAnimations {
  GlassMorphismAnimations._();

  /// Standard duration for glass morphism animations.
  static const Duration standardDuration = Duration(milliseconds: 300);

  /// Fast duration for quick interactions.
  static const Duration fastDuration = Duration(milliseconds: 150);

  /// Slow duration for complex transitions.
  static const Duration slowDuration = Duration(milliseconds: 500);

  /// Curve for fluid, glass-like movements.
  static const Curve fluidCurve = Curves.easeInOutCubic;

  /// Curve for bouncy, glass-like effects.
  static const Curve glassCurve = Curves.elasticOut;

  /// Curve for smooth glass transitions.
  static const Curve smoothCurve = Curves.easeInOut;

  /// Creates a morphing animation for glass morphism components.
  static Animation<double> createMorphAnimation(
    AnimationController controller, {
    double begin = 0.0,
    double end = 1.0,
    Curve curve = fluidCurve,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }

  /// Creates a scale animation for button interactions.
  static Animation<double> createScaleAnimation(
    AnimationController controller, {
    double begin = 1.0,
    double end = 0.95,
    Curve curve = smoothCurve,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }

  /// Creates a glow animation for hover effects.
  static Animation<double> createGlowAnimation(
    AnimationController controller, {
    double begin = 0.0,
    double end = 1.0,
    Curve curve = fluidCurve,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }

  /// Creates a blur animation for dynamic focus effects.
  static Animation<double> createBlurAnimation(
    AnimationController controller, {
    double begin = 0.0,
    double end = 10.0,
    Curve curve = smoothCurve,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }

  /// Creates an opacity animation for fade effects.
  static Animation<double> createOpacityAnimation(
    AnimationController controller, {
    double begin = 0.0,
    double end = 1.0,
    Curve curve = fluidCurve,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }

  /// Creates a color animation for adaptive coloring.
  static Animation<Color?> createColorAnimation(
    AnimationController controller, {
    required Color begin,
    required Color end,
    Curve curve = fluidCurve,
  }) {
    return ColorTween(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }
}

/// A widget that provides glass morphism-style animated transitions.
class GlassMorphismTransition extends StatefulWidget {
  /// Creates a glass morphism transition.
  const GlassMorphismTransition({
    super.key,
    required this.child,
    this.duration = GlassMorphismAnimations.standardDuration,
    this.curve = GlassMorphismAnimations.fluidCurve,
    this.animateOpacity = true,
    this.animateScale = false,
    this.animateSlide = false,
    this.slideOffset = const Offset(0, 0.1),
  });

  /// The widget to animate.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  /// Whether to animate opacity.
  final bool animateOpacity;

  /// Whether to animate scale.
  final bool animateScale;

  /// Whether to animate slide.
  final bool animateSlide;

  /// The offset for slide animation.
  final Offset slideOffset;

  @override
  State<GlassMorphismTransition> createState() => _GlassMorphismTransitionState();
}

class _GlassMorphismTransitionState extends State<GlassMorphismTransition>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _opacityAnimation = GlassMorphismAnimations.createOpacityAnimation(
      _controller,
      curve: widget.curve,
    );

    _scaleAnimation = GlassMorphismAnimations.createScaleAnimation(
      _controller,
      begin: 0.8,
      end: 1.0,
      curve: widget.curve,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Widget result = widget.child;

        if (widget.animateSlide) {
          result = SlideTransition(
            position: _slideAnimation,
            child: result,
          );
        }

        if (widget.animateScale) {
          result = ScaleTransition(
            scale: _scaleAnimation,
            child: result,
          );
        }

        if (widget.animateOpacity) {
          result = FadeTransition(
            opacity: _opacityAnimation,
            child: result,
          );
        }

        return result;
      },
    );
  }
}
