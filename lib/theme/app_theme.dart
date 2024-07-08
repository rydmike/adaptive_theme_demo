import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_scheme.dart';
import 'app_theme_extension.dart';
import 'comfortable_platform_density.dart';
import 'instant_splash.dart';
import 'text_style_fix.dart';
import 'theme_settings.dart';
import 'theme_tokens.dart';

/// The platform adaptive application theme design for our app.
sealed class AppTheme {
  /// Select the used theme, based on theme settings and brightness.
  static ThemeData use(Brightness brightness, ThemeSettings settings) {
    // Convenience to check if theme is light or dark.
    final bool isLight = brightness == Brightness.light;

    // Get our app color scheme based on the brightness.
    // When making custom component themes we typically need to use the app's
    // ColorScheme to make sure our component designs match the rest of the app.
    final ColorScheme scheme =
        isLight ? AppColorScheme.light : AppColorScheme.dark;

    // Define a custom platform adaptive visual density.
    // We also need to use this in a component theme (ToggleButtons) that does
    // not have built-in visual density support.
    final VisualDensity visualDensity = comfortablePlatformDensity;

    // Let's make a custom ThemeData object. It's fun! Right!? :)
    return ThemeData(
      // For demo purposes M2 is supported, but don't use Material-2 in Flutter
      // anymore in a new app. In this example we can still try it to see what
      // this demo and all widgets look like with it if we so desire.
      useMaterial3: settings.useMaterial3,

      // Pass the ColorScheme to the theme. We do not need to set the
      // brightness property in the ThemeData factory, passing a ColorScheme
      // takes care of it, as it already contains the brightness.
      colorScheme: scheme,

      // Make sure our theme and its colors apply to all Cupertino widgets,
      // without this `CupertinoSwitch` and `Switch.adaptive` will use the
      // default iOS colors, system green, we do not want that, we want it to
      // match our primary color.
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),

      // 1) Add our custom density.
      visualDensity: visualDensity,

      // 2) Add our custom instant splash factory on none Android and web
      // platforms. For the Android we pass null so we get the defaults.
      splashFactory:
          ThemeTokens.isNotAndroidOrIsWeb ? InstantSplash.splashFactory : null,

      // 3) We use M3 Typography, even if you still use M2 mode I recommend this
      // as it is a much nicer default.
      typography: Typography.material2021(
        platform: defaultTargetPlatform,
        colorScheme: scheme,
      ),

      // 4) Fix the ThemeData legacy divider color to match our ColorScheme.
      //    Planned to be deprecated in ThemeData.
      dividerColor: scheme.outlineVariant,

      // 5) Fix legacy primary colors and secondary header color.
      //    Planned to be deprecated in ThemeData.
      primaryColor: scheme.primary,
      primaryColorDark: isLight ? scheme.secondary : scheme.onPrimary,
      primaryColorLight: isLight ? scheme.secondaryContainer : scheme.secondary,
      secondaryHeaderColor:
          isLight ? scheme.primaryContainer : scheme.secondaryContainer,

      // 6) Fix legacy surface colors.
      //    Planned to be deprecated in ThemeData.
      canvasColor: scheme.surface,
      cardColor: scheme.surface,
      scaffoldBackgroundColor: scheme.surface,
      dialogBackgroundColor: scheme.surface,

      // Add our component theme customizations.

      // 7) AppBar
      //
      // We use a custom AppBarTheme with a custom color mapping with slight
      // opacity and very minor scroll under elevation that with shadow
      // will look like a faint underline in light theme mode.
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface.withOpacity(isLight ? 0.96 : 0.95),
        foregroundColor: scheme.secondary,
        elevation: 0,
        scrolledUnderElevation: isLight ? 0.5 : 2,
        shadowColor: scheme.shadow,
        centerTitle: defaultTargetPlatform == TargetPlatform.iOS,
        surfaceTintColor:
            ThemeTokens.isNotAndroidOrIsWeb ? scheme.outline : scheme.primary,
        // Adding this shape makes the scroll under effect animate as it should.
        // See issue: https://github.com/flutter/flutter/issues/131042
        shape: const RoundedRectangleBorder(),
        titleTextStyle: appBarTextStyle(scheme),
      ),

