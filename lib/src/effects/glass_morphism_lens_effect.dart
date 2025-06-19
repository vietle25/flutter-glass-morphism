import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Creates a glass morphism lens effect that simulates optical distortion
class GlassMorphismLensEffect extends StatefulWidget {
  const GlassMorphismLensEffect({
    super.key,
    required this.child,
    this.magnification = 1.3,
    this.lensRadius = 100.0,
    this.distortionStrength = 0.15,
    this.refractionIndex = 1.33,
    this.enableAnimation = true,
  });

  final Widget child;
  final double magnification;
  final double lensRadius;
  final double distortionStrength;
  final double refractionIndex;
  final bool enableAnimation;

  @override
  State<GlassMorphismLensEffect> createState() =>
      _GlassMorphismLensEffectState();
}

class _GlassMorphismLensEffectState extends State<GlassMorphismLensEffect>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.elasticOut,
    ));

    if (widget.enableAnimation) {
      _rippleController.forward();
    }
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rippleAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: _GlassMorphismLensPainter(
            magnification: widget.magnification,
            lensRadius: widget.lensRadius,
            distortionStrength: widget.distortionStrength,
            refractionIndex: widget.refractionIndex,
            animationValue: _rippleAnimation.value,
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Custom painter that creates the glass morphism lens distortion effect
class _GlassMorphismLensPainter extends CustomPainter {
  final double magnification;
  final double lensRadius;
  final double distortionStrength;
  final double refractionIndex;
  final double animationValue;

  _GlassMorphismLensPainter({
    required this.magnification,
    required this.lensRadius,
    required this.distortionStrength,
    required this.refractionIndex,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final effectiveRadius = lensRadius * animationValue;

    // Create the lens effect using multiple layers
    _paintLensDistortion(canvas, size, center, effectiveRadius);
    _paintSurfaceTension(canvas, center, effectiveRadius);
    _paintSpecularHighlight(canvas, center, effectiveRadius);
  }

  void _paintLensDistortion(
      Canvas canvas, Size size, Offset center, double radius) {
    // Create a radial gradient that simulates lens distortion
    final paint = Paint()
      ..shader = ui.Gradient.radial(
        center,
        radius,
        [
          Colors.white.withOpacity(0.1 * animationValue),
          Colors.white.withOpacity(0.05 * animationValue),
          Colors.transparent,
        ],
        [0.0, 0.7, 1.0],
      );

    canvas.drawCircle(center, radius, paint);
  }

  void _paintSurfaceTension(Canvas canvas, Offset center, double radius) {
    // Paint the edge of the glass with surface tension effect
    final edgePaint = Paint()
      ..color = Colors.black.withOpacity(0.1 * animationValue)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, radius, edgePaint);

    // Inner highlight ring
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3 * animationValue)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, radius * 0.95, highlightPaint);
  }

  void _paintSpecularHighlight(Canvas canvas, Offset center, double radius) {
    // Create a specular highlight that simulates light reflection
    final highlightCenter = Offset(
      center.dx - radius * 0.3,
      center.dy - radius * 0.4,
    );

    final highlightPaint = Paint()
      ..shader = ui.Gradient.radial(
        highlightCenter,
        radius * 0.4,
        [
          Colors.white.withOpacity(0.6 * animationValue),
          Colors.white.withOpacity(0.2 * animationValue),
          Colors.transparent,
        ],
        [0.0, 0.5, 1.0],
      );

    canvas.drawCircle(highlightCenter, radius * 0.4, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant _GlassMorphismLensPainter oldDelegate) {
    return oldDelegate.magnification != magnification ||
        oldDelegate.lensRadius != lensRadius ||
        oldDelegate.distortionStrength != distortionStrength ||
        oldDelegate.refractionIndex != refractionIndex ||
        oldDelegate.animationValue != animationValue;
  }
}

/// Widget that creates a glass droplet effect on any child widget
class GlassDropletEffect extends StatelessWidget {
  const GlassDropletEffect({
    super.key,
    required this.child,
    this.dropletSize = 120.0,
    this.intensity = 0.8,
    this.position = const Alignment(0.2, -0.3),
  });

  final Widget child;
  final double dropletSize;
  final double intensity;
  final Alignment position;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Align(
            alignment: position,
            child: Container(
              width: dropletSize,
              height: dropletSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(-0.3, -0.4),
                  radius: 1.0,
                  colors: [
                    Colors.white.withOpacity(0.4 * intensity),
                    Colors.white.withOpacity(0.1 * intensity),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2 * intensity),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3 * intensity),
                    blurRadius: 2,
                    offset: const Offset(-1, -2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Creates multiple glass droplets scattered across the surface
class MultipleGlassDropletsEffect extends StatelessWidget {
  const MultipleGlassDropletsEffect({
    super.key,
    required this.child,
    this.dropletCount = 5,
    this.minSize = 20.0,
    this.maxSize = 80.0,
    this.intensity = 0.6,
  });

  final Widget child;
  final int dropletCount;
  final double minSize;
  final double maxSize;
  final double intensity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ...List.generate(dropletCount, (index) {
          final random = math.Random(index);
          final size = minSize + random.nextDouble() * (maxSize - minSize);
          final x = random.nextDouble() * 2 - 1; // -1 to 1
          final y = random.nextDouble() * 2 - 1; // -1 to 1

          return GlassDropletEffect(
            dropletSize: size,
            intensity: intensity * (0.5 + random.nextDouble() * 0.5),
            position: Alignment(x, y),
            child: const SizedBox.shrink(),
          );
        }),
      ],
    );
  }
}
