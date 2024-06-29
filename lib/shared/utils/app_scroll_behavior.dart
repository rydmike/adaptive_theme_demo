import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom drag scroll behavior class.
///
/// If we want to use the old style drag scroll that was in use on Flutter
/// stable 2.2.x and earlier, also on desktop and web we can use this scroll
/// behavior for the entire application.
///
/// Normally you would probably not use this scroll behavior in real
/// desktop/web apps, but I like it, so I use it when I can choose! :)
///
/// This is a Flutter class that only depends on the SDK and can be dropped
/// into any application.
@immutable
class DragScrollBehavior extends MaterialScrollBehavior {
  const DragScrollBehavior();
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

/// AppScrollBehavior with no implicit scrollbars on any platform.
///
/// Useful with nested listviews that need to share scroll controller
@immutable
class NoScrollbarBehavior extends DragScrollBehavior {
  const NoScrollbarBehavior();
  // Override for no scrollbars.
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
