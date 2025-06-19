import 'package:flutter/material.dart';
import '../materials/glass_morphism_material.dart';
import '../theme/glass_morphism_theme.dart';

/// An app bar with glass morphism material design.
///
/// This app bar provides a glass-like appearance with blur effects
/// and dynamic sizing based on scroll position.
class GlassMorphismAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates a glass morphism app bar.
  const GlassMorphismAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0.0,
    this.scrollController,
    this.enableDynamicSizing = false,
    this.blurIntensity,
    this.opacity,
    this.height,
  });

  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// A widget to display before the title.
  final Widget? leading;

  /// A list of widgets to display in a row after the title.
  final List<Widget>? actions;

  /// The background color of the app bar.
  final Color? backgroundColor;

  /// The foreground color of the app bar.
  final Color? foregroundColor;

  /// The elevation of the app bar.
  final double elevation;

  /// The scroll controller to listen for scroll changes.
  final ScrollController? scrollController;

  /// Whether to enable dynamic sizing based on scroll.
  final bool enableDynamicSizing;

  /// The blur intensity for the glass effect.
  final double? blurIntensity;

  /// The opacity of the glass material.
  final double? opacity;

  /// The height of the app bar.
  final double? height;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 56.0);

  @override
  State<GlassMorphismAppBar> createState() => _GlassMorphismAppBarState();
}

class _GlassMorphismAppBarState extends State<GlassMorphismAppBar> {
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (mounted) {
      setState(() {
        _scrollOffset = widget.scrollController?.offset ?? 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassMorphismTheme.of(context);
    final mediaQuery = MediaQuery.of(context);
    
    final effectiveHeight = widget.height ?? theme.appBarTheme.height;
    final dynamicOpacity = widget.enableDynamicSizing
        ? (widget.opacity ?? 0.9) * (_scrollOffset / 100).clamp(0.0, 1.0)
        : widget.opacity ?? 0.9;

    return Container(
      height: effectiveHeight + mediaQuery.padding.top,
      child: GlassMorphismMaterial(
        blurIntensity: widget.blurIntensity ?? 15.0,
        opacity: dynamicOpacity,
        glassThickness: 1.0,
        tintColor: widget.backgroundColor,
        borderRadius: BorderRadius.zero,
        child: SafeArea(
          child: Container(
            height: effectiveHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(width: 16),
                ],
                if (widget.title != null) ...[
                  Expanded(
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: widget.foregroundColor ?? Colors.white,
                            fontWeight: FontWeight.w600,
                          ) ??
                          TextStyle(
                            color: widget.foregroundColor ?? Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                      child: widget.title!,
                    ),
                  ),
                ],
                if (widget.actions != null) ...[
                  const SizedBox(width: 16),
                  ...widget.actions!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
