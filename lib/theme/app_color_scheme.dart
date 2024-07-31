import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'theme_tokens.dart';

/// The ColorScheme made from SeedColorScheme.fromSeeds.
///
/// Begin with figuring out your ColorScheme.
///
/// Here we map our app color design tokens to the SeedColorScheme.fromSeeds
/// key colors and pin color tokens to selected ColorScheme colors.
sealed class AppColorScheme {
  /// App's light ColorScheme.
  static final ColorScheme light = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,

    // Used seed key colors:
    primaryKey: ThemeTokens.kwVerdigrisGreen,
    // The orange colors we can use for tertiary and tertiaryContainer.
    // We seed with the more colorful one.
    tertiaryKey: ThemeTokens.kwBourbonOrange,
    // We don't use a seed for secondary, so it will be based on primary.
    // that usually works best with M3 color system, but sure if you want to go
    // nuts, you could use the yellow one here.
    //
    // secondaryKey: ThemeTokens.kwOffYellow,

    // We use the tones chroma that has colorfulness that is fully driven
    // by the given key colors' chromacity.
    // It also has very subtle color tint in surface colors.
    tones: FlexTones.chroma(Brightness.light),
    // If you want to make all surface shades monochrome, you can add this:
    // .monochromeSurfaces(),
    // Like so: tones: FlexTones.chroma(Brightness.light).monochromeSurfaces(),
    // And if still want Android to get some tint, then do this instead:
    // .monochromeSurfaces(ThemeTokens.isNotAndroidOrIsWeb),

    // Color overrides to design token values.
    //
    // TIP: Visualize the color scheme without any pinned colors first and
    // then see what colors you need to pin to get the desired result and where
    // the colors in your palette will fit in the generated color scheme,
    // considering its color and contrast requirements.

    // Here we go with the darker green source pinned for primary light:
    primary: ThemeTokens.kwMallardGreen,
    // You could also use the lighter one too, switch to see what you prefer:
    // primary: ThemeTokens.kwVerdigrisGreen,
    // If you do the the above, the I would remove the mapping of it to
    // secondary below.

    // We can use the lighter green on secondary in light mode.
    secondary: ThemeTokens.kwVerdigrisGreen,

    // The yellow one is tricky, the best place for it, where it kinds of fits
    // is as contrast color to secondary.
    onSecondary: ThemeTokens.kwOffYellow,
    // If you decide to seed with it as secondary seed color, then you get
    // more places where it will fit.

    // We can also tuck in the really dark green as its on color to secondary
    // container, if you want to use color expressive text/icons on it,
    // based on one of the token values.
    onSecondaryContainer: ThemeTokens.kwMallardGreen,

    // We uses the orange colors, for tertiary and tertiaryContainer.
    tertiary: ThemeTokens.kwBourbonOrange,
    tertiaryContainer: ThemeTokens.kwDiSierraOrange,
  );

  /// App's dark ColorScheme.
  static final ColorScheme dark = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    // Use the same key colors and tones as light mode in dark mode.
    primaryKey: ThemeTokens.kwVerdigrisGreen,
    tertiaryKey: ThemeTokens.kwBourbonOrange,
    tones: FlexTones.chroma(Brightness.dark),
    // Same with the monochrome surfaces here, this:
    // .monochromeSurfaces(),
    // or this:
    // .monochromeSurfaces(ThemeTokens.isNotAndroidOrIsWeb),

    // Color overrides to design token values.
    // Overrides are different from light mode, typically inverse selections,
    // but you can also deviate from this when appropriate as done here.
    primaryContainer: ThemeTokens.kwVerdigrisGreen,
    secondary: ThemeTokens.kwOffYellow,
    onSecondary: ThemeTokens.kwMallardGreen,

    // Tertiary just swap light mode pinned colors.
    tertiary: ThemeTokens.kwDiSierraOrange,
    tertiaryContainer: ThemeTokens.kwBourbonOrange,
  );
}
