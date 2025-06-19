import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('GlassMorphismLensEffect', () {
    group('Constructor and Default Values', () {
      testWidgets('should create with default values',
          (WidgetTester tester) async {
        const testChild = Text('Lens Effect');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Lens Effect'), findsOneWidget);
        expect(find.byType(GlassMorphismLensEffect), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
        expect(find.byType(AnimatedBuilder), findsWidgets);
      });

      testWidgets('should create with custom values',
          (WidgetTester tester) async {
        const testChild = Text('Custom Lens');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                magnification: 2.0,
                lensRadius: 150.0,
                distortionStrength: 0.25,
                refractionIndex: 1.5,
                enableAnimation: false,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Custom Lens'), findsOneWidget);
        expect(find.byType(GlassMorphismLensEffect), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      test('should have correct default property values', () {
        const lensEffect = GlassMorphismLensEffect(
          child: Text('Test'),
        );

        expect(lensEffect.magnification, equals(1.3));
        expect(lensEffect.lensRadius, equals(100.0));
        expect(lensEffect.distortionStrength, equals(0.15));
        expect(lensEffect.refractionIndex, equals(1.33));
        expect(lensEffect.enableAnimation, isTrue);
      });

      test('should accept custom property values', () {
        const lensEffect = GlassMorphismLensEffect(
          magnification: 2.5,
          lensRadius: 200.0,
          distortionStrength: 0.3,
          refractionIndex: 1.8,
          enableAnimation: false,
          child: Text('Test'),
        );

        expect(lensEffect.magnification, equals(2.5));
        expect(lensEffect.lensRadius, equals(200.0));
        expect(lensEffect.distortionStrength, equals(0.3));
        expect(lensEffect.refractionIndex, equals(1.8));
        expect(lensEffect.enableAnimation, isFalse);
      });
    });

    group('Animation Behavior', () {
      testWidgets('should animate when enableAnimation is true',
          (WidgetTester tester) async {
        const testChild = Text('Animated Lens');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                enableAnimation: true,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Animated Lens'), findsOneWidget);

        // Pump animation frames
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pump(const Duration(milliseconds: 400));

        expect(find.text('Animated Lens'), findsOneWidget);
        expect(find.byType(AnimatedBuilder), findsWidgets);
      });

      testWidgets('should not animate when enableAnimation is false',
          (WidgetTester tester) async {
        const testChild = Text('Static Lens');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                enableAnimation: false,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Static Lens'), findsOneWidget);

        // Pump frames - animation should not start
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Static Lens'), findsOneWidget);
      });

      testWidgets('should complete animation cycle',
          (WidgetTester tester) async {
        const testChild = Text('Complete Animation');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                enableAnimation: true,
                child: testChild,
              ),
            ),
          ),
        );

        // Complete the animation
        await tester.pump();
        await tester
            .pump(const Duration(milliseconds: 800)); // Full animation duration

        expect(find.text('Complete Animation'), findsOneWidget);
      });
    });

    group('Widget Lifecycle', () {
      testWidgets('should dispose animation controller properly',
          (WidgetTester tester) async {
        const testChild = Text('Dispose Test');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Dispose Test'), findsOneWidget);

        // Remove the widget to trigger dispose
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Text('Replaced'),
            ),
          ),
        );

        expect(find.text('Dispose Test'), findsNothing);
        expect(find.text('Replaced'), findsOneWidget);
      });

      testWidgets('should handle widget updates', (WidgetTester tester) async {
        const testChild = Text('Update Test');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                magnification: 1.5,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Update Test'), findsOneWidget);

        // Update the widget with new properties
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                magnification: 2.0,
                lensRadius: 150.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Update Test'), findsOneWidget);
      });
    });

    group('Edge Cases and Error Handling', () {
      testWidgets('should handle extreme magnification values',
          (WidgetTester tester) async {
        const testChild = Text('Extreme Magnification');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                magnification: 10.0, // Very high magnification
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Extreme Magnification'), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should handle zero lens radius',
          (WidgetTester tester) async {
        const testChild = Text('Zero Radius');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                lensRadius: 0.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Zero Radius'), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should handle very large lens radius',
          (WidgetTester tester) async {
        const testChild = Text('Large Radius');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                lensRadius: 1000.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Large Radius'), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should handle extreme distortion strength',
          (WidgetTester tester) async {
        const testChild = Text('Extreme Distortion');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                distortionStrength: 1.0, // Maximum distortion
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Extreme Distortion'), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should handle zero distortion strength',
          (WidgetTester tester) async {
        const testChild = Text('No Distortion');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                distortionStrength: 0.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('No Distortion'), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should handle extreme refraction index',
          (WidgetTester tester) async {
        const testChild = Text('Extreme Refraction');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                refractionIndex: 3.0, // Very high refraction
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Extreme Refraction'), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });
    });

    group('Complex Child Widgets', () {
      testWidgets('should work with complex child widgets',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                child: Column(
                  children: [
                    const Text('Complex Child'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Button'),
                    ),
                    const Icon(Icons.star),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Complex Child'), findsOneWidget);
        expect(find.text('Button'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should work with nested lens effects',
          (WidgetTester tester) async {
        const testChild = Text('Nested Lens');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismLensEffect(
                magnification: 1.5,
                child: GlassMorphismLensEffect(
                  magnification: 1.2,
                  child: testChild,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Nested Lens'), findsOneWidget);
        expect(find.byType(GlassMorphismLensEffect), findsNWidgets(2));
        expect(find.byType(CustomPaint), findsWidgets);
      });
    });
  });

  group('GlassDropletEffect', () {
    group('Constructor and Default Values', () {
      testWidgets('should create with default values',
          (WidgetTester tester) async {
        const testChild = Text('Droplet Effect');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Droplet Effect'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
        expect(find.byType(Stack), findsWidgets);
        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('should create with custom values',
          (WidgetTester tester) async {
        const testChild = Text('Custom Droplet');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                dropletSize: 200.0,
                intensity: 0.5,
                position: const Alignment(0.5, 0.5),
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Custom Droplet'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
        expect(find.byType(Stack), findsWidgets);
      });

      test('should have correct default property values', () {
        const dropletEffect = GlassDropletEffect(
          child: Text('Test'),
        );

        expect(dropletEffect.dropletSize, equals(120.0));
        expect(dropletEffect.intensity, equals(0.8));
        expect(dropletEffect.position, equals(const Alignment(0.2, -0.3)));
      });

      test('should accept custom property values', () {
        const dropletEffect = GlassDropletEffect(
          dropletSize: 150.0,
          intensity: 0.6,
          position: Alignment.center,
          child: Text('Test'),
        );

        expect(dropletEffect.dropletSize, equals(150.0));
        expect(dropletEffect.intensity, equals(0.6));
        expect(dropletEffect.position, equals(Alignment.center));
      });
    });

    group('Visual Properties', () {
      testWidgets('should handle different droplet sizes',
          (WidgetTester tester) async {
        const testChild = Text('Size Test');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  GlassDropletEffect(
                    dropletSize: 50.0,
                    child: testChild,
                  ),
                  GlassDropletEffect(
                    dropletSize: 100.0,
                    child: testChild,
                  ),
                  GlassDropletEffect(
                    dropletSize: 200.0,
                    child: testChild,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Size Test'), findsNWidgets(3));
        expect(find.byType(GlassDropletEffect), findsNWidgets(3));
        expect(find.byType(Container), findsNWidgets(3));
      });

      testWidgets('should handle different intensity values',
          (WidgetTester tester) async {
        const testChild = Text('Intensity Test');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  GlassDropletEffect(
                    intensity: 0.2,
                    child: testChild,
                  ),
                  GlassDropletEffect(
                    intensity: 0.5,
                    child: testChild,
                  ),
                  GlassDropletEffect(
                    intensity: 1.0,
                    child: testChild,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Intensity Test'), findsNWidgets(3));
        expect(find.byType(GlassDropletEffect), findsNWidgets(3));
      });

      testWidgets('should handle different positions',
          (WidgetTester tester) async {
        const testChild = Text('Position Test');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  GlassDropletEffect(
                    position: Alignment.topLeft,
                    child: testChild,
                  ),
                  GlassDropletEffect(
                    position: Alignment.center,
                    child: testChild,
                  ),
                  GlassDropletEffect(
                    position: Alignment.bottomRight,
                    child: testChild,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Position Test'), findsNWidgets(3));
        expect(find.byType(GlassDropletEffect), findsNWidgets(3));
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle zero droplet size',
          (WidgetTester tester) async {
        const testChild = Text('Zero Size');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                dropletSize: 0.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Zero Size'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
      });

      testWidgets('should handle zero intensity', (WidgetTester tester) async {
        const testChild = Text('Zero Intensity');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                intensity: 0.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Zero Intensity'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
      });

      testWidgets('should handle maximum intensity',
          (WidgetTester tester) async {
        const testChild = Text('Max Intensity');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                intensity: 1.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Max Intensity'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
      });

      testWidgets('should handle very large droplet size',
          (WidgetTester tester) async {
        const testChild = Text('Large Droplet');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                dropletSize: 1000.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Large Droplet'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
      });
    });

    group('Complex Scenarios', () {
      testWidgets('should work with complex child widgets',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                child: Column(
                  children: [
                    const Text('Complex Droplet Child'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Button'),
                    ),
                    const Icon(Icons.water_drop),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Complex Droplet Child'), findsOneWidget);
        expect(find.text('Button'), findsOneWidget);
        expect(find.byIcon(Icons.water_drop), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
      });

      testWidgets('should work with nested droplet effects',
          (WidgetTester tester) async {
        const testChild = Text('Nested Droplets');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassDropletEffect(
                dropletSize: 150.0,
                position: Alignment.topLeft,
                child: GlassDropletEffect(
                  dropletSize: 100.0,
                  position: Alignment.bottomRight,
                  child: testChild,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Nested Droplets'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(2));
        expect(find.byType(Stack), findsWidgets);
      });
    });
  });

  group('MultipleGlassDropletsEffect', () {
    group('Constructor and Default Values', () {
      testWidgets('should create with default values',
          (WidgetTester tester) async {
        const testChild = Text('Multiple Droplets');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Multiple Droplets'), findsOneWidget);
        expect(find.byType(MultipleGlassDropletsEffect), findsOneWidget);
        expect(find.byType(Stack), findsWidgets);
        expect(
            find.byType(GlassDropletEffect), findsNWidgets(5)); // Default count
      });

      testWidgets('should create with custom values',
          (WidgetTester tester) async {
        const testChild = Text('Custom Multiple Droplets');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 3,
                minSize: 30.0,
                maxSize: 100.0,
                intensity: 0.4,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Custom Multiple Droplets'), findsOneWidget);
        expect(find.byType(MultipleGlassDropletsEffect), findsOneWidget);
        expect(
            find.byType(GlassDropletEffect), findsNWidgets(3)); // Custom count
      });

      test('should have correct default property values', () {
        const multipleDroplets = MultipleGlassDropletsEffect(
          child: Text('Test'),
        );

        expect(multipleDroplets.dropletCount, equals(5));
        expect(multipleDroplets.minSize, equals(20.0));
        expect(multipleDroplets.maxSize, equals(80.0));
        expect(multipleDroplets.intensity, equals(0.6));
      });

      test('should accept custom property values', () {
        const multipleDroplets = MultipleGlassDropletsEffect(
          dropletCount: 8,
          minSize: 10.0,
          maxSize: 120.0,
          intensity: 0.9,
          child: Text('Test'),
        );

        expect(multipleDroplets.dropletCount, equals(8));
        expect(multipleDroplets.minSize, equals(10.0));
        expect(multipleDroplets.maxSize, equals(120.0));
        expect(multipleDroplets.intensity, equals(0.9));
      });
    });

    group('Droplet Generation', () {
      testWidgets('should generate correct number of droplets',
          (WidgetTester tester) async {
        const testChild = Text('Count Test');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 7,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Count Test'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(7));
      });

      testWidgets('should handle zero droplets', (WidgetTester tester) async {
        const testChild = Text('Zero Droplets');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Zero Droplets'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNothing);
      });

      testWidgets('should handle single droplet', (WidgetTester tester) async {
        const testChild = Text('Single Droplet');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 1,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Single Droplet'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsOneWidget);
      });

      testWidgets('should handle many droplets', (WidgetTester tester) async {
        const testChild = Text('Many Droplets');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 15,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Many Droplets'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(15));
      });
    });

    group('Size Variations', () {
      testWidgets('should handle equal min and max sizes',
          (WidgetTester tester) async {
        const testChild = Text('Equal Sizes');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 3,
                minSize: 50.0,
                maxSize: 50.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Equal Sizes'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(3));
      });

      testWidgets('should handle very small sizes',
          (WidgetTester tester) async {
        const testChild = Text('Small Sizes');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 3,
                minSize: 1.0,
                maxSize: 5.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Small Sizes'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(3));
      });

      testWidgets('should handle very large sizes',
          (WidgetTester tester) async {
        const testChild = Text('Large Sizes');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 2,
                minSize: 200.0,
                maxSize: 300.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Large Sizes'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(2));
      });
    });

    group('Edge Cases and Error Handling', () {
      testWidgets('should handle zero intensity', (WidgetTester tester) async {
        const testChild = Text('Zero Intensity Multiple');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                intensity: 0.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Zero Intensity Multiple'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(5));
      });

      testWidgets('should handle maximum intensity',
          (WidgetTester tester) async {
        const testChild = Text('Max Intensity Multiple');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                intensity: 1.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Max Intensity Multiple'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(5));
      });

      testWidgets('should handle zero min size', (WidgetTester tester) async {
        const testChild = Text('Zero Min Size');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                minSize: 0.0,
                maxSize: 50.0,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Zero Min Size'), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(5));
      });
    });

    group('Complex Scenarios', () {
      testWidgets('should work with complex child widgets',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 3,
                child: Column(
                  children: [
                    const Text('Complex Multiple Child'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Button'),
                    ),
                    const Icon(Icons.water),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Complex Multiple Child'), findsOneWidget);
        expect(find.text('Button'), findsOneWidget);
        expect(find.byIcon(Icons.water), findsOneWidget);
        expect(find.byType(GlassDropletEffect), findsNWidgets(3));
      });

      testWidgets('should work with nested multiple droplet effects',
          (WidgetTester tester) async {
        const testChild = Text('Nested Multiple');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MultipleGlassDropletsEffect(
                dropletCount: 2,
                child: MultipleGlassDropletsEffect(
                  dropletCount: 3,
                  child: testChild,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Nested Multiple'), findsOneWidget);
        expect(find.byType(MultipleGlassDropletsEffect), findsNWidgets(2));
        // Total droplets: 2 + 3 = 5
        expect(find.byType(GlassDropletEffect), findsNWidgets(5));
      });

      testWidgets('should generate consistent droplets with same seed',
          (WidgetTester tester) async {
        const testChild = Text('Consistent Generation');

        // Create two identical widgets
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  MultipleGlassDropletsEffect(
                    dropletCount: 3,
                    minSize: 20.0,
                    maxSize: 40.0,
                    child: testChild,
                  ),
                  MultipleGlassDropletsEffect(
                    dropletCount: 3,
                    minSize: 20.0,
                    maxSize: 40.0,
                    child: testChild,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Consistent Generation'), findsNWidgets(2));
        expect(find.byType(MultipleGlassDropletsEffect), findsNWidgets(2));
        expect(find.byType(GlassDropletEffect), findsNWidgets(6)); // 3 + 3
      });
    });
  });
}
