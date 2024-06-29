import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'theme_tokens.dart';

/// The ColorScheme made from SeedColorScheme.fromSeeds.
///
/// Begin with figuring out your ColorScheme.
/// Here we map our app theme color tokens to the SeedColorScheme.fromSeeds
/// key colors and fixed scheme colors.
sealed class AppColorScheme {
  static final ColorScheme light = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: ThemeTokens.avocado,
    secondaryKey: ThemeTokens.avocadoRipe,
    tertiaryKey: ThemeTokens.avocadoCore,
    tones: FlexTones.candyPop(Brightness.light),
    // Color overrides to token values
    primary: ThemeTokens.avocado,
    primaryContainer: ThemeTokens.avocadoMeat,
    secondary: ThemeTokens.avocadoRipe,
    secondaryContainer: ThemeTokens.avocadoTender,
    tertiary: ThemeTokens.avocadoCore,
    tertiaryContainer: ThemeTokens.effectLight,
    onTertiaryContainer: ThemeTokens.effectDark,
  );
  static final ColorScheme dark = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: ThemeTokens.avocado,
    secondaryKey: ThemeTokens.avocadoRipe,
    tertiaryKey: ThemeTokens.avocadoCore,
    tones: FlexTones.candyPop(Brightness.dark),
    // Color overrides to token values
    primary: ThemeTokens.avocadoLush,
    primaryContainer: ThemeTokens.avocadoPrime,
    onPrimaryContainer: ThemeTokens.avocado,
    secondary: ThemeTokens.avocadoTender,
    secondaryContainer: ThemeTokens.avocadoRipe,
    tertiary: ThemeTokens.effectLight,
    onTertiary: ThemeTokens.effectDark,
    tertiaryContainer: ThemeTokens.avocadoCore,
    onTertiaryContainer: ThemeTokens.effectLight,
  );
}
