import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/const/app.dart';
import '../../theme/custom_overlays_style.dart';
import '../../theme/theme_settings.dart';
import '../widgets/app/about.dart';
import '../widgets/app/order_status/order_states_card.dart';
import '../widgets/blog_post_card.dart';
import '../widgets/universal/page_body.dart';
import '../widgets/universal/theme_mode_switch.dart';
import '../widgets/widget_cards.dart';
import 'components_demo_screen.dart';

/// Home page for the theme demo app.
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.settings,
    required this.onSettings,
  });

  final ThemeSettings settings;
  final ValueChanged<ThemeSettings> onSettings;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController scrollController;

  late List<Widget> content;

  @override
  void initState() {
    super.initState();
    scrollController =
        ScrollController(keepScrollOffset: true, initialScrollOffset: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    // The widgets we want to show in a long list view
    content = <Widget>[
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'This demo app allows us to see the platform adaptive theme '
          'style of "all" Material widgets.',
        ),
      ),
      const SizedBox(height: 8),
      ListTile(
        title: const Text('Theme mode'),
        subtitle: Text('Using ${widget.settings.themeMode.name}'),
        trailing: ThemeModeSwitch(
          themeMode: widget.settings.themeMode,
          onChanged: (ThemeMode mode) {
            widget.onSettings(
              widget.settings.copyWith(themeMode: mode),
            );
          },
        ),
        onTap: () {
          if (isDark) {
            widget.onSettings(
              widget.settings.copyWith(themeMode: ThemeMode.light),
            );
          } else {
            widget.onSettings(
              widget.settings.copyWith(themeMode: ThemeMode.dark),
            );
          }
        },
      ),
      const SizedBox(height: 8),
      SwitchListTile(
        title: const Text('Use Material 3'),
        value: widget.settings.useMaterial3,
        onChanged: (bool value) {
          widget.onSettings(
            widget.settings.copyWith(useMaterial3: value),
          );
        },
      ),
      ListTile(
        title: const Text('Page with Material widgets'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          await ComponentsDemoScreen.show(context);
        },
      ),
      // Custom widget token based style, no theme animation.
      const OrderStatesCard(useTheme: false),
      // Custom widget theme based style, has theme animation.
      const OrderStatesCard(useTheme: true),
      BlogPostCard(
        settings: widget.settings,
        onSettings: widget.onSettings,
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: ShowColorScheme(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: ButtonsSwitchesIconsShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: ToggleFabSwitchesChipsShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: TextInputFieldShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: AppTabBottomSearch(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: BottomNavigationBarsShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: NavigationRailShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: NavigationDrawerShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: DialogShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: BottomSheetSnackBannerShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: CardsShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: ListTileShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: TextThemeShow(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: PrimaryTextThemeShow(),
      ),
    ];
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.sizeOf(context);
    final EdgeInsets mediaPadding = MediaQuery.paddingOf(context);
    final double margins = App.responsiveInsets(mediaSize.width);
    final double topPadding = mediaPadding.top + kToolbarHeight + margins;
    final double bottomPadding = mediaPadding.bottom + margins;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: customOverlayStyle(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(App.title(context)),
          actions: const <Widget>[
            AboutIconButton(),
          ],
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: PageBody(
          controller: scrollController,
          constraints: const BoxConstraints(maxWidth: App.maxBodyWidth),
          child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(0, topPadding, 0, bottomPadding),
              itemCount: content.length,
              itemBuilder: (BuildContext context, int index) {
                return content.elementAt(index);
              }),
        ),
      ),
    );
  }
}
