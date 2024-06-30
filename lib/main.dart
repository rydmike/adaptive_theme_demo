import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'theme/app_theme.dart';
import 'theme/theme_settings.dart';
import 'ui/screens/home_screen.dart';

/// [AdaptiveThemeDemoApp] demonstrates the theme design for a fictive
/// company that sells mouth-watering salads and sandwiches with
/// avocado as the star ingredient.
///
/// They have theme color tokens inspired by the avocado fruit and
/// its different stages of ripeness.
///
/// Their theme is designed to be platform adaptive, with a Material 3
/// style on Android but more platform agnostic and Cupertino like on
/// all other platforms.
void main() {
  // To make it easy to observe some of the animations and transitions
  // in the demo, we slow down all animations a bit in debug mode.
  timeDilation = kDebugMode ? 1.5 : 1.0;
  runApp(const AdaptiveThemeDemoApp());
}

class AdaptiveThemeDemoApp extends StatefulWidget {
  const AdaptiveThemeDemoApp({super.key});

  @override
  State<AdaptiveThemeDemoApp> createState() => _AdaptiveThemeDemoAppState();
}

class _AdaptiveThemeDemoAppState extends State<AdaptiveThemeDemoApp> {
  // We just have simple data class with 3 properties for demo purposes.
  // No state management package is used in this example. We just pass the
  // data class around and modify it where needed via callbacks.
  ThemeSettings themeSettings = const ThemeSettings(
    useMaterial3: true,
    zoomBlogFonts: false,
    themeMode: ThemeMode.system,
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
