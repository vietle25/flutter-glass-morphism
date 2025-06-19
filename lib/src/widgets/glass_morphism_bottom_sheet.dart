import 'package:flutter/material.dart';
import '../materials/glass_morphism_material.dart';
import '../theme/glass_morphism_theme.dart';

/// A bottom sheet with glass morphism material design.
///
/// This bottom sheet provides a glass-like appearance with blur effects
/// and drag-to-dismiss functionality.
class GlassMorphismBottomSheet extends StatefulWidget {
  /// Creates a glass morphism bottom sheet.
  const GlassMorphismBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor,
    this.elevation = 8.0,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.constraints,
    this.blurIntensity,
    this.opacity,
    this.enableDragHandle = true,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The background color of the bottom sheet.
  final Color? backgroundColor;

  /// The elevation of the bottom sheet.
  final double elevation;

  /// The shape of the bottom sheet.
  final ShapeBorder? shape;

  /// The clip behavior of the bottom sheet.
  final Clip clipBehavior;

  /// Additional constraints to apply to the bottom sheet.
  final BoxConstraints? constraints;

  /// The blur intensity for the glass effect.
  final double? blurIntensity;

  /// The opacity of the glass material.
  final double? opacity;

  /// Whether to show a drag handle.
  final bool enableDragHandle;

  /// Shows a glass morphism bottom sheet.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (context) => GlassMorphismBottomSheet(
        backgroundColor: backgroundColor,
        elevation: elevation ?? 8.0,
        shape: shape,
        clipBehavior: clipBehavior ?? Clip.antiAlias,
        constraints: constraints,
        child: child,
      ),
    );
  }

  @override
  State<GlassMorphismBottomSheet> createState() => _GlassMorphismBottomSheetState();
}

class _GlassMorphismBottomSheetState extends State<GlassMorphismBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
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
    final mediaQuery = MediaQuery.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * mediaQuery.size.height * 0.3),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              constraints: widget.constraints,
              child: GlassMorphismMaterial(
                blurIntensity: widget.blurIntensity ?? 25.0,
                opacity: widget.opacity ?? 0.95,
                glassThickness: 2.0,
                tintColor: widget.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.enableDragHandle) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Flexible(child: widget.child),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
