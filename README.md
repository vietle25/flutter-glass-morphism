# Flutter Glass Morphism Plugin

A Flutter plugin implementing glassmorphism design with translucent, dynamic glass-like UI components featuring advanced blur, opacity, and visual effects that create stunning modern interfaces.

## Features

- **Water Droplet Effects**: Create realistic water droplet surfaces that magnify and distort background content
- **Lens Distortion**: Simulate the optical properties of liquid glass with magnification and refraction
- **Surface Tension**: Realistic droplet edges with surface tension effects
- **Specular Highlights**: Dynamic light reflections that simulate liquid surfaces
- **Multiple Droplet Patterns**: Scatter multiple droplets across surfaces for complex effects
- **Comprehensive Components**: Buttons, containers, cards, app bars, tab bars, dialogs, and more
- **Customizable Properties**: Adjust magnification, distortion strength, droplet curvature, and refractive index
- **Fluid Animations**: Smooth droplet formation and surface ripple effects
- **Performance Optimized**: Efficient custom painters and GPU-accelerated effects

## Demo

<img src="./assets/demo.gif" width="400" />


## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_glass_morphism: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Wrap your app with GlassMorphismThemeProvider

```dart
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  runApp(
    GlassMorphismThemeProvider(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
```

### 2. Use Glass Morphism Components

```dart
// Glass Morphism Button
GlassMorphismButton(
  onPressed: () => print('Button pressed'),
  child: Text('Glass Morphism Button'),
)

// Glass Morphism Container
GlassMorphismContainer(
  padding: EdgeInsets.all(16),
  child: Text('Glass container content'),
)

// Glass Morphism Card
GlassMorphismCard(
  child: Column(
    children: [
      Text('Card Title'),
      Text('Card content with glass effect'),
    ],
  ),
)
```

## Components

### GlassMorphismMaterial

The core material that provides the glass morphism effect with advanced visual properties:

```dart
GlassMorphismMaterial(
  blurIntensity: 20.0,
  opacity: 0.15,
  glassThickness: 1.0,
  tintColor: Colors.blue,
  borderRadius: BorderRadius.circular(12),
  enableBackgroundDistortion: true,
  enableGlassBorder: true,
  child: YourWidget(),
)
```

### GlassMorphismButton

Interactive buttons with glass effects:

```dart
GlassMorphismButton(
  onPressed: () {},
  style: GlassMorphismButtonStyle(
    backgroundColor: Colors.green,
    borderRadius: BorderRadius.circular(24),
    blurIntensity: 8.0,
  ),
  child: Text('Custom Button'),
)
```

### GlassMorphismAppBar

App bar with dynamic sizing and glass effects:

```dart
GlassMorphismAppBar(
  title: Text('My App'),
  enableDynamicSizing: true,
  scrollController: scrollController,
  actions: [
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {},
    ),
  ],
)
```

### GlassMorphismTabBar

Tab navigation with morphing effects:

```dart
GlassMorphismTabBar(
  controller: tabController,
  enableMorphing: true,
  tabs: [
    Tab(text: 'Home'),
    Tab(text: 'Explore'),
    Tab(text: 'Profile'),
  ],
)
```

### GlassMorphismDialog

Modal dialogs with glass backdrop:

```dart
GlassMorphismDialog.show(
  context: context,
  title: Text('Glass Dialog'),
  content: Text('Dialog with glass morphism effect'),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Close'),
    ),
  ],
)
```

### GlassMorphismBottomSheet

Bottom sheets with glass material:

```dart
GlassMorphismBottomSheet.show(
  context: context,
  enableDragHandle: true,
  child: Container(
    padding: EdgeInsets.all(24),
    child: Text('Bottom sheet content'),
  ),
)
```

## Theming

Customize the appearance of all glass morphism components:

```dart
GlassMorphismThemeProvider(
  data: GlassMorphismThemeData(
    defaultBlurIntensity: 12.0,
    defaultOpacity: 0.85,
    lightGlassColor: Color(0x80FFFFFF),
    darkGlassColor: Color(0x80000000),
    enableSpecularHighlights: true,
    buttonTheme: GlassMorphismButtonThemeData(
      height: 48.0,
      borderRadius: BorderRadius.circular(24),
    ),
    cardTheme: GlassMorphismCardThemeData(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  child: YourApp(),
)
```

## Advanced Usage

### Glass Droplet Effects

```dart
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

// Single glass droplet effect
GlassDropletEffect(
  dropletSize: 80.0,
  intensity: 0.8,
  position: Alignment(0.2, -0.3),
  child: YourWidget(),
)

// Multiple scattered droplets
MultipleGlassDropletsEffect(
  dropletCount: 5,
  minSize: 20.0,
  maxSize: 80.0,
  intensity: 0.6,
  child: YourWidget(),
)

// Glass lens magnification
GlassMorphismLensEffect(
  magnification: 1.4,
  lensRadius: 100.0,
  distortionStrength: 0.15,
  refractionIndex: 1.33,
  child: YourWidget(),
)
```

### Animated Glass Effects

```dart
class AnimatedGlassWidget extends StatefulWidget {
  @override
  _AnimatedGlassWidgetState createState() => _AnimatedGlassWidgetState();
}

class _AnimatedGlassWidgetState extends State<AnimatedGlassWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return GlassEffects.dynamicGlass(
      child: YourWidget(),
      animation: _controller,
      maxBlur: 20.0,
      minBlur: 5.0,
    );
  }
}
```

## Performance Considerations

- Blur effects can be performance-intensive on lower-end devices
- Use `BlurUtils.shouldEnableBlur()` to check device capabilities
- Consider reducing blur intensity for better performance
- Use `GlassMorphismThemeData.adaptiveColoring` for automatic optimization

## Platform Support

- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## Examples

Check out the [example app](example/) for a comprehensive demonstration of all components and features.

## Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Inspiration

This plugin is inspired by modern glassmorphism design trends and aims to bring sophisticated glass-like visual effects and fluid interactions to Flutter applications across all platforms.
