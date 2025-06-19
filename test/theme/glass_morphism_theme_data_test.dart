import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  group('GlassMorphismThemeData', () {
    group('Constructor and Default Values', () {
      test('should create with default values', () {
        const themeData = GlassMorphismThemeData();

        expect(themeData.defaultGlassColor, equals(const Color(0x80FFFFFF)));
        expect(themeData.lightGlassColor, equals(const Color(0x80FFFFFF)));
        expect(themeData.darkGlassColor, equals(const Color(0x80000000)));
        expect(themeData.defaultBlurIntensity, equals(10.0));
        expect(themeData.defaultOpacity, equals(0.8));
        expect(themeData.defaultBorderRadius,
            equals(const BorderRadius.all(Radius.circular(12))));
        expect(themeData.animationDuration,
            equals(const Duration(milliseconds: 300)));
        expect(themeData.enableSpecularHighlights, isTrue);
        expect(themeData.adaptiveColoring, isTrue);
        expect(themeData.buttonTheme, isA<GlassMorphismButtonThemeData>());
        expect(themeData.cardTheme, isA<GlassMorphismCardThemeData>());
        expect(themeData.appBarTheme, isA<GlassMorphismAppBarThemeData>());
      });

      test('should create with custom values', () {
        const customThemeData = GlassMorphismThemeData(
          defaultGlassColor: Colors.blue,
          lightGlassColor: Colors.white,
          darkGlassColor: Colors.black,
          defaultBlurIntensity: 20.0,
          defaultOpacity: 0.5,
          defaultBorderRadius: BorderRadius.all(Radius.circular(8)),
          animationDuration: Duration(milliseconds: 500),
          enableSpecularHighlights: false,
          adaptiveColoring: false,
          buttonTheme: GlassMorphismButtonThemeData(height: 60.0),
          cardTheme: GlassMorphismCardThemeData(blurIntensity: 15.0),
          appBarTheme: GlassMorphismAppBarThemeData(height: 64.0),
        );

        expect(customThemeData.defaultGlassColor, equals(Colors.blue));
        expect(customThemeData.lightGlassColor, equals(Colors.white));
        expect(customThemeData.darkGlassColor, equals(Colors.black));
        expect(customThemeData.defaultBlurIntensity, equals(20.0));
        expect(customThemeData.defaultOpacity, equals(0.5));
        expect(customThemeData.defaultBorderRadius,
            equals(const BorderRadius.all(Radius.circular(8))));
        expect(customThemeData.animationDuration,
            equals(const Duration(milliseconds: 500)));
        expect(customThemeData.enableSpecularHighlights, isFalse);
        expect(customThemeData.adaptiveColoring, isFalse);
        expect(customThemeData.buttonTheme.height, equals(60.0));
        expect(customThemeData.cardTheme.blurIntensity, equals(15.0));
        expect(customThemeData.appBarTheme.height, equals(64.0));
      });
    });

    group('copyWith', () {
      test('should copy with no changes when no parameters provided', () {
        const original = GlassMorphismThemeData();
        final copied = original.copyWith();

        expect(copied, equals(original));
        expect(copied.defaultGlassColor, equals(original.defaultGlassColor));
        expect(copied.lightGlassColor, equals(original.lightGlassColor));
        expect(copied.darkGlassColor, equals(original.darkGlassColor));
        expect(
            copied.defaultBlurIntensity, equals(original.defaultBlurIntensity));
        expect(copied.defaultOpacity, equals(original.defaultOpacity));
        expect(
            copied.defaultBorderRadius, equals(original.defaultBorderRadius));
        expect(copied.animationDuration, equals(original.animationDuration));
        expect(copied.enableSpecularHighlights,
            equals(original.enableSpecularHighlights));
        expect(copied.adaptiveColoring, equals(original.adaptiveColoring));
        expect(copied.buttonTheme, equals(original.buttonTheme));
        expect(copied.cardTheme, equals(original.cardTheme));
        expect(copied.appBarTheme, equals(original.appBarTheme));
      });

      test('should copy with single parameter change', () {
        const original = GlassMorphismThemeData();
        final copied = original.copyWith(defaultBlurIntensity: 25.0);

        expect(copied.defaultBlurIntensity, equals(25.0));
        expect(copied.defaultGlassColor, equals(original.defaultGlassColor));
        expect(copied.lightGlassColor, equals(original.lightGlassColor));
        expect(copied.darkGlassColor, equals(original.darkGlassColor));
        expect(copied.defaultOpacity, equals(original.defaultOpacity));
      });

      test('should copy with multiple parameter changes', () {
        const original = GlassMorphismThemeData();
        final copied = original.copyWith(
          defaultGlassColor: Colors.red,
          defaultBlurIntensity: 15.0,
          enableSpecularHighlights: false,
          animationDuration: const Duration(milliseconds: 400),
        );

        expect(copied.defaultGlassColor, equals(Colors.red));
        expect(copied.defaultBlurIntensity, equals(15.0));
        expect(copied.enableSpecularHighlights, isFalse);
        expect(copied.animationDuration,
            equals(const Duration(milliseconds: 400)));
        // Unchanged values should remain the same
        expect(copied.lightGlassColor, equals(original.lightGlassColor));
        expect(copied.darkGlassColor, equals(original.darkGlassColor));
        expect(copied.defaultOpacity, equals(original.defaultOpacity));
        expect(copied.adaptiveColoring, equals(original.adaptiveColoring));
      });

      test('should copy with all parameters changed', () {
        const original = GlassMorphismThemeData();
        final copied = original.copyWith(
          defaultGlassColor: Colors.green,
          lightGlassColor: Colors.lightGreen,
          darkGlassColor: Colors.green.shade800,
          defaultBlurIntensity: 30.0,
          defaultOpacity: 0.6,
          defaultBorderRadius: const BorderRadius.all(Radius.circular(20)),
          animationDuration: const Duration(milliseconds: 600),
          enableSpecularHighlights: false,
          adaptiveColoring: false,
          buttonTheme: const GlassMorphismButtonThemeData(height: 50.0),
          cardTheme: const GlassMorphismCardThemeData(blurIntensity: 18.0),
          appBarTheme: const GlassMorphismAppBarThemeData(height: 70.0),
        );

        expect(copied.defaultGlassColor, equals(Colors.green));
        expect(copied.lightGlassColor, equals(Colors.lightGreen));
        expect(copied.darkGlassColor, equals(Colors.green.shade800));
        expect(copied.defaultBlurIntensity, equals(30.0));
        expect(copied.defaultOpacity, equals(0.6));
        expect(copied.defaultBorderRadius,
            equals(const BorderRadius.all(Radius.circular(20))));
        expect(copied.animationDuration,
            equals(const Duration(milliseconds: 600)));
        expect(copied.enableSpecularHighlights, isFalse);
        expect(copied.adaptiveColoring, isFalse);
        expect(copied.buttonTheme.height, equals(50.0));
        expect(copied.cardTheme.blurIntensity, equals(18.0));
        expect(copied.appBarTheme.height, equals(70.0));
      });
    });

    group('Equality and HashCode', () {
      test('should be equal when all properties are the same', () {
        const themeData1 = GlassMorphismThemeData();
        const themeData2 = GlassMorphismThemeData();

        expect(themeData1, equals(themeData2));
        expect(themeData1.hashCode, equals(themeData2.hashCode));
      });

      test('should be equal when created with same custom values', () {
        const themeData1 = GlassMorphismThemeData(
          defaultGlassColor: Colors.blue,
          defaultBlurIntensity: 15.0,
          enableSpecularHighlights: false,
        );
        const themeData2 = GlassMorphismThemeData(
          defaultGlassColor: Colors.blue,
          defaultBlurIntensity: 15.0,
          enableSpecularHighlights: false,
        );

        expect(themeData1, equals(themeData2));
        expect(themeData1.hashCode, equals(themeData2.hashCode));
      });

      test('should not be equal when properties differ', () {
        const themeData1 = GlassMorphismThemeData();
        const themeData2 = GlassMorphismThemeData(defaultBlurIntensity: 15.0);

        expect(themeData1, isNot(equals(themeData2)));
        expect(themeData1.hashCode, isNot(equals(themeData2.hashCode)));
      });

      test('should be identical when same instance', () {
        const themeData = GlassMorphismThemeData();

        expect(identical(themeData, themeData), isTrue);
        expect(themeData == themeData, isTrue);
      });

      test('should not be equal to different type', () {
        const themeData = GlassMorphismThemeData();
        const other = 'not a theme data';

        expect(themeData == other, isFalse);
      });

      test('should not be equal when individual properties differ', () {
        const base = GlassMorphismThemeData();

        final differentColor = base.copyWith(defaultGlassColor: Colors.red);
        final differentBlur = base.copyWith(defaultBlurIntensity: 20.0);
        final differentOpacity = base.copyWith(defaultOpacity: 0.5);
        final differentRadius = base.copyWith(
            defaultBorderRadius: const BorderRadius.all(Radius.circular(8)));
        final differentDuration =
            base.copyWith(animationDuration: const Duration(milliseconds: 500));
        final differentHighlights =
            base.copyWith(enableSpecularHighlights: false);
        final differentAdaptive = base.copyWith(adaptiveColoring: false);

        expect(base, isNot(equals(differentColor)));
        expect(base, isNot(equals(differentBlur)));
        expect(base, isNot(equals(differentOpacity)));
        expect(base, isNot(equals(differentRadius)));
        expect(base, isNot(equals(differentDuration)));
        expect(base, isNot(equals(differentHighlights)));
        expect(base, isNot(equals(differentAdaptive)));
      });
    });

    group('Immutability', () {
      test('should be immutable', () {
        const themeData = GlassMorphismThemeData();

        // Verify that the class is marked as @immutable
        expect(themeData, isA<GlassMorphismThemeData>());

        // Verify that copyWith returns a new instance
        final copied = themeData.copyWith(defaultBlurIntensity: 15.0);
        expect(identical(themeData, copied), isFalse);
        expect(
            themeData.defaultBlurIntensity, equals(10.0)); // Original unchanged
        expect(copied.defaultBlurIntensity, equals(15.0)); // Copy changed
      });
    });
  });

  group('GlassMorphismButtonThemeData', () {
    group('Constructor and Default Values', () {
      test('should create with default values', () {
        const buttonTheme = GlassMorphismButtonThemeData();

        expect(buttonTheme.height, equals(48.0));
        expect(buttonTheme.padding,
            equals(const EdgeInsets.symmetric(horizontal: 24, vertical: 12)));
        expect(buttonTheme.borderRadius,
            equals(const BorderRadius.all(Radius.circular(24))));
        expect(buttonTheme.blurIntensity, equals(8.0));
        expect(buttonTheme.opacity, equals(0.9));
      });

      test('should create with custom values', () {
        const buttonTheme = GlassMorphismButtonThemeData(
          height: 60.0,
          padding: EdgeInsets.all(16),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          blurIntensity: 15.0,
          opacity: 0.7,
        );

        expect(buttonTheme.height, equals(60.0));
        expect(buttonTheme.padding, equals(const EdgeInsets.all(16)));
        expect(buttonTheme.borderRadius,
            equals(const BorderRadius.all(Radius.circular(12))));
        expect(buttonTheme.blurIntensity, equals(15.0));
        expect(buttonTheme.opacity, equals(0.7));
      });
    });

    group('copyWith', () {
      test('should copy with no changes when no parameters provided', () {
        const original = GlassMorphismButtonThemeData();
        final copied = original.copyWith();

        expect(copied, equals(original));
        expect(copied.height, equals(original.height));
        expect(copied.padding, equals(original.padding));
        expect(copied.borderRadius, equals(original.borderRadius));
        expect(copied.blurIntensity, equals(original.blurIntensity));
        expect(copied.opacity, equals(original.opacity));
      });

      test('should copy with single parameter change', () {
        const original = GlassMorphismButtonThemeData();
        final copied = original.copyWith(height: 56.0);

        expect(copied.height, equals(56.0));
        expect(copied.padding, equals(original.padding));
        expect(copied.borderRadius, equals(original.borderRadius));
        expect(copied.blurIntensity, equals(original.blurIntensity));
        expect(copied.opacity, equals(original.opacity));
      });

      test('should copy with multiple parameter changes', () {
        const original = GlassMorphismButtonThemeData();
        final copied = original.copyWith(
          height: 52.0,
          blurIntensity: 12.0,
          opacity: 0.8,
        );

        expect(copied.height, equals(52.0));
        expect(copied.blurIntensity, equals(12.0));
        expect(copied.opacity, equals(0.8));
        expect(copied.padding, equals(original.padding));
        expect(copied.borderRadius, equals(original.borderRadius));
      });

      test('should copy with all parameters changed', () {
        const original = GlassMorphismButtonThemeData();
        final copied = original.copyWith(
          height: 64.0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          blurIntensity: 20.0,
          opacity: 0.6,
        );

        expect(copied.height, equals(64.0));
        expect(copied.padding,
            equals(const EdgeInsets.symmetric(horizontal: 32, vertical: 16)));
        expect(copied.borderRadius,
            equals(const BorderRadius.all(Radius.circular(16))));
        expect(copied.blurIntensity, equals(20.0));
        expect(copied.opacity, equals(0.6));
      });
    });

    group('Equality and HashCode', () {
      test('should be equal when all properties are the same', () {
        const buttonTheme1 = GlassMorphismButtonThemeData();
        const buttonTheme2 = GlassMorphismButtonThemeData();

        expect(buttonTheme1, equals(buttonTheme2));
        expect(buttonTheme1.hashCode, equals(buttonTheme2.hashCode));
      });

      test('should not be equal when properties differ', () {
        const buttonTheme1 = GlassMorphismButtonThemeData();
        const buttonTheme2 = GlassMorphismButtonThemeData(height: 56.0);

        expect(buttonTheme1, isNot(equals(buttonTheme2)));
        expect(buttonTheme1.hashCode, isNot(equals(buttonTheme2.hashCode)));
      });

      test('should be identical when same instance', () {
        const buttonTheme = GlassMorphismButtonThemeData();

        expect(identical(buttonTheme, buttonTheme), isTrue);
        expect(buttonTheme == buttonTheme, isTrue);
      });

      test('should not be equal to different type', () {
        const buttonTheme = GlassMorphismButtonThemeData();
        const other = 'not a button theme';

        expect(buttonTheme == other, isFalse);
      });
    });
  });

  group('GlassMorphismCardThemeData', () {
    group('Constructor and Default Values', () {
      test('should create with default values', () {
        const cardTheme = GlassMorphismCardThemeData();

        expect(cardTheme.margin, equals(const EdgeInsets.all(8)));
        expect(cardTheme.padding, equals(const EdgeInsets.all(16)));
        expect(cardTheme.borderRadius,
            equals(const BorderRadius.all(Radius.circular(16))));
        expect(cardTheme.blurIntensity, equals(12.0));
        expect(cardTheme.opacity, equals(0.85));
      });

      test('should create with custom values', () {
        const cardTheme = GlassMorphismCardThemeData(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(20),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          blurIntensity: 18.0,
          opacity: 0.7,
        );

        expect(cardTheme.margin, equals(const EdgeInsets.all(12)));
        expect(cardTheme.padding, equals(const EdgeInsets.all(20)));
        expect(cardTheme.borderRadius,
            equals(const BorderRadius.all(Radius.circular(20))));
        expect(cardTheme.blurIntensity, equals(18.0));
        expect(cardTheme.opacity, equals(0.7));
      });
    });

    group('copyWith', () {
      test('should copy with no changes when no parameters provided', () {
        const original = GlassMorphismCardThemeData();
        final copied = original.copyWith();

        expect(copied, equals(original));
        expect(copied.margin, equals(original.margin));
        expect(copied.padding, equals(original.padding));
        expect(copied.borderRadius, equals(original.borderRadius));
        expect(copied.blurIntensity, equals(original.blurIntensity));
        expect(copied.opacity, equals(original.opacity));
      });

      test('should copy with single parameter change', () {
        const original = GlassMorphismCardThemeData();
        final copied = original.copyWith(blurIntensity: 15.0);

        expect(copied.blurIntensity, equals(15.0));
        expect(copied.margin, equals(original.margin));
        expect(copied.padding, equals(original.padding));
        expect(copied.borderRadius, equals(original.borderRadius));
        expect(copied.opacity, equals(original.opacity));
      });

      test('should copy with multiple parameter changes', () {
        const original = GlassMorphismCardThemeData();
        final copied = original.copyWith(
          margin: const EdgeInsets.all(10),
          blurIntensity: 14.0,
          opacity: 0.9,
        );

        expect(copied.margin, equals(const EdgeInsets.all(10)));
        expect(copied.blurIntensity, equals(14.0));
        expect(copied.opacity, equals(0.9));
        expect(copied.padding, equals(original.padding));
        expect(copied.borderRadius, equals(original.borderRadius));
      });

      test('should copy with all parameters changed', () {
        const original = GlassMorphismCardThemeData();
        final copied = original.copyWith(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(24),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          blurIntensity: 20.0,
          opacity: 0.8,
        );

        expect(copied.margin, equals(const EdgeInsets.all(6)));
        expect(copied.padding, equals(const EdgeInsets.all(24)));
        expect(copied.borderRadius,
            equals(const BorderRadius.all(Radius.circular(12))));
        expect(copied.blurIntensity, equals(20.0));
        expect(copied.opacity, equals(0.8));
      });
    });

    group('Equality and HashCode', () {
      test('should be equal when all properties are the same', () {
        const cardTheme1 = GlassMorphismCardThemeData();
        const cardTheme2 = GlassMorphismCardThemeData();

        expect(cardTheme1, equals(cardTheme2));
        expect(cardTheme1.hashCode, equals(cardTheme2.hashCode));
      });

      test('should not be equal when properties differ', () {
        const cardTheme1 = GlassMorphismCardThemeData();
        const cardTheme2 = GlassMorphismCardThemeData(blurIntensity: 15.0);

        expect(cardTheme1, isNot(equals(cardTheme2)));
        expect(cardTheme1.hashCode, isNot(equals(cardTheme2.hashCode)));
      });

      test('should be identical when same instance', () {
        const cardTheme = GlassMorphismCardThemeData();

        expect(identical(cardTheme, cardTheme), isTrue);
        expect(cardTheme == cardTheme, isTrue);
      });

      test('should not be equal to different type', () {
        const cardTheme = GlassMorphismCardThemeData();
        const other = 'not a card theme';

        expect(cardTheme == other, isFalse);
      });
    });
  });

  group('GlassMorphismAppBarThemeData', () {
    group('Constructor and Default Values', () {
      test('should create with default values', () {
        const appBarTheme = GlassMorphismAppBarThemeData();

        expect(appBarTheme.height, equals(56.0));
        expect(appBarTheme.blurIntensity, equals(15.0));
        expect(appBarTheme.opacity, equals(0.95));
        expect(appBarTheme.enableDynamicSizing, isTrue);
      });

      test('should create with custom values', () {
        const appBarTheme = GlassMorphismAppBarThemeData(
          height: 64.0,
          blurIntensity: 20.0,
          opacity: 0.8,
          enableDynamicSizing: false,
        );

        expect(appBarTheme.height, equals(64.0));
        expect(appBarTheme.blurIntensity, equals(20.0));
        expect(appBarTheme.opacity, equals(0.8));
        expect(appBarTheme.enableDynamicSizing, isFalse);
      });
    });

    group('copyWith', () {
      test('should copy with no changes when no parameters provided', () {
        const original = GlassMorphismAppBarThemeData();
        final copied = original.copyWith();

        expect(copied, equals(original));
        expect(copied.height, equals(original.height));
        expect(copied.blurIntensity, equals(original.blurIntensity));
        expect(copied.opacity, equals(original.opacity));
        expect(
            copied.enableDynamicSizing, equals(original.enableDynamicSizing));
      });

      test('should copy with single parameter change', () {
        const original = GlassMorphismAppBarThemeData();
        final copied = original.copyWith(height: 72.0);

        expect(copied.height, equals(72.0));
        expect(copied.blurIntensity, equals(original.blurIntensity));
        expect(copied.opacity, equals(original.opacity));
        expect(
            copied.enableDynamicSizing, equals(original.enableDynamicSizing));
      });

      test('should copy with multiple parameter changes', () {
        const original = GlassMorphismAppBarThemeData();
        final copied = original.copyWith(
          blurIntensity: 18.0,
          enableDynamicSizing: false,
        );

        expect(copied.blurIntensity, equals(18.0));
        expect(copied.enableDynamicSizing, isFalse);
        expect(copied.height, equals(original.height));
        expect(copied.opacity, equals(original.opacity));
      });

      test('should copy with all parameters changed', () {
        const original = GlassMorphismAppBarThemeData();
        final copied = original.copyWith(
          height: 80.0,
          blurIntensity: 25.0,
          opacity: 0.9,
          enableDynamicSizing: false,
        );

        expect(copied.height, equals(80.0));
        expect(copied.blurIntensity, equals(25.0));
        expect(copied.opacity, equals(0.9));
        expect(copied.enableDynamicSizing, isFalse);
      });
    });

    group('Equality and HashCode', () {
      test('should be equal when all properties are the same', () {
        const appBarTheme1 = GlassMorphismAppBarThemeData();
        const appBarTheme2 = GlassMorphismAppBarThemeData();

        expect(appBarTheme1, equals(appBarTheme2));
        expect(appBarTheme1.hashCode, equals(appBarTheme2.hashCode));
      });

      test('should not be equal when properties differ', () {
        const appBarTheme1 = GlassMorphismAppBarThemeData();
        const appBarTheme2 = GlassMorphismAppBarThemeData(height: 64.0);

        expect(appBarTheme1, isNot(equals(appBarTheme2)));
        expect(appBarTheme1.hashCode, isNot(equals(appBarTheme2.hashCode)));
      });

      test('should be identical when same instance', () {
        const appBarTheme = GlassMorphismAppBarThemeData();

        expect(identical(appBarTheme, appBarTheme), isTrue);
        expect(appBarTheme == appBarTheme, isTrue);
      });

      test('should not be equal to different type', () {
        const appBarTheme = GlassMorphismAppBarThemeData();
        const other = 'not an app bar theme';

        expect(appBarTheme == other, isFalse);
      });
    });
  });

  group('Integration Tests', () {
    test('should work together in main theme data', () {
      const buttonTheme = GlassMorphismButtonThemeData(height: 52.0);
      const cardTheme = GlassMorphismCardThemeData(blurIntensity: 14.0);
      const appBarTheme = GlassMorphismAppBarThemeData(height: 60.0);

      const themeData = GlassMorphismThemeData(
        buttonTheme: buttonTheme,
        cardTheme: cardTheme,
        appBarTheme: appBarTheme,
      );

      expect(themeData.buttonTheme, equals(buttonTheme));
      expect(themeData.cardTheme, equals(cardTheme));
      expect(themeData.appBarTheme, equals(appBarTheme));
      expect(themeData.buttonTheme.height, equals(52.0));
      expect(themeData.cardTheme.blurIntensity, equals(14.0));
      expect(themeData.appBarTheme.height, equals(60.0));
    });

    test('should maintain equality when nested themes are equal', () {
      const themeData1 = GlassMorphismThemeData(
        buttonTheme: GlassMorphismButtonThemeData(height: 50.0),
        cardTheme: GlassMorphismCardThemeData(opacity: 0.8),
      );

      const themeData2 = GlassMorphismThemeData(
        buttonTheme: GlassMorphismButtonThemeData(height: 50.0),
        cardTheme: GlassMorphismCardThemeData(opacity: 0.8),
      );

      expect(themeData1, equals(themeData2));
      expect(themeData1.hashCode, equals(themeData2.hashCode));
    });

    test('should not be equal when nested themes differ', () {
      const themeData1 = GlassMorphismThemeData(
        buttonTheme: GlassMorphismButtonThemeData(height: 50.0),
      );

      const themeData2 = GlassMorphismThemeData(
        buttonTheme: GlassMorphismButtonThemeData(height: 60.0),
      );

      expect(themeData1, isNot(equals(themeData2)));
    });

    test('should handle complex copyWith operations', () {
      const original = GlassMorphismThemeData();

      final step1 = original.copyWith(
        defaultBlurIntensity: 15.0,
        buttonTheme: const GlassMorphismButtonThemeData(height: 50.0),
      );

      final step2 = step1.copyWith(
        defaultOpacity: 0.7,
        cardTheme: const GlassMorphismCardThemeData(blurIntensity: 16.0),
      );

      expect(step2.defaultBlurIntensity, equals(15.0)); // From step1
      expect(step2.defaultOpacity, equals(0.7)); // From step2
      expect(step2.buttonTheme.height, equals(50.0)); // From step1
      expect(step2.cardTheme.blurIntensity, equals(16.0)); // From step2
      expect(step2.enableSpecularHighlights,
          equals(original.enableSpecularHighlights)); // Unchanged
    });
  });
}
