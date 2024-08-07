import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/const/app.dart';
import '../../theme/custom_overlays_style.dart';
import '../../theme/theme_settings.dart';
import '../widgets/app/about.dart';
import '../widgets/app/blog_post/blog_post_card.dart';
import '../widgets/app/blog_post/blog_texts.dart';
import '../widgets/app/order_status/order_states_card.dart';
import '../widgets/app/widget_cards.dart';
import '../widgets/universal/responsive_center.dart';
import '../widgets/universal/theme_mode_icon_button.dart';
import '../widgets/universal/theme_mode_switch.dart';
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Size mediaSize = MediaQuery.sizeOf(context);
    final EdgeInsets mediaPadding = MediaQuery.paddingOf(context);
    final double margins = App.responsiveInsets(mediaSize.width);
    final double topPadding = mediaPadding.top + kToolbarHeight + margins;
    final double bottomPadding = mediaPadding.bottom + margins;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: customOverlayStyle(),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(App.title(context)),
            actions: <Widget>[
              ThemeModeIconButton(
                themeMode: widget.settings.themeMode,
                onChanged: (ThemeMode mode) {
                  widget.onSettings(widget.settings.copyWith(themeMode: mode));
                },
              ),
              const AboutIconButton(),
            ],
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: ResponsiveCenter(
            controller: scrollController,
            maxContentWidth: App.maxBodyWidth,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(0, topPadding, 0, bottomPadding),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'This app demonstrates platform adaptive theming and '
                    'other advanced theming features and shows the result.',
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
                SwitchListTile(
                  title: const Text('Zoom blog fonts theme'),
                  value: widget.settings.zoomBlogFonts,
                  onChanged: (bool value) {
                    widget.onSettings(
                      widget.settings.copyWith(zoomBlogFonts: value),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Page with colors and themed widgets'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    await ComponentsDemoScreen.show(context);
                  },
                ),
                // Token based style, no theme animation.
                const OrderStatesCard(useTheme: false),
                // Theme extension based styles, has theme animation.
                const OrderStatesCard(useTheme: true),
                // Demo text style theme extension, has size change animation.
                const BlogPostCard(
                    cardHeading: 'Blog Example',
                    blogHeading: BlogTexts.blogHeading1,
                    blogContent: BlogTexts.blogContent1),
                const BlogPostCard(
                    cardHeading: 'Another Blog Example',
                    blogHeading: BlogTexts.blogHeading2,
                    blogContent: BlogTexts.blogContent2),
                // Show the active ColorScheme
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: ShowColorScheme(),
                ),
                // Show various Material widgets
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
