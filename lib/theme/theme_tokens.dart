import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Const theme token values.
///
/// These could be token definitions from a design made in Figma or other
/// 3rd party design tools that have been imported into Flutter.
sealed class ThemeTokens {
  // Colors used in the app brand palette.
  // These examples from: https://x.com/KhalidWarsa/status/1818631997280997752
  static const Color kwVerdigrisGreen = Color(0xFF5F6C37);
  static const Color kwMallardGreen = Color(0xFF273617);
  static const Color kwOffYellow = Color(0xFFFEFADF);
  static const Color kwDiSierraOrange = Color(0xFFDCA15D);
  static const Color kwBourbonOrange = Color(0xFFBC6C25);

  // Semantic color tokens for order status.
  static const Color receivedLight = Color(0xFF00257F);
  static const Color receivedDark = Color(0xFFC1CCFF);
  static const Color preparingLight = Color(0xFF045E72);
  static const Color preparingDark = Color(0xFFDBF5FF);
  static const Color deliveryLight = Color(0xFF00513D);
  static const Color deliveryDark = Color(0xFFBBFFE4);
  static const Color deliveredLight = Color(0xFF005305);
  static const Color deliveredDark = Color(0xFFCFFFC1);

  // Boolean for using our adaptive theme response or not.
  //
  // We will use a custom platform adaptive theme for anything else than
  // Android and we also always use it, if it is a web build.
  static bool isNotAndroidOrIsWeb =
      defaultTargetPlatform != TargetPlatform.android || kIsWeb;
  // Tokens for used button border radius on none Android platforms.
  static const double appRadius = 10.0;
  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(appRadius));
  static const OutlinedBorder buttonsShape = RoundedRectangleBorder(
    borderRadius: borderRadius,
  );
  // We need a stadium like border radius for our ToggleButtons on Android.
  // If we make it big enough, it will look like a stadium shape.
  static const BorderRadius borderRadiusStadiumLike =
      BorderRadius.all(Radius.circular(100));

  // Outlined width used by some styled buttons.
  static const double outlineWidth = 1.0;

  // Default minimum button size for ToggleButtons.
  // The values results in width 40 and height 40.
  // The Material-3 guide specifies width 48 and height 40. This is an
  // opinionated choice in order to make ToggleButtons min size squared.
  static const Size toggleButtonMinSize =
      Size(kMinInteractiveDimension - 8, kMinInteractiveDimension - 8);
}
