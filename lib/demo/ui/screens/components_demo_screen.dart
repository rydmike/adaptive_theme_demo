import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/const/app.dart';
import '../../../shared/utils/app_scroll_behavior.dart';
import '../../theme/custom_overlays_style.dart';
import '../widgets/app/about.dart';
import '../widgets/app/show_color_scheme_colors.dart';
import '../widgets/app/show_sub_theme_colors.dart';
import '../widgets/app/show_theme_data_colors.dart';
import '../widgets/universal/page_body.dart';
import '../widgets/universal/showcase_material.dart';

/// This page is used as a demo in the app to show the themed Material
/// widgets in a sub page.
class ComponentsDemoScreen extends StatefulWidget {
  const ComponentsDemoScreen({super.key});

  // A static convenience function show this screen, as pushed on top.
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push<Widget>(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => const ComponentsDemoScreen(),
      ),
    );
  }

  @override
  State<ComponentsDemoScreen> createState() => _ComponentsDemoScreenState();
}

class _ComponentsDemoScreenState extends State<ComponentsDemoScreen> {
  int _buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle headlineMedium = theme.textTheme.headlineMedium!;

    final EdgeInsets padding = MediaQuery.paddingOf(context);
    final double topPadding = padding.top + kToolbarHeight * 2;
    final double bottomPadding = padding.bottom + kBottomNavigationBarHeight;

    final Size size = MediaQuery.sizeOf(context);
    final bool isNarrow = size.width < App.phoneWidthBreakpoint;
    final double sideMargin = isNarrow ? 8 : App.edgeInsetsTablet;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: customOverlayStyle(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          // For scrolling behind the app bar.
          extendBodyBehindAppBar: true,
          // For scrolling behind the bottom nav bar, if there is one.
          extendBody: true,
          appBar: AppBar(
            title: const Text('Page Demo'),
            actions: const <Widget>[AboutIconButton()],
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: 'Home'),
                Tab(text: 'Feed'),
                Tab(text: 'Settings'),
              ],
            ),
          ),
          body: PageBody(
            child: ScrollConfiguration(
              behavior: const NoScrollbarBehavior(),
              child: ListView(
                primary: true,
                padding: EdgeInsets.fromLTRB(
                  sideMargin,
                  topPadding + App.edgeInsetsTablet,
                  sideMargin,
                  App.edgeInsetsTablet + bottomPadding,
                ),
                children: <Widget>[
                  Text('Widgets Demo', style: headlineMedium),
                  const Text(
                    'This screen shows an example page with the same '
                    'ThemeData inherited theme being used. It also has a '
                    'NavigationBar and a TabBar in the AppBar',
                  ),
                  const SizedBox(height: 8),
                  // Show all key active theme colors.
                  Text('Colors', style: headlineMedium),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: App.edgeInsetsTablet),
                    child: ShowColorSchemeColors(showColorValue: false),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: App.edgeInsetsTablet),
                    child: ShowThemeDataColors(),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: App.edgeInsetsTablet),
                    child: ShowSubThemeColors(),
                  ),
                  const SizedBox(height: 16),
                  Text('Theme Showcase', style: headlineMedium),
                  const ShowcaseMaterial(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int value) {
              setState(() {
                _buttonIndex = value;
              });
            },
            selectedIndex: _buttonIndex,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.chat_bubble),
                label: 'Chat',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.beenhere),
                label: 'Tasks',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.create_new_folder),
                label: 'Archive',
                tooltip: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
