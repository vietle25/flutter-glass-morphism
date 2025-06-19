import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('GlassEffects', () {
    testWidgets('should create frosted glass', (WidgetTester tester) async {
      const testChild = Text('Frosted Glass');

      final frostedGlass = GlassEffects.frostedGlass(
        child: testChild,
        blurIntensity: 20.0,
        opacity: 0.8,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: frostedGlass,
          ),
        ),
      );

      expect(find.text('Frosted Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('should create reflective glass', (WidgetTester tester) async {
      const testChild = Text('Reflective Glass');

      final reflectiveGlass = GlassEffects.reflectiveGlass(
        child: testChild,
        reflectionIntensity: 0.5,
        baseColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: reflectiveGlass,
          ),
        ),
      );

      expect(find.text('Reflective Glass'), findsOneWidget);
      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('should create refractive glass', (WidgetTester tester) async {
      const testChild = Text('Refractive Glass');

      final refractiveGlass = GlassEffects.refractiveGlass(
        child: testChild,
        refractionStrength: 3.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: refractiveGlass,
          ),
        ),
      );

      expect(find.text('Refractive Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('should create tinted glass', (WidgetTester tester) async {
      const testChild = Text('Tinted Glass');

      final tintedGlass = GlassEffects.tintedGlass(
        child: testChild,
        tintColor: Colors.blue,
        tintStrength: 0.3,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: tintedGlass,
          ),
        ),
      );

      expect(find.text('Tinted Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('should create layered glass', (WidgetTester tester) async {
      const testChild = Text('Layered Glass');

      final layeredGlass = GlassEffects.layeredGlass(
        child: testChild,
        blurLayers: const [5.0, 10.0, 15.0],
        opacities: const [0.3, 0.5, 0.2],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: layeredGlass,
          ),
        ),
      );

      expect(find.text('Layered Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsWidgets);
    });

    testWidgets('should create edge highlight glass',
        (WidgetTester tester) async {
      const testChild = Text('Edge Glass');

      final edgeGlass = GlassEffects.edgeHighlightGlass(
        child: testChild,
        highlightColor: Colors.white,
        highlightWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: edgeGlass,
          ),
        ),
      );

      expect(find.text('Edge Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('should create depth glass', (WidgetTester tester) async {
      const testChild = Text('Depth Glass');

      final depthGlass = GlassEffects.depthGlass(
        child: testChild,
        blurIntensity: 15.0,
        opacity: 0.9,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: depthGlass,
          ),
        ),
      );

      expect(find.text('Depth Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('should work with different blur intensities',
        (WidgetTester tester) async {
      const testChild = Text('Variable Blur Glass');

      final lowBlurGlass = GlassEffects.frostedGlass(
        child: testChild,
        blurIntensity: 5.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: lowBlurGlass,
          ),
        ),
      );

      expect(find.text('Variable Blur Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('should work with custom border radius',
        (WidgetTester tester) async {
      const testChild = Text('Rounded Glass');

      final roundedGlass = GlassEffects.frostedGlass(
        child: testChild,
        borderRadius: BorderRadius.circular(25),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: roundedGlass,
          ),
        ),
      );

      expect(find.text('Rounded Glass'), findsOneWidget);
    });

    testWidgets('should work with custom tint colors',
        (WidgetTester tester) async {
      const testChild = Text('Colored Glass');

      final coloredGlass = GlassEffects.frostedGlass(
        child: testChild,
        tintColor: Colors.purple,
        opacity: 0.6,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: coloredGlass,
          ),
        ),
      );

      expect(find.text('Colored Glass'), findsOneWidget);
    });

    testWidgets('should handle edge cases', (WidgetTester tester) async {
      const testChild = Text('Edge Case Glass');

      final edgeCaseGlass = GlassEffects.layeredGlass(
        child: testChild,
        blurLayers: const [0.0], // Minimum blur
        opacities: const [1.0], // Maximum opacity
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: edgeCaseGlass,
          ),
        ),
      );

      expect(find.text('Edge Case Glass'), findsOneWidget);
    });
  });
}
