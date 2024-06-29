import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Const theme token values.
///
/// These could be token definitions from a design made in Figma or other
/// 3rd party design tools that have been imported into Flutter.
sealed class ThemeTokens {
  // Colors used in the app brand palette.
  static const Color avocado = Color(0xFF334601); // Verdun green, brand main
  static const Color avocadoRipe = Color(0xFF3F4925); // Woodland, brand sec
  static const Color avocadoLush = Color(0xFFC4D39D); // Pine glade, brand tert

  static const Color avocadoPrime = Color(0xFFFFFBD8); // Scotch mist, avo meat
  static const Color avocadoMeat = Color(0xFFFFF5AD); // Drover, avocado meat
  static const Color avocadoTender = Color(0xFFE2EEBC); // Caper avocado meat

  static const Color avocadoCore = Color(0xFF4C1C0A); // Van Cleef, avocado core
  static const Color effectLight = Color(0xFFF2B9CC); // Azalea, effect color
  static const Color effectDark = Color(0xFF3E0021); // Toledo, effect color

  // Semantic color token examples.
  static const Color receivedLight = Color(0xFF7E2549);
  static const Color receivedDark = Color(0xFFFFD9E2);
  static const Color preparingLight = Color(0xFF722082);
  static const Color preparingDark = Color(0xFFFFD5FF);
  static const Color deliveryLight = Color(0xFF004E5F);
  static const Color deliveryDark = Color(0xFFB4EBFF);
  static const Color deliveredLight = Color(0xFF145200);
  static const Color deliveredDark = Color(0xFFA6F786);

  // Tokens for used border radius.
  static const double appRadius = 10.0;
  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(appRadius));
  static const BorderRadius borderRadiusStadiumLike =
      BorderRadius.all(Radius.circular(100));
  static const OutlinedBorder buttonsShape = RoundedRectangleBorder(
    borderRadius: borderRadius,
  );
  // Outlined width used by styled buttons.
  static const double outlineWidth = 1.0;

  // Default minimum button size for ToggleButtons.
  // The values results in width 40 and height 40.
  // The Material-3 guide specifies width 48 and height 40. This is an
  // opinionated choice in order to make ToggleButtons min size squared.
  static const Size toggleButtonMinSize =
      Size(kMinInteractiveDimension - 8, kMinInteractiveDimension - 8);

  // We will use a custom platform adaptive theme for anything else than Android
  // on Android we will use the M3 defaults for Android.
  static bool adaptiveTheme =
      defaultTargetPlatform != TargetPlatform.android || kIsWeb;
}
