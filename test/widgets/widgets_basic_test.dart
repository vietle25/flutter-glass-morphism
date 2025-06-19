import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('Glass Morphism Widgets Basic Tests', () {
    testWidgets('GlassMorphismButton should render and handle tap',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: () => tapped = true,
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(GlassMorphismButton), findsOneWidget);

      await tester.tap(find.byType(GlassMorphismButton));
      expect(tapped, isTrue);
    });

    testWidgets('GlassMorphismContainer should render with child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismContainer(
              child: const Text('Container Content'),
            ),
          ),
        ),
      );

      expect(find.text('Container Content'), findsOneWidget);
      expect(find.byType(GlassMorphismContainer), findsOneWidget);
    });

    testWidgets('GlassMorphismCard should render with child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismCard(
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      expect(find.byType(GlassMorphismCard), findsOneWidget);
    });

    testWidgets('GlassMorphismAppBar should render with title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: GlassMorphismAppBar(
              title: const Text('App Title'),
            ),
          ),
        ),
      );

      expect(find.text('App Title'), findsOneWidget);
      expect(find.byType(GlassMorphismAppBar), findsOneWidget);
    });

    testWidgets('GlassMorphismTabBar should render with tabs',
        (WidgetTester tester) async {
      final controller = TabController(length: 2, vsync: tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismTabBar(
              controller: controller,
              tabs: const [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.byType(GlassMorphismTabBar), findsOneWidget);
    });

    testWidgets('GlassMorphismDialog should show and dismiss',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => GlassMorphismDialog(
                      title: const Text('Dialog Title'),
                      content: const Text('Dialog Content'),
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog Content'), findsOneWidget);
      expect(find.byType(GlassMorphismDialog), findsOneWidget);

      // Dismiss dialog
      await tester.tapAt(const Offset(10, 10)); // Tap outside dialog
      await tester.pumpAndSettle();

      expect(find.text('Dialog Content'), findsNothing);
    });

    testWidgets('GlassMorphismBottomSheet should show and dismiss',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => GlassMorphismBottomSheet(
                      child: const Text('Bottom Sheet Content'),
                    ),
                  );
                },
                child: const Text('Show Bottom Sheet'),
              ),
            ),
          ),
        ),
      );

      // Tap button to show bottom sheet
      await tester.tap(find.text('Show Bottom Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Bottom Sheet Content'), findsOneWidget);
      expect(find.byType(GlassMorphismBottomSheet), findsOneWidget);

      // Dismiss bottom sheet
      await tester.tapAt(const Offset(400, 100)); // Tap outside bottom sheet
      await tester.pumpAndSettle();

      expect(find.text('Bottom Sheet Content'), findsNothing);
    });

    testWidgets('All widgets should work with custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassMorphismContainer(
                  blurIntensity: 20.0,
                  opacity: 0.6,
                  child: const Text('Custom Container'),
                ),
                GlassMorphismCard(
                  blurIntensity: 15.0,
                  opacity: 0.7,
                  child: const Text('Custom Card'),
                ),
                GlassMorphismButton(
                  onPressed: () {},
                  style: const GlassMorphismButtonStyle(
                    blurIntensity: 10.0,
                    opacity: 0.8,
                  ),
                  child: const Text('Custom Button'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Custom Container'), findsOneWidget);
      expect(find.text('Custom Card'), findsOneWidget);
      expect(find.text('Custom Button'), findsOneWidget);
    });

    testWidgets('Widgets should work with theme provider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: GlassMorphismThemeProvider(
            child: Scaffold(
              body: Column(
                children: [
                  GlassMorphismContainer(
                    child: const Text('Themed Container'),
                  ),
                  GlassMorphismCard(
                    child: const Text('Themed Card'),
                  ),
                  GlassMorphismButton(
                    onPressed: () {},
                    child: const Text('Themed Button'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Container'), findsOneWidget);
      expect(find.text('Themed Card'), findsOneWidget);
      expect(find.text('Themed Button'), findsOneWidget);
      expect(find.byType(GlassMorphismThemeProvider), findsOneWidget);
    });

    testWidgets('Widgets should handle null children gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassMorphismContainer(),
                GlassMorphismCard(),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(GlassMorphismContainer), findsOneWidget);
      expect(find.byType(GlassMorphismCard), findsOneWidget);
    });

    testWidgets('Button should handle disabled state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphismButton(
              onPressed: null, // Disabled button
              child: const Text('Disabled Button'),
            ),
          ),
        ),
      );

      expect(find.text('Disabled Button'), findsOneWidget);
      expect(find.byType(GlassMorphismButton), findsOneWidget);
    });

    testWidgets('AppBar should work with actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: GlassMorphismAppBar(
              title: const Text('App with Actions'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('App with Actions'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('TabBar should handle tab selection',
        (WidgetTester tester) async {
      final controller = TabController(length: 3, vsync: tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassMorphismTabBar(
                  controller: controller,
                  tabs: const [
                    Tab(text: 'First'),
                    Tab(text: 'Second'),
                    Tab(text: 'Third'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: const [
                      Center(child: Text('First Tab')),
                      Center(child: Text('Second Tab')),
                      Center(child: Text('Third Tab')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
      expect(find.text('First Tab'), findsOneWidget);

      // Tap second tab
      await tester.tap(find.text('Second'));
      await tester.pumpAndSettle();

      expect(find.text('Second Tab'), findsOneWidget);
    });
  });
}
