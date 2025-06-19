import 'package:flutter/material.dart';
import '../materials/glass_morphism_material.dart';
import '../theme/glass_morphism_theme.dart';

/// A tab bar with glass morphism material design.
///
/// This tab bar provides a glass-like appearance with blur effects
/// and smooth morphing animations between tabs.
class GlassMorphismTabBar extends StatelessWidget {
  /// Creates a glass morphism tab bar.
  const GlassMorphismTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.backgroundColor,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.blurIntensity,
    this.opacity,
    this.enableMorphing = true,
  });

  /// The tab controller for this tab bar.
  final TabController controller;

  /// The tabs to display.
  final List<Widget> tabs;

  /// The background color of the tab bar.
  final Color? backgroundColor;

  /// The color of the tab indicator.
  final Color? indicatorColor;

  /// The color of selected tab labels.
  final Color? labelColor;

  /// The color of unselected tab labels.
  final Color? unselectedLabelColor;

  /// The blur intensity for the glass effect.
  final double? blurIntensity;

  /// The opacity of the glass material.
  final double? opacity;

  /// Whether to enable morphing animations.
  final bool enableMorphing;

  @override
  Widget build(BuildContext context) {
    final theme = GlassMorphismTheme.of(context);
    
    return GlassMorphismMaterial(
      blurIntensity: blurIntensity ?? 12.0,
      opacity: opacity ?? 0.8,
      glassThickness: 1.0,
      tintColor: backgroundColor,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: TabBar(
          controller: controller,
          tabs: tabs,
          indicator: BoxDecoration(
            color: indicatorColor ?? Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
          ),
          labelColor: labelColor ?? Colors.white,
          unselectedLabelColor: unselectedLabelColor ?? Colors.white70,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
      ),
    );
  }
}
