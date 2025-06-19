import 'package:flutter/material.dart';
import '../materials/glass_morphism_material.dart';
import '../theme/glass_morphism_theme.dart';

/// A dialog with glass morphism material design.
///
/// This dialog provides a glass-like appearance with blur effects
/// and smooth animations for showing and hiding content.
class GlassMorphismDialog extends StatefulWidget {
  /// Creates a glass morphism dialog.
  const GlassMorphismDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.backgroundColor,
    this.elevation = 8.0,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.insetPadding =
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    this.blurIntensity,
    this.opacity,
    this.enableSpecularHighlights = true,
  });

  /// The title of the dialog.
  final Widget? title;

  /// The content of the dialog.
  final Widget? content;

  /// The actions to display at the bottom of the dialog.
  final List<Widget>? actions;

  /// The background color of the dialog.
  final Color? backgroundColor;

  /// The elevation of the dialog.
  final double elevation;

  /// The shape of the dialog.
  final ShapeBorder? shape;

  /// The clip behavior of the dialog.
  final Clip clipBehavior;

  /// The padding around the dialog.
  final EdgeInsets insetPadding;

  /// The blur intensity for the glass effect.
  final double? blurIntensity;

  /// The opacity of the glass material.
  final double? opacity;

  /// Whether to enable specular highlights.
  final bool enableSpecularHighlights;

  /// Shows a glass morphism dialog.
  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (context) => GlassMorphismDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }

  @override
  State<GlassMorphismDialog> createState() => _GlassMorphismDialogState();
}

class _GlassMorphismDialogState extends State<GlassMorphismDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
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

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              insetPadding: widget.insetPadding,
              child: GlassMorphismMaterial(
                blurIntensity: widget.blurIntensity ?? 20.0,
                opacity: widget.opacity ?? 0.9,
                glassThickness: 1.5,
                tintColor: widget.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 280,
                    maxWidth: 400,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.title != null) ...[
                        DefaultTextStyle(
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ) ??
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                          child: widget.title!,
                        ),
                        const SizedBox(height: 16),
                      ],
                      if (widget.content != null) ...[
                        DefaultTextStyle(
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ) ??
                              const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                          child: widget.content!,
                        ),
                        const SizedBox(height: 24),
                      ],
                      if (widget.actions != null && widget.actions!.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: widget.actions!
                              .map((action) => Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: action,
                                  ))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A simple alert dialog with glass morphism design.
class GlassMorphismAlertDialog {
  /// Shows a glass morphism alert dialog.
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return GlassMorphismDialog.show(
      context: context,
      title: Text(title),
      content: Text(content),
      actions: actions ??
          [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
      barrierDismissible: barrierDismissible,
    );
  }
}
