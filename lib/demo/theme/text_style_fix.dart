import 'package:flutter/material.dart';

/// TextStyle fixing utilities for GoogleFonts TextTheme.
sealed class TextStyleFix {
  /// Set font color to null in all styles in passed in [TextTheme] and
  /// return the new [TextTheme] other properties remain unchanged.
  ///
  /// This is used to fix issue:
  /// https://github.com/material-foundation/flutter-packages/issues/401
  static TextTheme nullFontColor(TextTheme textTheme) {
    /// Set font color to null in all styles in passed in [TextTheme] and
    return TextTheme(
      displayLarge: nullColor(textTheme.displayLarge!),
      displayMedium: nullColor(textTheme.displayMedium!),
      displaySmall: nullColor(textTheme.displaySmall!),
      //
      headlineLarge: nullColor(textTheme.headlineLarge!),
      headlineMedium: nullColor(textTheme.headlineMedium!),
      headlineSmall: nullColor(textTheme.headlineSmall!),
      //
      titleLarge: nullColor(textTheme.titleLarge!),
      titleMedium: nullColor(textTheme.titleMedium!),
      titleSmall: nullColor(textTheme.titleSmall!),
      //
      bodyLarge: nullColor(textTheme.bodyLarge!),
      bodyMedium: nullColor(textTheme.bodyMedium!),
      bodySmall: nullColor(textTheme.bodySmall!),
      //
      labelLarge: nullColor(textTheme.labelLarge!),
      labelMedium: nullColor(textTheme.labelMedium!),
      labelSmall: nullColor(textTheme.labelSmall!),
    );
  }

  /// Set font color to null in passed in [TextStyle] and
  /// return the new [TextStyle], other properties remain unchanged.
  static TextStyle nullColor(TextStyle style) {
    return TextStyle(
      color: null, // Set color to NULL, let ThemeData handle default.
      backgroundColor: style.backgroundColor,
      fontSize: style.fontSize,
      fontWeight: style.fontWeight,
      fontStyle: style.fontStyle,
      letterSpacing: style.letterSpacing,
      wordSpacing: style.wordSpacing,
      textBaseline: style.textBaseline,
      height: style.height,
      leadingDistribution: style.leadingDistribution,
      locale: style.locale,
      foreground: style.foreground,
      background: style.background,
      shadows: style.shadows,
      fontFeatures: style.fontFeatures,
      fontVariations: style.fontVariations,
      decoration: style.decoration,
      decorationColor: style.decorationColor,
      decorationStyle: style.decorationStyle,
      decorationThickness: style.decorationThickness,
      debugLabel: style.debugLabel,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
      overflow: style.overflow,
    );
  }
}

/// Extension for nicer looking usage of the GoogleFonts TextTheme fix utility.
extension FixGoogleFontsTextTheme on TextTheme {
  TextTheme get fixColors => TextStyleFix.nullFontColor(this);
}