      // 8) ElevatedButton with custom color mapping and adaptive shape.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          shape:
              ThemeTokens.isNotAndroidOrIsWeb ? ThemeTokens.buttonsShape : null,
        ),
      ),
      // 9) Custom adaptive shape on other buttons
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape:
              ThemeTokens.isNotAndroidOrIsWeb ? ThemeTokens.buttonsShape : null,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape:
              ThemeTokens.isNotAndroidOrIsWeb ? ThemeTokens.buttonsShape : null,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape:
              ThemeTokens.isNotAndroidOrIsWeb ? ThemeTokens.buttonsShape : null,
        ),
      ),

      // 10) ToggleButtons Theme, made to match the filled and outline buttons.
      toggleButtonsTheme: ToggleButtonsThemeData(
        borderWidth: ThemeTokens.outlineWidth,
        selectedColor: scheme.onPrimary,
        color: scheme.primary,
        fillColor: scheme.primary,
        borderColor: scheme.outline,
        selectedBorderColor: scheme.primary,
        hoverColor: scheme.primary.withAlpha(0x14),
        focusColor: scheme.primary.withAlpha(0x1F),
        highlightColor: scheme.primary.withAlpha(0x14),
        splashColor: scheme.primary.withAlpha(0x1F),
        disabledColor: scheme.onSurface.withAlpha(0x61),
        disabledBorderColor: scheme.onSurface.withAlpha(0x1F),
        borderRadius: ThemeTokens.isNotAndroidOrIsWeb
            ? ThemeTokens.borderRadius
            : ThemeTokens.borderRadiusStadiumLike,
        constraints: BoxConstraints(
          minWidth: ThemeTokens.toggleButtonMinSize.width -
              ThemeTokens.outlineWidth * 2 +
              visualDensity.baseSizeAdjustment.dx,
          minHeight: ThemeTokens.toggleButtonMinSize.height -
              ThemeTokens.outlineWidth * 2 +
              visualDensity.baseSizeAdjustment.dy,
        ),
      ),

      // 11) SegmentedButton, made to match the filled tonal button, but with
      // an outline.
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
            shape: ThemeTokens.isNotAndroidOrIsWeb
                ? ThemeTokens.buttonsShape
                : null),
      ),

      // 12) The old button theme still has some usage, like aligning the
      // DropdownButton and DropdownButtonFormField to their parent.
      buttonTheme: const ButtonThemeData(alignedDropdown: true),

      // 13) FloatingActionButton.
      // With custom color mapping and classic round and stadium shapes.
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        shape: const StadiumBorder(),
      ),

      // 14) ChipTheme
      // With custom color mapping and platform adaptive shape, were it is
      // stadium shaped on none Android platform to not look like the buttons,
      // while on Android it is using default slightly rounded corners.
      // We also want smaller and more compact Chips.
      chipTheme: ChipThemeData(
        labelStyle:
            textThemeFromStyles.labelSmall!.copyWith(color: scheme.onSurface),
        padding: const EdgeInsets.all(4.0),
        backgroundColor:
            isLight ? scheme.primaryContainer : scheme.outlineVariant,
        shape: ThemeTokens.isNotAndroidOrIsWeb ? const StadiumBorder() : null,
      ),

      // 15) On none Android platforms we use an iOS like Switch theme,
      // but on Android we use the default style.
      // This will give u an iOS like on none Android platforms when we use
      // vanilla Switch.
      //
      // If we use Switch.adaptive we will get the actual iOS Switch on iOS
      // and macOS, it will use the ColorScheme colors and not iOS default
      // system green. The none iOS and macOS adaptive response will be
      // be the the themed vanilla Switch and Android default on Android, but
      // the themed iOS look alike Switch on e.g. Windows and Linux.
      switchTheme: ThemeTokens.isNotAndroidOrIsWeb ? switchTheme(scheme) : null,

      // 16) NavigationBar
      // We want a navigation bar that is slightly transparent and with more
      // distinct and clear selection indication. Also the default height 80
      // wastes space, so we make it lower.
      // The default background in light mode is also a bit to dark, so we
      // make it a bit lighter in light mode.
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: isLight
            ? scheme.surfaceContainerLow.withOpacity(0.96)
            : scheme.surfaceContainer.withOpacity(0.95),
        indicatorColor: scheme.primary,
        iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          return IconThemeData(
            size: 24.0,
            color: states.contains(WidgetState.disabled)
                ? scheme.onSurfaceVariant.withOpacity(0.38)
                : states.contains(WidgetState.selected)
                    ? scheme.onPrimary
                    : scheme.onSurfaceVariant,
          );
        }),
      ),

      // 17) Input decorator
      // Input decorator is one of the more confusing components to theme.
      // Here we use the same custom style on all platforms.
      inputDecorationTheme: inputTheme(scheme),

      // 18) Dropdown menu theme
      // We need to match the dropdown menu to the input decoration theme.
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: inputTheme(scheme),
      ),

      // 19) Dialog theme
      // We use a custom dialog theme with a custom color mapping and shadow.
      dialogTheme: DialogTheme(
        backgroundColor:
            isLight ? scheme.surfaceContainerLow : scheme.surfaceContainerHigh,
        shadowColor: scheme.shadow,
      ),

      // 20) Custom time picker style.
      timePickerTheme: TimePickerThemeData(
        backgroundColor:
            isLight ? scheme.surfaceContainerLow : scheme.surfaceContainerHigh,
      ),

      // 21) Custom date picker style.
      datePickerTheme: DatePickerThemeData(
        backgroundColor:
            isLight ? scheme.surfaceContainerLow : scheme.surfaceContainerHigh,
        headerBackgroundColor: scheme.primaryContainer,
        headerForegroundColor: scheme.onPrimaryContainer,
        dividerColor: Colors.transparent,
        shadowColor: scheme.shadow,
      ),

      // 22) Add a custom TextTheme made from TextStyles
      textTheme: textThemeFromStyles,

      // 23) Add a custom TextTheme with GoogleFonts.nnnTextTheme
      primaryTextTheme: googleFontsTextTheme,

      // 24) Add all our custom theme extensions.
      //
      // Demonstrate font animation and color and harmonization.
      extensions: <ThemeExtension<dynamic>>{
        AppThemeExtension.make(scheme, settings.zoomBlogFonts)
      },
    );
  }

  // 15 a) A custom SwitchTheme that resembles an iOS Switch.
  // The intention is that feels familiar on iOS and can ne used as platform
  // agnostic on others.
  static SwitchThemeData switchTheme(ColorScheme scheme) {
    final bool isLight = scheme.brightness == Brightness.light;
    return SwitchThemeData(
      thumbIcon:
          WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
        return const Icon(Icons.minimize, color: Colors.transparent);
      }),
      trackOutlineColor:
          WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        return Colors.transparent;
      }),
      trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary.withOpacity(0.5);
          }
          return scheme.onSurface.withOpacity(0.07);
        }
        if (states.contains(WidgetState.selected)) {
          return scheme.primary;
        }
        return scheme.surfaceContainerHighest;
      }),
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return isLight ? scheme.surface : scheme.onSurface.withOpacity(0.7);
        }
        return Colors.white;
      }),
    );
  }

  // 17 a) A custom input decoration theme.
  //
  // Making a cool and nice InputDecorationThemes is one of the most tedious
  // and honestly annoying and tricky things to do in Flutter theming. You could
  // do a 2 hour talk and demo about this alone. Here is the "simple" example
  // we used in this demo app, to make a rather nice one.
  //
  // Since you typically need the input theme in other components too,
  // it is a good idea good to define it separately so you can re-use its
  // definition in other component themes.
  static InputDecorationTheme inputTheme(ColorScheme scheme) {
    final bool isLight = scheme.brightness == Brightness.light;
    return InputDecorationTheme(
      filled: true,
      fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withOpacity(0.04);
        }
        return isLight
            ? scheme.primary.withOpacity(0.06)
            : scheme.primary.withOpacity(0.15);
      }),
      prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withOpacity(0.38);
        }
        if (states.contains(WidgetState.error)) {
          return scheme.error;
        }
        if (states.contains(WidgetState.focused)) {
          return scheme.primary;
        }
        return scheme.onSurfaceVariant;
      }),
      floatingLabelStyle:
          WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        const TextStyle textStyle = TextStyle();
        if (states.contains(WidgetState.disabled)) {
          return textStyle.copyWith(color: scheme.onSurface.withOpacity(0.38));
        }
        if (states.contains(WidgetState.error)) {
          return textStyle.copyWith(color: scheme.error);
        }
        if (states.contains(WidgetState.hovered)) {
          return textStyle.copyWith(color: scheme.onSurfaceVariant);
        }
        if (states.contains(WidgetState.focused)) {
          return textStyle.copyWith(color: scheme.primary);
        }
        return textStyle.copyWith(color: scheme.onSurfaceVariant);
      }),
      border: MaterialStateOutlineInputBorder.resolveWith(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return const OutlineInputBorder(
            borderRadius: ThemeTokens.borderRadius,
            borderSide: BorderSide.none,
          );
        }
        if (states.contains(WidgetState.error)) {
          if (states.contains(WidgetState.focused)) {
            return OutlineInputBorder(
              borderRadius: ThemeTokens.borderRadius,
              borderSide: BorderSide(color: scheme.error, width: 2.0),
            );
          }
          return OutlineInputBorder(
            borderRadius: ThemeTokens.borderRadius,
            borderSide: BorderSide(color: scheme.error),
          );
        }
        if (states.contains(WidgetState.focused)) {
          return OutlineInputBorder(
            borderRadius: ThemeTokens.borderRadius,
            borderSide: BorderSide(color: scheme.primary, width: 2.0),
          );
        }
        if (states.contains(WidgetState.hovered)) {
          return const OutlineInputBorder(
            borderRadius: ThemeTokens.borderRadius,
            borderSide: BorderSide.none,
          );
        }
        return const OutlineInputBorder(
          borderRadius: ThemeTokens.borderRadius,
          borderSide: BorderSide.none,
        );
      }),
    );
  }

  // 22 a) Make a TextTheme from TextStyles to customize more.
  // There is no color issue with GoogleFonts then since TextStyles
  // have null color by default.
  static TextTheme get textThemeFromStyles {
    final TextStyle light = GoogleFonts.lato(fontWeight: FontWeight.w300);
    final TextStyle regular = GoogleFonts.poppins(fontWeight: FontWeight.w400);
    final TextStyle medium = GoogleFonts.poppins(fontWeight: FontWeight.w500);
    final TextStyle semiBold = GoogleFonts.poppins(fontWeight: FontWeight.w600);

    return TextTheme(
      displayLarge: light.copyWith(fontSize: 54), // Default: regular, Size 57
      displayMedium: light.copyWith(fontSize: 42), // Default: regular
      displaySmall: light, // Default: regular
      headlineLarge: regular, //Default: regular
      headlineMedium: regular, // Default: regular
      headlineSmall: regular, // Default: regular
      titleLarge: semiBold.copyWith(fontSize: 20), // Default: regular, Size 22
      titleMedium: medium, // Default: medium
      titleSmall: medium, // Default: medium
      bodyLarge: regular, // Regular is default
      bodyMedium: regular, // Regular is default
      bodySmall: regular, // Regular is default
      labelLarge: medium.copyWith(fontSize: 15), // Default: medium, Size 14
      labelMedium: medium, // Default: medium
      labelSmall: medium, // Default: medium
    );
  }

  // 23 a) Get our custom GoogleFonts TextTheme: poppins
  // Issue: https://github.com/material-foundation/flutter-packages/issues/401
  static TextTheme get googleFontsTextTheme {
    // Add ".fixColors", remove it to see how text color breaks.
    return GoogleFonts.poppinsTextTheme().fixColors;
  }

  // 25) Make a totally custom text style for a component theme: AppBar
  //
  // Generally don't try to change the app's TexTheme and its TextStyle to make
  // a given component use a different style by adjusting the default style in
  // the ThemeData TextTheme it uses. Many other components may use the same
  // style as their default, and you may not want them to use the same style.
  // Instead make a new TextStyle that fits your component and use it in the
  // component theme.
  static TextStyle appBarTextStyle(ColorScheme scheme) {
    return GoogleFonts.lobster(
      fontWeight: FontWeight.w400,
      fontSize: 26,
      color: scheme.primary,
    );
  }

  // 26) A "semantic" text theme that we will use for custom content.
  //
  // Generally don't try to change the app's TexTheme and its TextStyle to fit
  // your content, instead make a new TextStyle that fits your content.
  // Then add it as a ThemeExtension to ThemeData.
  static TextStyle blogHeader(ColorScheme scheme, double fontSize) {
    return GoogleFonts.limelight(
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: scheme.onSurface,
    );
  }

  // 27) A "semantic" text style that we will use for custom content.
  static TextStyle blogBody(ColorScheme scheme, double fontSize) {
    return GoogleFonts.notoSerif(
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: scheme.onSurface,
    );
  }
}
