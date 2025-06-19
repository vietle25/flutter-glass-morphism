import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('GlassMorphismButton', () {
    testWidgets('should render with child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              child: const Text('Button'),
            ),
          ),
        ),
      );

      expect(find.text('Button'), findsOneWidget);
      expect(find.byType(GlassMorphismButton), findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () => pressed = true,
              child: const Text('Button'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GlassMorphismButton));
      expect(pressed, isTrue);
    });

    testWidgets('should handle long press events', (WidgetTester tester) async {
      bool longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              onLongPress: () => longPressed = true,
              child: const Text('Button'),
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(GlassMorphismButton));
      expect(longPressed, isTrue);
    });

    testWidgets('should be disabled when onPressed is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: null,
              child: const Text('Button'),
            ),
          ),
        ),
      );

      final button = tester.widget<GlassMorphismButton>(
        find.byType(GlassMorphismButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('should apply custom style', (WidgetTester tester) async {
      final customStyle = GlassMorphismButtonStyle(
        backgroundColor: Colors.red,
        height: 60.0,
        borderRadius: BorderRadius.circular(30),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              style: customStyle,
              child: const Text('Button'),
            ),
          ),
        ),
      );

      final button = tester.widget<GlassMorphismButton>(
        find.byType(GlassMorphismButton),
      );
      expect(button.style, equals(customStyle));
    });

    testWidgets('should handle autofocus property',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              autofocus: true,
              child: const Text('Button'),
            ),
          ),
        ),
      );

      final button = tester.widget<GlassMorphismButton>(
        find.byType(GlassMorphismButton),
      );
      expect(button.autofocus, isTrue);
    });

    testWidgets('should handle clip behavior', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              clipBehavior: Clip.antiAlias,
              child: const Text('Button'),
            ),
          ),
        ),
      );

      final button = tester.widget<GlassMorphismButton>(
        find.byType(GlassMorphismButton),
      );
      expect(button.clipBehavior, equals(Clip.antiAlias));
    });

    testWidgets('should animate on press', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              child: const Text('Button'),
            ),
          ),
        ),
      );

      // Test press animation
      await tester.press(find.byType(GlassMorphismButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Button'), findsOneWidget);
    });

    testWidgets('should work with theme provider', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: GlassMorphismThemeProvider(
            data: const GlassMorphismThemeData(
              buttonTheme: GlassMorphismButtonThemeData(
                height: 50.0,
              ),
            ),
            child: Scaffold(
              body: GlassMorphismButton(
                onPressed: () {},
                child: const Text('Button'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Button'), findsOneWidget);
      expect(find.byType(GlassMorphismButton), findsOneWidget);
    });

    testWidgets('should handle hover states on desktop',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              child: const Text('Button'),
            ),
          ),
        ),
      );

      // Simulate hover
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(GlassMorphismButton)));
      await tester.pump();

      expect(find.text('Button'), findsOneWidget);
    });

    testWidgets('should handle tap cancel', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () {},
              child: const Text('Button'),
            ),
          ),
        ),
      );

      // Start a tap but don't complete it
      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(GlassMorphismButton)),
      );
      await tester.pump();

      // Cancel the gesture
      await gesture.cancel();
      await tester.pump();

      expect(find.text('Button'), findsOneWidget);
    });
  });
}
