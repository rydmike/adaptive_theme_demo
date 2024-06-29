import 'package:flutter/material.dart';

// ignore_for_file: comment_references

/// App static functions and constants used in the demo application.
///
/// In a real app you probably prefer putting these into different sealed
/// classes that serves your application's usage. For these examples I
/// put them all in the same class, except the theme tokens that are in their
/// own theme related class.
sealed class App {
  /// Returns the title of the MaterialApp.
  ///
  /// Used to set title on pages to same one that is defined in its app name.
  /// Handy as we only need to update in one place, where it belongs and no
  /// need to put it as a const somewhere and no need to pass it around
  /// via a title prop either.
  ///
  /// Also used in the [showAppAboutDialog] About box as app name.
  static String title(BuildContext context) =>
      (context as Element).findAncestorWidgetOfExactType<MaterialApp>()!.title;

  // When building new public web versions of the demos, make sure to
  // update this info with current versions used for the build, before
  // triggering GitHub actions CI/CD that builds them.
  //
  // The name of the package this app demonstrates.
  static const String company = 'Avocado Deli';
  // Version of the WEB build, usually same as package, but it also has a
  // build numbers.
  static const String versionMajor = '1';
  static const String versionMinor = '0';
  static const String versionPatch = '0';
  static const String versionBuild = '01';
  static const String version = '$versionMajor.$versionMinor.$versionPatch '
      '\nBuild-$versionBuild';
  static const String appVersion = '$versionMajor.$versionMinor.$versionPatch';
  static const String appVersionMinor = '$versionMajor.$versionMinor.x';
  static const String flutterVersion = 'stable 3.22.2 (canvaskit)';
  static const String copyright = '© 2024';
  static const String author = 'Mike Rydstrom';
  static const String license = 'BSD 3-Clause License';
  static const String icon = 'assets/images/app_icon.png';
  static final Uri packageUri = Uri(
    scheme: 'https',
    host: 'pub.dev',
    path: 'packages/flex_seed_scheme',
  );

  /// The max dp width used for layout content on the screen in the available
  /// body area.
  ///
  /// Wider content gets growing side padding, kind of like on most
  /// web pages when they are used on super wide screen. This is typically used
  /// pages in the example apps that use content that is width constrained,
  /// typically via the [PageBody] screen content wrapper widget.
  static const double maxBodyWidth = 1000;

  /// The minimum media size needed for desktop/large tablet menu view,
  /// this is media size.
  ///
  /// Only at higher than this breakpoint will the menu expand from rail and
  /// be possible to toggle between menu and rail. Below this breakpoint it
  /// toggles between hidden in the Drawer and being a Rail, also on phones.
  /// This size was chosen because in combination codeViewWidthBreakpoint, it
  /// gives us a breakpoint where we get code side by side view in desktop
  /// rail mode already, and when it switches to menu mode, the desktop is
  /// wide enough to show both the full width menu and keep showing the
  /// code in side-by-side view. We could do lower the desktop width breakpoint,
  /// but then that view switches temporarily to now showing the code view,
  /// and it is just to much dynamic changes happening, it does not nice.
  static const double desktopWidthBreakpoint = 1700;

  /// This breakpoint is only used to further increase margins and insets on
  /// very large desktops.
  static const double bigDesktopWidthBreakpoint = 2800;

  /// The minimum media width treated as a phone device in this app.
  static const double phoneWidthBreakpoint = 600;

  /// The minimum media height treated as a phone device in this app.
  static const double phoneHeightBreakpoint = 700;

  /// Edge insets and margins for phone breakpoint size.
  static const double edgeInsetsPhone = 8;

  /// Edge insets and margins for tablet breakpoint size.
  static const double edgeInsetsTablet = 12;

  /// Edge insets and margins for desktop and medium desktop breakpoint sizes.
  static const double edgeInsetsDesktop = 18;

  /// Edge insets and margins for big desktop breakpoint size.
  static const double edgeInsetsBigDesktop = 24;

  /// Responsive insets based on width.
  ///
  /// The width may be from LayoutBuilder or
  /// MediaQuery, depending on what is appropriate for the use case.
  static double responsiveInsets(double width, [bool isCompact = false]) {
    if (width < phoneWidthBreakpoint || isCompact) return edgeInsetsPhone;
    if (width < desktopWidthBreakpoint) return edgeInsetsTablet;
    if (width < bigDesktopWidthBreakpoint) return edgeInsetsDesktop;
    return edgeInsetsBigDesktop;
  }
}
