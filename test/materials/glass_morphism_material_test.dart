import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('GlassMorphismMaterial', () {
    testWidgets('should render with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(GlassMorphismMaterial), findsOneWidget);
    });

    testWidgets('should apply custom blur intensity', (WidgetTester tester) async {
      const customBlurIntensity = 25.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              blurIntensity: customBlurIntensity,
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.blurIntensity, equals(customBlurIntensity));
    });

    testWidgets('should apply custom opacity', (WidgetTester tester) async {
      const customOpacity = 0.5;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              opacity: customOpacity,
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.opacity, equals(customOpacity));
    });

    testWidgets('should apply custom tint color', (WidgetTester tester) async {
      const customTintColor = Colors.blue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              tintColor: customTintColor,
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.tintColor, equals(customTintColor));
    });

    testWidgets('should apply custom border radius', (WidgetTester tester) async {
      const customBorderRadius = BorderRadius.all(Radius.circular(20));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              borderRadius: customBorderRadius,
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.borderRadius, equals(customBorderRadius));
    });

    testWidgets('should handle glass thickness property', (WidgetTester tester) async {
      const customGlassThickness = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              glassThickness: customGlassThickness,
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.glassThickness, equals(customGlassThickness));
    });

    testWidgets('should handle background distortion setting', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              enableBackgroundDistortion: false,
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.enableBackgroundDistortion, equals(false));
    });

    testWidgets('should handle glass border setting', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              enableGlassBorder: false,
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.enableGlassBorder, equals(false));
    });

    testWidgets('should work with theme provider', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: GlassMorphismThemeProvider(
            child: Scaffold(
              body: GlassMorphismMaterial(
                child: Container(
                  width: 100,
                  height: 100,
                  child: const Text('Test'),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(GlassMorphismMaterial), findsOneWidget);
      expect(find.byType(GlassMorphismThemeProvider), findsOneWidget);
    });

    testWidgets('should animate properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismMaterial(
              animationDuration: const Duration(milliseconds: 500),
              child: Container(
                width: 100,
                height: 100,
                child: const Text('Test'),
              ),
            ),
          ),
        ),
      );

      final glassMaterial = tester.widget<GlassMorphismMaterial>(
        find.byType(GlassMorphismMaterial),
      );
      expect(glassMaterial.animationDuration, equals(const Duration(milliseconds: 500)));

      // Test animation by pumping frames
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pump(const Duration(milliseconds: 250));
      
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
