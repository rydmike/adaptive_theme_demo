import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'theme/theme_settings.dart';
import 'ui/screens/home_screen.dart';

/// [AvoDelishApp] demonstrates the theme design for a fictive
/// company that sells mouth-watering salads and sandwiches with
/// avocado as the star ingredient.
void main() => runApp(const AvoDelishApp());

class AvoDelishApp extends StatefulWidget {
  const AvoDelishApp({super.key});

  @override
  State<AvoDelishApp> createState() => _AvoDelishAppState();
}

class _AvoDelishAppState extends State<AvoDelishApp> {
  ThemeSettings themeSettings = const ThemeSettings(
    useMaterial3: true,
    zoomBlogFonts: false,
    themeMode: ThemeMode.light,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avocado Deli',
      theme: AppTheme.use(Brightness.light, themeSettings),
      darkTheme: AppTheme.use(Brightness.dark, themeSettings),
      themeMode: themeSettings.themeMode,
      home: HomePage(
        settings: themeSettings,
        onSettings: (ThemeSettings settings) {
          setState(() {
            themeSettings = settings;
          });
        },
      ),
    );
  }
}
