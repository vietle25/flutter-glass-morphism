import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  runApp(const GlassMorphismExampleApp());
}

class GlassMorphismExampleApp extends StatelessWidget {
  const GlassMorphismExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassMorphismThemeProvider(
      child: MaterialApp(
        title: 'Flutter Glass Morphism Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: const ExampleHomePage(),
      ),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  // Configuration parameters for live adjustment
  double _blurIntensity = 20.0;
  double _opacity = 0.15;
  double _glassThickness = 1.0;
  bool _enableBackgroundDistortion = true;
  bool _enableGlassBorder = true;
  Color _tintColor = Colors.blue;

  // Background options
  int _selectedBackground = 0;
  final List<String> _backgroundImages = [
    'https://picsum.photos/1200/800?random=1', // Random landscape 1
    'https://picsum.photos/1200/800?random=2', // Random landscape 2
    'https://picsum.photos/1200/800?random=3', // Random landscape 3
    'https://picsum.photos/1200/800?random=4', // Random landscape 4
    'https://picsum.photos/1200/800?random=5', // Random landscape 5
    'https://picsum.photos/1200/800?random=6', // Random landscape 6
    'https://picsum.photos/1200/800?random=7', // Random landscape 7
  ];

  final List<String> _backgroundNames = [
    'Nature 1',
    'Nature 2',
    'Nature 3',
    'Nature 4',
    'Nature 5',
    'Nature 6',
    'Nature 7',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: _selectedBackground < _backgroundImages.length
              ? DecorationImage(
                  image: NetworkImage(_backgroundImages[_selectedBackground]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                )
              : null,
          gradient: _selectedBackground >= _backgroundImages.length
              ? const RadialGradient(
                  center: Alignment.topLeft,
                  radius: 2.0,
                  colors: [
                    Color(0xFF4FC3F7), // Light blue
                    Color(0xFF29B6F6), // Medium blue
                    Color(0xFF0288D1), // Darker blue
                    Color(0xFF1976D2), // Deep blue
                    Color(0xFF303F9F), // Purple-blue
                    Color(0xFF512DA8), // Purple
                    Color(0xFF7B1FA2), // Deep purple
                    Color(0xFFAD1457), // Pink-purple
                    Color(0xFFE91E63), // Pink
                    Color(0xFFFF5722), // Red-orange
                  ],
                  stops: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0],
                )
              : null,
        ),
        child: Column(
          children: [
            GlassMorphismAppBar(
              title: const Text('Flutter Glass Morphism'),
              scrollController: _scrollController,
              opacity: 0.1,
              blurIntensity: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: _showSettingsDialog,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildConfigurationSection(),
                    const SizedBox(height: 24),
                    _buildButtonsSection(),
                    const SizedBox(height: 24),
                    _buildContainersSection(),
                    const SizedBox(height: 24),
                    _buildCardsSection(),
                    const SizedBox(height: 24),
                    _buildTabBarSection(),
                    const SizedBox(height: 24),
                    _buildInteractiveSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigurationSection() {
    return GlassMorphismCard(
      blurIntensity: _blurIntensity,
      opacity: _opacity,
      glassThickness: _glassThickness,
      enableBackgroundDistortion: _enableBackgroundDistortion,
      enableGlassBorder: _enableGlassBorder,
      tintColor: _tintColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Configuration',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          // Blur Intensity Slider
          Text('Blur Intensity: ${_blurIntensity.toStringAsFixed(1)}'),
          Slider(
            value: _blurIntensity,
            min: 0.0,
            max: 50.0,
            divisions: 45,
            onChanged: (value) {
              setState(() {
                _blurIntensity = value;
              });
            },
          ),

          // Opacity Slider
          Text('Opacity: ${_opacity.toStringAsFixed(2)}'),
          Slider(
            value: _opacity,
            min: 0.0,
            max: 0.5,
            divisions: 50,
            onChanged: (value) {
              setState(() {
                _opacity = value;
              });
            },
          ),

          // Glass Thickness Slider
          Text('Glass Thickness: ${_glassThickness.toStringAsFixed(1)}'),
          Slider(
            value: _glassThickness,
            min: 0.1,
            max: 3.0,
            divisions: 29,
            onChanged: (value) {
              setState(() {
                _glassThickness = value;
              });
            },
          ),

          // Toggle switches
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  title: const Text('Background Distortion'),
                  value: _enableBackgroundDistortion,
                  onChanged: (value) {
                    setState(() {
                      _enableBackgroundDistortion = value;
                    });
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  title: const Text('Glass Border'),
                  value: _enableGlassBorder,
                  onChanged: (value) {
                    setState(() {
                      _enableGlassBorder = value;
                    });
                  },
                ),
              ),
            ],
          ),

          // Background selector
          const SizedBox(height: 16),
          const Text('Background:'),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _backgroundImages.length + 1, // +1 for gradient option
              itemBuilder: (context, index) {
                final isGradient = index == _backgroundImages.length;
                final isSelected = _selectedBackground == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBackground = index;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : Border.all(color: Colors.white24, width: 1),
                      image: !isGradient
                          ? DecorationImage(
                              image: NetworkImage(_backgroundImages[index]),
                              fit: BoxFit.cover,
                            )
                          : null,
                      gradient: isGradient
                          ? const LinearGradient(
                              colors: [Color(0xFF4FC3F7), Color(0xFFFF5722)],
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        isGradient ? 'Gradient' : _backgroundNames[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Color picker
          const SizedBox(height: 16),
          const Text('Tint Color:'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              Colors.blue,
              Colors.green,
              Colors.purple,
              Colors.orange,
              Colors.red,
              Colors.teal,
              Colors.pink,
              Colors.indigo,
            ]
                .map((color) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _tintColor = color;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: _tintColor == color
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return GlassMorphismCard(
      blurIntensity: _blurIntensity,
      opacity: _opacity,
      glassThickness: _glassThickness,
      enableBackgroundDistortion: _enableBackgroundDistortion,
      enableGlassBorder: _enableGlassBorder,
      tintColor: _tintColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Glass Morphism Buttons',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlassMorphismButton(
                onPressed: () => _showSnackBar('Primary button pressed'),
                child: const Text('Primary'),
              ),
              GlassMorphismButton(
                onPressed: () => _showSnackBar('Secondary button pressed'),
                style: const GlassMorphismButtonStyle(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Secondary'),
              ),
              GlassMorphismButton(
                onPressed: () => _showSnackBar('Accent button pressed'),
                style: const GlassMorphismButtonStyle(
                  backgroundColor: Colors.orange,
                  opacity: 0.7,
                ),
                child: const Text('Accent'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glass Morphism Containers',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GlassMorphismContainer(
                height: 120,
                padding: const EdgeInsets.all(16),
                blurIntensity: _blurIntensity,
                opacity: _opacity,
                glassThickness: _glassThickness,
                enableBackgroundDistortion: _enableBackgroundDistortion,
                enableGlassBorder: _enableGlassBorder,
                tintColor: _tintColor,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud, size: 32, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Weather',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GlassMorphismContainer(
                height: 120,
                padding: const EdgeInsets.all(16),
                blurIntensity: _blurIntensity,
                opacity: _opacity,
                glassThickness: _glassThickness,
                enableBackgroundDistortion: _enableBackgroundDistortion,
                enableGlassBorder: _enableGlassBorder,
                tintColor: Colors.purple,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.music_note, size: 32, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Music',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glass Morphism Cards',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 16),
        GlassMorphismCard(
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured Content',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'This is an example of a liquid glass card with elevated appearance and blur effects.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _showSnackBar('Learn more pressed'),
                    child: const Text('Learn More'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glass Morphism Tab Bar',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 16),
        GlassMorphismTabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'Explore'),
            Tab(text: 'Profile'),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTabContent('Home', Icons.home),
              _buildTabContent('Explore', Icons.explore),
              _buildTabContent('Profile', Icons.person),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    return GlassMorphismContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white70),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Content for $title tab',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Interactive Elements',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 16),
        GlassMorphismButton(
          onPressed: _showBottomSheet,
          child: const Text('Show Bottom Sheet'),
        ),
        const SizedBox(height: 12),
        GlassMorphismButton(
          onPressed: _showDialog,
          style: const GlassMorphismButtonStyle(
            backgroundColor: Colors.teal,
          ),
          child: const Text('Show Dialog'),
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showBottomSheet() {
    GlassMorphismBottomSheet.show(
      context: context,
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Glass Morphism Bottom Sheet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'This is an example of a bottom sheet with glass morphism material design.',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GlassMorphismButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                GlassMorphismButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showSnackBar('Action performed');
                  },
                  style: const GlassMorphismButtonStyle(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Action'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    GlassMorphismDialog.show(
      context: context,
      title: const Text('Glass Morphism Dialog'),
      content: const Text(
        'This is an example of a dialog with glass morphism material design. '
        'It features blur effects and adaptive styling.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        GlassMorphismButton(
          onPressed: () {
            Navigator.pop(context);
            _showSnackBar('Confirmed');
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  void _showSettingsDialog() {
    GlassMorphismAlertDialog.show(
      context: context,
      title: 'Settings',
      content: 'Configure your glass morphism preferences here.',
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
