import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('BlurUtils', () {
    group('createBackdropBlur', () {
      testWidgets('should create backdrop blur widget with default parameters',
          (WidgetTester tester) async {
        const testChild = Text('Test Content');

        final blurWidget = BlurUtils.createBackdropBlur(
          child: testChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: blurWidget,
            ),
          ),
        );

        expect(find.text('Test Content'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should create backdrop blur widget with custom parameters',
          (WidgetTester tester) async {
        const testChild = Text('Test Content');
        const sigmaX = 15.0;
        const sigmaY = 20.0;

        final blurWidget = BlurUtils.createBackdropBlur(
          child: testChild,
          sigmaX: sigmaX,
          sigmaY: sigmaY,
          tileMode: TileMode.mirror,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: blurWidget,
            ),
          ),
        );

        expect(find.text('Test Content'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should handle zero blur values',
          (WidgetTester tester) async {
        const testChild = Text('No Blur');

        final blurWidget = BlurUtils.createBackdropBlur(
          child: testChild,
          sigmaX: 0.0,
          sigmaY: 0.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: blurWidget,
            ),
          ),
        );

        expect(find.text('No Blur'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });
    });

    group('calculateOptimalBlur', () {
      test('should calculate optimal blur with all parameters', () {
        const baseIntensity = 15.0;
        const contentComplexity = 1.2;
        const isInteractive = true;
        const distanceFromBackground = 0.8;

        final optimalBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: baseIntensity,
          contentComplexity: contentComplexity,
          isInteractive: isInteractive,
          distanceFromBackground: distanceFromBackground,
        );

        // Expected calculation: 15.0 * 1.2 * 0.8 * 0.8 = 11.52
        expect(optimalBlur, closeTo(11.52, 0.01));
        expect(optimalBlur, lessThanOrEqualTo(50.0));
      });

      test('should calculate optimal blur with default parameters', () {
        const baseIntensity = 10.0;

        final optimalBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: baseIntensity,
        );

        // Expected: 10.0 * 1.0 * 1.0 = 10.0 (no interactive reduction)
        expect(optimalBlur, equals(10.0));
        expect(optimalBlur, lessThanOrEqualTo(50.0));
      });

      test('should reduce blur for interactive elements', () {
        const baseIntensity = 20.0;

        final nonInteractiveBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: baseIntensity,
          isInteractive: false,
        );

        final interactiveBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: baseIntensity,
          isInteractive: true,
        );

        expect(interactiveBlur, lessThan(nonInteractiveBlur));
        expect(interactiveBlur, equals(baseIntensity * 0.8));
      });

      test('should clamp blur to maximum value', () {
        const baseIntensity = 100.0; // Very high value

        final optimalBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: baseIntensity,
        );

        expect(optimalBlur, equals(50.0)); // Should be clamped to 50
      });

      test('should clamp blur to minimum value', () {
        const baseIntensity = -10.0; // Negative value

        final optimalBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: baseIntensity,
        );

        expect(optimalBlur, equals(0.0)); // Should be clamped to 0
      });

      test('should handle edge case values', () {
        final zeroBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: 0.0,
          contentComplexity: 0.0,
          distanceFromBackground: 0.0,
        );

        expect(zeroBlur, equals(0.0));

        final extremeBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: 25.0,
          contentComplexity: 3.0,
          isInteractive: false,
          distanceFromBackground: 2.0,
        );

        expect(extremeBlur, equals(50.0)); // Should be clamped
      });
    });

    group('createLayeredBlur', () {
      testWidgets('should create layered blur with default parameters',
          (WidgetTester tester) async {
        const testChild = Text('Layered Content');

        final layeredBlur = BlurUtils.createLayeredBlur(
          child: testChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layeredBlur,
            ),
          ),
        );

        expect(find.text('Layered Content'), findsOneWidget);
        expect(
            find.byType(BackdropFilter), findsNWidgets(3)); // Default 3 layers
      });

      testWidgets('should create layered blur with custom parameters',
          (WidgetTester tester) async {
        const testChild = Text('Custom Layered');

        final layeredBlur = BlurUtils.createLayeredBlur(
          child: testChild,
          blurLayers: const [2.0, 8.0],
          opacities: const [0.2, 0.4],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layeredBlur,
            ),
          ),
        );

        expect(find.text('Custom Layered'), findsOneWidget);
        expect(
            find.byType(BackdropFilter), findsNWidgets(2)); // 2 custom layers
      });

      test('should assert equal length of blur layers and opacities', () {
        const testChild = Text('Test');

        expect(
          () => BlurUtils.createLayeredBlur(
            child: testChild,
            blurLayers: const [5.0, 10.0],
            opacities: const [0.3], // Mismatched length
          ),
          throwsAssertionError,
        );
      });

      testWidgets('should handle single layer', (WidgetTester tester) async {
        const testChild = Text('Single Layer');

        final layeredBlur = BlurUtils.createLayeredBlur(
          child: testChild,
          blurLayers: const [10.0],
          opacities: const [0.5],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layeredBlur,
            ),
          ),
        );

        expect(find.text('Single Layer'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should handle empty layers', (WidgetTester tester) async {
        const testChild = Text('No Layers');

        final layeredBlur = BlurUtils.createLayeredBlur(
          child: testChild,
          blurLayers: const [],
          opacities: const [],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layeredBlur,
            ),
          ),
        );

        expect(find.text('No Layers'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsNothing);
      });
    });

    group('createAnimatedBlur', () {
      testWidgets('should create animated blur widget',
          (WidgetTester tester) async {
        const testChild = Text('Animated Content');

        final controller = AnimationController(
          duration: const Duration(seconds: 1),
          vsync: tester,
        );
        addTearDown(controller.dispose);

        final animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(controller);

        final animatedBlur = BlurUtils.createAnimatedBlur(
          child: testChild,
          animation: animation,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: animatedBlur,
            ),
          ),
        );

        expect(find.text('Animated Content'), findsOneWidget);
        expect(find.byType(AnimatedBuilder), findsWidgets);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should animate blur values correctly',
          (WidgetTester tester) async {
        const testChild = Text('Animated Blur');

        final controller = AnimationController(
          duration: const Duration(milliseconds: 100),
          vsync: tester,
        );

        final animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(controller);

        final animatedBlur = BlurUtils.createAnimatedBlur(
          child: testChild,
          animation: animation,
          maxBlur: 30.0,
          minBlur: 5.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: animatedBlur,
            ),
          ),
        );

        // Test initial state
        expect(find.text('Animated Blur'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);

        // Dispose controller
        controller.dispose();
      });

      testWidgets('should handle custom blur range',
          (WidgetTester tester) async {
        const testChild = Text('Custom Range');

        final controller = AnimationController(
          duration: const Duration(seconds: 1),
          vsync: tester,
        );
        addTearDown(controller.dispose);

        final animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(controller);

        final animatedBlur = BlurUtils.createAnimatedBlur(
          child: testChild,
          animation: animation,
          maxBlur: 50.0,
          minBlur: 0.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: animatedBlur,
            ),
          ),
        );

        expect(find.text('Custom Range'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });
    });

    group('createDirectionalBlur', () {
      testWidgets('should create horizontal blur', (WidgetTester tester) async {
        const testChild = Text('Horizontal Blur');

        final directionalBlur = BlurUtils.createDirectionalBlur(
          child: testChild,
          horizontalBlur: 15.0,
          verticalBlur: 10.0,
          direction: BlurDirection.horizontal,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: directionalBlur,
            ),
          ),
        );

        expect(find.text('Horizontal Blur'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should create vertical blur', (WidgetTester tester) async {
        const testChild = Text('Vertical Blur');

        final directionalBlur = BlurUtils.createDirectionalBlur(
          child: testChild,
          horizontalBlur: 15.0,
          verticalBlur: 10.0,
          direction: BlurDirection.vertical,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: directionalBlur,
            ),
          ),
        );

        expect(find.text('Vertical Blur'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should create all-directional blur',
          (WidgetTester tester) async {
        const testChild = Text('All Direction Blur');

        final directionalBlur = BlurUtils.createDirectionalBlur(
          child: testChild,
          horizontalBlur: 12.0,
          verticalBlur: 8.0,
          direction: BlurDirection.all,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: directionalBlur,
            ),
          ),
        );

        expect(find.text('All Direction Blur'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should use default parameters', (WidgetTester tester) async {
        const testChild = Text('Default Directional');

        final directionalBlur = BlurUtils.createDirectionalBlur(
          child: testChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: directionalBlur,
            ),
          ),
        );

        expect(find.text('Default Directional'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });
    });

    group('createAdaptiveBlur', () {
      testWidgets('should create adaptive blur for high performance device',
          (WidgetTester tester) async {
        const testChild = Text('High Performance');

        final adaptiveBlur = BlurUtils.createAdaptiveBlur(
          child: testChild,
          targetBlur: 20.0,
          highPerformanceDevice: true,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: adaptiveBlur,
            ),
          ),
        );

        expect(find.text('High Performance'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should create adaptive blur for low performance device',
          (WidgetTester tester) async {
        const testChild = Text('Low Performance');

        final adaptiveBlur = BlurUtils.createAdaptiveBlur(
          child: testChild,
          targetBlur: 20.0,
          highPerformanceDevice: false,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: adaptiveBlur,
            ),
          ),
        );

        expect(find.text('Low Performance'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should use default high performance setting',
          (WidgetTester tester) async {
        const testChild = Text('Default Performance');

        final adaptiveBlur = BlurUtils.createAdaptiveBlur(
          child: testChild,
          targetBlur: 15.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: adaptiveBlur,
            ),
          ),
        );

        expect(find.text('Default Performance'), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });
    });

    group('createMaskedBlur', () {
      testWidgets('should create masked blur widget',
          (WidgetTester tester) async {
        const testChild = Text('Masked Content');
        const maskWidget = Icon(Icons.star);

        final maskedBlur = BlurUtils.createMaskedBlur(
          child: testChild,
          mask: maskWidget,
          blurIntensity: 12.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: maskedBlur,
            ),
          ),
        );

        expect(find.text('Masked Content'), findsOneWidget);
        expect(find.byType(Stack), findsWidgets);
        expect(find.byType(ClipPath), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should use default blur intensity',
          (WidgetTester tester) async {
        const testChild = Text('Default Masked');
        final maskWidget = Container();

        final maskedBlur = BlurUtils.createMaskedBlur(
          child: testChild,
          mask: maskWidget,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: maskedBlur,
            ),
          ),
        );

        expect(find.text('Default Masked'), findsOneWidget);
        expect(find.byType(Stack), findsWidgets);
      });
    });

    group('shouldEnableBlur', () {
      test('should always return true in current implementation', () {
        final shouldEnable = BlurUtils.shouldEnableBlur();
        expect(shouldEnable, isTrue);
      });
    });

    group('getRecommendedBlur', () {
      test('should return correct blur values for all contexts', () {
        final buttonBlur = BlurUtils.getRecommendedBlur(BlurContext.button);
        final cardBlur = BlurUtils.getRecommendedBlur(BlurContext.card);
        final dialogBlur = BlurUtils.getRecommendedBlur(BlurContext.dialog);
        final appBarBlur = BlurUtils.getRecommendedBlur(BlurContext.appBar);
        final bottomSheetBlur =
            BlurUtils.getRecommendedBlur(BlurContext.bottomSheet);
        final backgroundBlur =
            BlurUtils.getRecommendedBlur(BlurContext.background);

        expect(buttonBlur, equals(8.0));
        expect(cardBlur, equals(12.0));
        expect(dialogBlur, equals(15.0));
        expect(appBarBlur, equals(20.0));
        expect(bottomSheetBlur, equals(25.0));
        expect(backgroundBlur, equals(30.0));
      });

      test('should have increasing blur intensity for different contexts', () {
        final buttonBlur = BlurUtils.getRecommendedBlur(BlurContext.button);
        final cardBlur = BlurUtils.getRecommendedBlur(BlurContext.card);
        final dialogBlur = BlurUtils.getRecommendedBlur(BlurContext.dialog);
        final appBarBlur = BlurUtils.getRecommendedBlur(BlurContext.appBar);
        final bottomSheetBlur =
            BlurUtils.getRecommendedBlur(BlurContext.bottomSheet);
        final backgroundBlur =
            BlurUtils.getRecommendedBlur(BlurContext.background);

        // Verify increasing blur intensity for different contexts
        expect(buttonBlur, lessThan(cardBlur));
        expect(cardBlur, lessThan(dialogBlur));
        expect(dialogBlur, lessThan(appBarBlur));
        expect(appBarBlur, lessThan(bottomSheetBlur));
        expect(bottomSheetBlur, lessThan(backgroundBlur));
      });

      test('should handle all enum values', () {
        for (final context in BlurContext.values) {
          final blur = BlurUtils.getRecommendedBlur(context);
          expect(blur, greaterThan(0.0));
          expect(blur, lessThanOrEqualTo(50.0));
        }
      });
    });

    group('BlurDirection enum', () {
      test('should have all expected values', () {
        expect(BlurDirection.values.length, equals(3));
        expect(BlurDirection.values, contains(BlurDirection.horizontal));
        expect(BlurDirection.values, contains(BlurDirection.vertical));
        expect(BlurDirection.values, contains(BlurDirection.all));
      });
    });

    group('BlurContext enum', () {
      test('should have all expected values', () {
        expect(BlurContext.values.length, equals(6));
        expect(BlurContext.values, contains(BlurContext.button));
        expect(BlurContext.values, contains(BlurContext.card));
        expect(BlurContext.values, contains(BlurContext.dialog));
        expect(BlurContext.values, contains(BlurContext.appBar));
        expect(BlurContext.values, contains(BlurContext.bottomSheet));
        expect(BlurContext.values, contains(BlurContext.background));
      });
    });

    group('Edge Cases and Error Handling', () {
      testWidgets('should handle null child gracefully in createBackdropBlur',
          (WidgetTester tester) async {
        final blurWidget = BlurUtils.createBackdropBlur(
          child: const SizedBox.shrink(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: blurWidget,
            ),
          ),
        );

        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('should handle complex child widgets',
          (WidgetTester tester) async {
        final complexChild = Column(
          children: [
            const Text('Complex'),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text('Button')),
            const Icon(Icons.star),
          ],
        );

        final blurWidget = BlurUtils.createBackdropBlur(
          child: complexChild,
          sigmaX: 5.0,
          sigmaY: 5.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: blurWidget,
            ),
          ),
        );

        expect(find.text('Complex'), findsOneWidget);
        expect(find.text('Button'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      test('should handle extreme blur calculation values', () {
        // Test with very large values
        final largeBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: 1000.0,
          contentComplexity: 10.0,
          isInteractive: false,
          distanceFromBackground: 5.0,
        );
        expect(largeBlur, equals(50.0)); // Should be clamped

        // Test with very small values
        final smallBlur = BlurUtils.calculateOptimalBlur(
          baseIntensity: 0.001,
          contentComplexity: 0.1,
          isInteractive: true,
          distanceFromBackground: 0.1,
        );
        expect(smallBlur, greaterThanOrEqualTo(0.0));
      });
    });
  });
}
