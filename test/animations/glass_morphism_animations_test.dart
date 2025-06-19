import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('GlassMorphismAnimations', () {
    group('Constants', () {
      test('should have correct duration constants', () {
        expect(GlassMorphismAnimations.standardDuration,
            equals(const Duration(milliseconds: 300)));
        expect(GlassMorphismAnimations.fastDuration,
            equals(const Duration(milliseconds: 150)));
        expect(GlassMorphismAnimations.slowDuration,
            equals(const Duration(milliseconds: 500)));
      });

      test('should have correct curve constants', () {
        expect(
            GlassMorphismAnimations.fluidCurve, equals(Curves.easeInOutCubic));
        expect(GlassMorphismAnimations.glassCurve, equals(Curves.elasticOut));
        expect(GlassMorphismAnimations.smoothCurve, equals(Curves.easeInOut));
      });
    });

    group('createMorphAnimation', () {
      late AnimationController controller;

      setUp(() {
        controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: const TestVSync(),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      test('should create animation with default values', () {
        final animation =
            GlassMorphismAnimations.createMorphAnimation(controller);

        expect(animation, isA<Animation<double>>());
        expect(animation.value, equals(0.0));
      });

      test('should create animation with custom values', () {
        final animation = GlassMorphismAnimations.createMorphAnimation(
          controller,
          begin: 0.5,
          end: 2.0,
          curve: Curves.bounceIn,
        );

        expect(animation, isA<Animation<double>>());
        expect(animation.value, equals(0.5));
      });

      test('should animate from begin to end', () {
        final animation = GlassMorphismAnimations.createMorphAnimation(
          controller,
          begin: 0.2,
          end: 0.8,
        );

        expect(animation.value, equals(0.2));

        controller.forward();
        controller.value = 1.0;

        expect(animation.value, equals(0.8));
      });

      test('should use specified curve', () {
        final animation = GlassMorphismAnimations.createMorphAnimation(
          controller,
          curve: Curves.linear,
        );

        controller.value = 0.5;
        expect(animation.value, equals(0.5));
      });
    });

    group('createScaleAnimation', () {
      late AnimationController controller;

      setUp(() {
        controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: const TestVSync(),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      test('should create scale animation with default values', () {
        final animation =
            GlassMorphismAnimations.createScaleAnimation(controller);

        expect(animation, isA<Animation<double>>());
        expect(animation.value, equals(1.0));
      });

      test('should create scale animation with custom values', () {
        final animation = GlassMorphismAnimations.createScaleAnimation(
          controller,
          begin: 0.8,
          end: 1.2,
          curve: Curves.bounceOut,
        );

        expect(animation.value, equals(0.8));

        controller.value = 1.0;
        expect(animation.value, equals(1.2));
      });

      test('should animate scale from begin to end', () {
        final animation = GlassMorphismAnimations.createScaleAnimation(
          controller,
          begin: 0.5,
          end: 1.5,
        );

        expect(animation.value, equals(0.5));

        controller.forward();
        controller.value = 1.0;

        expect(animation.value, equals(1.5));
      });
    });

    group('createGlowAnimation', () {
      late AnimationController controller;

      setUp(() {
        controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: const TestVSync(),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      test('should create glow animation with default values', () {
        final animation =
            GlassMorphismAnimations.createGlowAnimation(controller);

        expect(animation, isA<Animation<double>>());
        expect(animation.value, equals(0.0));
      });

      test('should create glow animation with custom values', () {
        final animation = GlassMorphismAnimations.createGlowAnimation(
          controller,
          begin: 0.3,
          end: 0.9,
          curve: Curves.easeIn,
        );

        expect(animation.value, equals(0.3));

        controller.value = 1.0;
        expect(animation.value, equals(0.9));
      });

      test('should animate glow intensity', () {
        final animation = GlassMorphismAnimations.createGlowAnimation(
          controller,
          begin: 0.0,
          end: 1.0,
        );

        controller.value = 0.5;
        expect(animation.value, greaterThan(0.0));
        expect(animation.value, lessThan(1.0));
      });
    });

    group('createBlurAnimation', () {
      late AnimationController controller;

      setUp(() {
        controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: const TestVSync(),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      test('should create blur animation with default values', () {
        final animation =
            GlassMorphismAnimations.createBlurAnimation(controller);

        expect(animation, isA<Animation<double>>());
        expect(animation.value, equals(0.0));
      });

      test('should create blur animation with custom values', () {
        final animation = GlassMorphismAnimations.createBlurAnimation(
          controller,
          begin: 5.0,
          end: 20.0,
          curve: Curves.fastOutSlowIn,
        );

        expect(animation.value, equals(5.0));

        controller.value = 1.0;
        expect(animation.value, equals(20.0));
      });

      test('should animate blur intensity', () {
        final animation = GlassMorphismAnimations.createBlurAnimation(
          controller,
          begin: 0.0,
          end: 15.0,
        );

        controller.value = 0.5;
        expect(animation.value, greaterThan(0.0));
        expect(animation.value, lessThan(15.0));
      });
    });

    group('createOpacityAnimation', () {
      late AnimationController controller;

      setUp(() {
        controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: const TestVSync(),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      test('should create opacity animation with default values', () {
        final animation =
            GlassMorphismAnimations.createOpacityAnimation(controller);

        expect(animation, isA<Animation<double>>());
        expect(animation.value, equals(0.0));
      });

      test('should create opacity animation with custom values', () {
        final animation = GlassMorphismAnimations.createOpacityAnimation(
          controller,
          begin: 0.2,
          end: 0.8,
          curve: Curves.decelerate,
        );

        expect(animation.value, equals(0.2));

        controller.value = 1.0;
        expect(animation.value, equals(0.8));
      });

      test('should animate opacity from transparent to opaque', () {
        final animation = GlassMorphismAnimations.createOpacityAnimation(
          controller,
          begin: 0.0,
          end: 1.0,
        );

        controller.value = 0.5;
        expect(animation.value, greaterThan(0.0));
        expect(animation.value, lessThan(1.0));
      });
    });

    group('createColorAnimation', () {
      late AnimationController controller;

      setUp(() {
        controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: const TestVSync(),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      test('should create color animation with required colors', () {
        final animation = GlassMorphismAnimations.createColorAnimation(
          controller,
          begin: Colors.red,
          end: Colors.blue,
        );

        expect(animation, isA<Animation<Color?>>());
        expect(animation.value, equals(Colors.red));
      });

      test('should create color animation with custom curve', () {
        final animation = GlassMorphismAnimations.createColorAnimation(
          controller,
          begin: Colors.green,
          end: Colors.yellow,
          curve: Curves.ease,
        );

        expect(animation.value, equals(Colors.green));

        controller.value = 1.0;
        expect(animation.value, equals(Colors.yellow));
      });

      test('should animate between colors', () {
        final animation = GlassMorphismAnimations.createColorAnimation(
          controller,
          begin: Colors.black,
          end: Colors.white,
        );

        controller.value = 0.5;
        final midColor = animation.value;
        expect(midColor, isNotNull);
        expect(midColor, isNot(equals(Colors.black)));
        expect(midColor, isNot(equals(Colors.white)));
      });

      test('should handle transparent colors', () {
        final animation = GlassMorphismAnimations.createColorAnimation(
          controller,
          begin: Colors.transparent,
          end: Colors.red.withOpacity(0.5),
        );

        expect(animation.value, equals(Colors.transparent));

        controller.value = 1.0;
        expect(animation.value, equals(Colors.red.withOpacity(0.5)));
      });
    });

    group('Edge Cases and Error Handling', () {
      late AnimationController controller;

      setUp(() {
        controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: const TestVSync(),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      test('should handle extreme animation values', () {
        final animation = GlassMorphismAnimations.createMorphAnimation(
          controller,
          begin: -100.0,
          end: 100.0,
        );

        expect(animation.value, equals(-100.0));

        controller.value = 1.0;
        expect(animation.value, equals(100.0));
      });

      test('should handle same begin and end values', () {
        final animation = GlassMorphismAnimations.createScaleAnimation(
          controller,
          begin: 1.0,
          end: 1.0,
        );

        expect(animation.value, equals(1.0));

        controller.value = 0.5;
        expect(animation.value, equals(1.0));

        controller.value = 1.0;
        expect(animation.value, equals(1.0));
      });

      test('should handle reverse animation direction', () {
        final animation = GlassMorphismAnimations.createOpacityAnimation(
          controller,
          begin: 1.0,
          end: 0.0,
        );

        expect(animation.value, equals(1.0));

        controller.value = 1.0;
        expect(animation.value, equals(0.0));
      });

      test('should work with different curve types', () {
        final curves = [
          Curves.linear,
          Curves.ease,
          Curves.bounceIn,
          Curves.elasticOut,
          Curves.fastOutSlowIn,
        ];

        for (final curve in curves) {
          final animation = GlassMorphismAnimations.createMorphAnimation(
            controller,
            curve: curve,
          );

          expect(animation, isA<Animation<double>>());
          expect(animation.value, equals(0.0));
        }
      });
    });
  });

  group('GlassMorphismTransition', () {
    group('Constructor and Default Values', () {
      testWidgets('should create with default values',
          (WidgetTester tester) async {
        const testChild = Text('Transition Test');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismTransition(
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Transition Test'), findsOneWidget);
        expect(find.byType(GlassMorphismTransition), findsOneWidget);
        expect(find.byType(AnimatedBuilder), findsWidgets);
      });

      testWidgets('should create with custom values',
          (WidgetTester tester) async {
        const testChild = Text('Custom Transition');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismTransition(
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceIn,
                animateOpacity: false,
                animateScale: true,
                animateSlide: true,
                slideOffset: const Offset(0.5, 0.5),
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Custom Transition'), findsOneWidget);
        expect(find.byType(GlassMorphismTransition), findsOneWidget);
      });

      test('should have correct default property values', () {
        const transition = GlassMorphismTransition(
          child: Text('Test'),
        );

        expect(transition.duration,
            equals(GlassMorphismAnimations.standardDuration));
        expect(transition.curve, equals(GlassMorphismAnimations.fluidCurve));
        expect(transition.animateOpacity, isTrue);
        expect(transition.animateScale, isFalse);
        expect(transition.animateSlide, isFalse);
        expect(transition.slideOffset, equals(const Offset(0, 0.1)));
      });

      test('should accept custom property values', () {
        const transition = GlassMorphismTransition(
          duration: Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          animateOpacity: false,
          animateScale: true,
          animateSlide: true,
          slideOffset: Offset(1.0, 0.5),
          child: Text('Test'),
        );

        expect(transition.duration, equals(const Duration(milliseconds: 800)));
        expect(transition.curve, equals(Curves.elasticOut));
        expect(transition.animateOpacity, isFalse);
        expect(transition.animateScale, isTrue);
        expect(transition.animateSlide, isTrue);
        expect(transition.slideOffset, equals(const Offset(1.0, 0.5)));
      });
    });

    group('Animation Behavior', () {
      testWidgets('should animate opacity when enabled',
          (WidgetTester tester) async {
        const testChild = Text('Opacity Animation');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismTransition(
                animateOpacity: true,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Opacity Animation'), findsOneWidget);
        expect(find.byType(FadeTransition), findsOneWidget);

        // Pump animation frames
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 200));

        expect(find.text('Opacity Animation'), findsOneWidget);
      });

      testWidgets('should animate scale when enabled',
          (WidgetTester tester) async {
        const testChild = Text('Scale Animation');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismTransition(
                animateOpacity: false,
                animateScale: true,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Scale Animation'), findsOneWidget);
        expect(find.byType(ScaleTransition), findsWidgets);
        expect(find.byType(FadeTransition), findsNothing);

        // Pump animation frames
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));

        expect(find.text('Scale Animation'), findsOneWidget);
      });

      testWidgets('should animate slide when enabled',
          (WidgetTester tester) async {
        const testChild = Text('Slide Animation');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismTransition(
                animateOpacity: false,
                animateSlide: true,
                slideOffset: const Offset(0, 1.0),
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Slide Animation'), findsOneWidget);
        expect(find.byType(SlideTransition), findsWidgets);
        expect(find.byType(FadeTransition), findsNothing);

        // Pump animation frames
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));

        expect(find.text('Slide Animation'), findsOneWidget);
      });

      testWidgets('should combine multiple animations',
          (WidgetTester tester) async {
        const testChild = Text('Combined Animations');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismTransition(
                animateOpacity: true,
                animateScale: true,
                animateSlide: true,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Combined Animations'), findsOneWidget);
        expect(find.byType(FadeTransition), findsWidgets);
        expect(find.byType(ScaleTransition), findsWidgets);
        expect(find.byType(SlideTransition), findsWidgets);

        // Pump animation frames
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pump(const Duration(milliseconds: 300));

        expect(find.text('Combined Animations'), findsOneWidget);
      });

      testWidgets('should complete animation cycle',
          (WidgetTester tester) async {
        const testChild = Text('Complete Animation');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassMorphismTransition(
                duration: const Duration(milliseconds: 200),
                child: testChild,
              ),
            ),
          ),
        );

        // Complete the animation
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200));

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
              body: GlassMorphismTransition(
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
              body: GlassMorphismTransition(
                duration: const Duration(milliseconds: 300),
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
              body: GlassMorphismTransition(
                duration: const Duration(milliseconds: 500),
                animateScale: true,
                child: testChild,
              ),
            ),
          ),
        );

        expect(find.text('Update Test'), findsOneWidget);
      });
    });
  });

  group('Edge Cases and Complex Scenarios', () {
    testWidgets('should handle different animation durations',
        (WidgetTester tester) async {
      const testChild = Text('Duration Test');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassMorphismTransition(
                  duration: GlassMorphismAnimations.fastDuration,
                  child: testChild,
                ),
                GlassMorphismTransition(
                  duration: GlassMorphismAnimations.standardDuration,
                  child: testChild,
                ),
                GlassMorphismTransition(
                  duration: GlassMorphismAnimations.slowDuration,
                  child: testChild,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Duration Test'), findsNWidgets(3));
      expect(find.byType(GlassMorphismTransition), findsNWidgets(3));
    });

    testWidgets('should handle different curves', (WidgetTester tester) async {
      const testChild = Text('Curve Test');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassMorphismTransition(
                  curve: GlassMorphismAnimations.fluidCurve,
                  child: testChild,
                ),
                GlassMorphismTransition(
                  curve: GlassMorphismAnimations.glassCurve,
                  child: testChild,
                ),
                GlassMorphismTransition(
                  curve: GlassMorphismAnimations.smoothCurve,
                  child: testChild,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Curve Test'), findsNWidgets(3));
      expect(find.byType(GlassMorphismTransition), findsNWidgets(3));
    });

    testWidgets('should handle extreme slide offsets',
        (WidgetTester tester) async {
      const testChild = Text('Extreme Offset');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTransition(
              animateSlide: true,
              slideOffset: const Offset(10.0, -10.0),
              child: testChild,
            ),
          ),
        ),
      );

      expect(find.text('Extreme Offset'), findsOneWidget);
      expect(find.byType(SlideTransition), findsOneWidget);
    });

    testWidgets('should work with complex child widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTransition(
              animateOpacity: true,
              animateScale: true,
              child: Column(
                children: [
                  const Text('Complex Child'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Button'),
                  ),
                  const Icon(Icons.animation),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Complex Child'), findsOneWidget);
      expect(find.text('Button'), findsOneWidget);
      expect(find.byIcon(Icons.animation), findsOneWidget);
      expect(find.byType(FadeTransition), findsWidgets);
      expect(find.byType(ScaleTransition), findsWidgets);
    });

    testWidgets('should work with nested transitions',
        (WidgetTester tester) async {
      const testChild = Text('Nested Transitions');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTransition(
              animateOpacity: true,
              child: GlassMorphismTransition(
                animateScale: true,
                child: testChild,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Nested Transitions'), findsOneWidget);
      expect(find.byType(GlassMorphismTransition), findsNWidgets(2));
      expect(find.byType(FadeTransition), findsWidgets);
      expect(find.byType(ScaleTransition), findsWidgets);
    });

    testWidgets('should handle zero duration', (WidgetTester tester) async {
      const testChild = Text('Zero Duration');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTransition(
              duration: Duration.zero,
              child: testChild,
            ),
          ),
        ),
      );

      expect(find.text('Zero Duration'), findsOneWidget);
      expect(find.byType(GlassMorphismTransition), findsOneWidget);
    });

    testWidgets('should handle very long duration',
        (WidgetTester tester) async {
      const testChild = Text('Long Duration');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTransition(
              duration: Duration(seconds: 10),
              child: testChild,
            ),
          ),
        ),
      );

      expect(find.text('Long Duration'), findsOneWidget);
      expect(find.byType(GlassMorphismTransition), findsOneWidget);
    });

    testWidgets('should handle all animations disabled',
        (WidgetTester tester) async {
      const testChild = Text('No Animations');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTransition(
              animateOpacity: false,
              animateScale: false,
              animateSlide: false,
              child: testChild,
            ),
          ),
        ),
      );

      expect(find.text('No Animations'), findsOneWidget);
      expect(find.byType(FadeTransition), findsNothing);
      expect(find.byType(ScaleTransition),
          findsWidgets); // Framework may add ScaleTransition
      expect(find.byType(SlideTransition), findsNothing);
    });

    testWidgets('should handle zero slide offset', (WidgetTester tester) async {
      const testChild = Text('Zero Offset');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTransition(
              animateSlide: true,
              slideOffset: Offset.zero,
              child: testChild,
            ),
          ),
        ),
      );

      expect(find.text('Zero Offset'), findsOneWidget);
      expect(find.byType(SlideTransition), findsWidgets);
    });
  });
}
