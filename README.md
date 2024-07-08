Readme

# Adaptive Theming Demo at Fluttercon 2024

This is the repo used at the talk **"Everything Material All At Once"**, presented by Mike Rydstrom and Taha Tesser, July 4th, 2024, in Berlin at the **Fluttercon** conference.

This repo was used for the adaptive theming part in the talk.

## Theme Design Goal

We will create a custom theme that uses: 

* Multiple input colors to make a custom seed generated Colors scheme.
* The seeded ColorScheme contains our brand color tokens and is colorful.
* We have theme extensions for custom semantic colors and content text styles, their changes animate with the rest of theme changes.
* The AppBar theme shows some nice tricks.
* The application theme is platform adaptive, where:   
  * We only have animated Material spreading ink effect splash on Android, on all other platforms the splash taps are just an instant highlight color on tap. This makes tap interactions feel less "Material" like on iOS, desktop and web platforms.
  * Buttons have iOS like radius and style on other than Android platforms, but Material defaults on Android.
  * The Material Switch looks like an iOS switch on other than Android platforms, but as a Material Switch on Android.
  * The legacy ToggleButtons is themed to match the style of the FilledButton and OutlinedButton.
  * Chips are themed to be stadium shaped on none Android platforms, but Material rounded corners on Android. This gives them a style in both adaptive modes that differentiates them from the used button styles.

| iPhone iOS                                                                                                                         | Pixel Android                                                                                                                    |
|------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/iphone-demo.gif" alt="iPhone result demo" /> | <img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/pixel-demo.gif" alt="Pixel result demo" /> |


## Slides

You can find and watch the entire presentation deck used at the **Fluttercon24** talk **"Everything Material All At Once"** [here](https://docs.google.com/presentation/d/1-JH1vDJAjbj4XK-qb7le9hT7R-I_CW7THtPPUorJsTU/edit?usp=sharing). It also contains more extensive and detailed speaker notes, with additional useful information, than there was time to go into during the _"all at once"_ fast-paced and packed talk.


# Adaptive Theming

This part of the readme is still **work in progress**. While in WIP phase the doc additions are being committed as they are written, they will be incomplete and may have error. When the doc section is completed, this WIP info will be removed.

The intent is to make this readme into an article, describing the setup and how to achieve the adaptive theming in the demo. It will also explain some of the made choices and how they affect the app's look and feel.

## Design Tokens

Typically, in a custom branded app, we have one or two brand colors that must be present in our app's colors to some extent. In some cases, we may have an entire palette of colors that are part of the brand or desired ambiance of the app.

In this fictive example, we will use a palette of nine colors that create the brand and ambiance for a Deli, that has Avocado as their signature ingredient. The colors are shown below.

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/design_colors.png" alt="Design colors" />

Using and getting all these colors into a seed generated ColorScheme might seem challenging. In fact using more than just one seed color with Flutter's SDK and the `ColorScheme.fromSeed` API is not possible. How can we solve this start challenge?

To begin, let's first capture all the color values as static const values, so we van easily use them.

```dart
/// Const theme token values.
///
/// These could be token definitions from a design made in Figma or other
/// 3rd party design tools that have been imported into Flutter.
sealed class ThemeTokens {
  // Colors used in the app brand palette.
  static const Color avocado = Color(0xFF334601);
  static const Color avocadoRipe = Color(0xFF3F4925);
  static const Color avocadoLush = Color(0xFFC4D39D);

  static const Color avocadoPrime = Color(0xFFFFFBD8);
  static const Color avocadoMeat = Color(0xFFFFF5AD);
  static const Color avocadoTender = Color(0xFFE2EEBC);

  static const Color avocadoCore = Color(0xFF4C1C0A);
  static const Color effectLight = Color(0xFFF2B9CC);
  static const Color effectDark = Color(0xFF3E0021);
}
```

## Adaptive design 

In this example, we will create a custom theme that is adaptive to the platform it runs on. We will let Android use default Material-3 design when it comes to its shapes and interaction effects. While for all other platforms and also any build used on the web, we will use a more platform-agnostic design. It will be a bit more iOS like in its design for shapes and interaction effects.  

The choice to make our platform adaptive response impact web builds one all used platforms, means that when the app is run in a browser on Android, it will then also use the none Material default design. If you prefer, you could also make the platform adaptive response so that in a web browser on Android it also uses the default Material style. This might make more sense if you intend for the web build to be used as a PWA on Android devices. To use the PWA instead of compiled Android app, or as a solution for causal users that do not want to install an app. However, in this example, all web usage will look the same and use the none default Material design, while only the build as an Android app will use the Material default design. 

Some of our adaptive design examples are shown below:

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design1.png" alt="Adaptive design goals one" />
<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design2.png" alt="Adaptive design goals two" />
<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design3.png" alt="Adaptive design goals three" />
<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design4.png" alt="Adaptive design goals four" />


To achieve this design goal we weill add some additional design tokes to our `ThemeTokens` class. These will be used to determine if the build is an Android build or not, and if it is a web build or not. We will also add some design tokens that will be used to define the shape and style of the buttons, switches, and chips in the app. Mostly, these are just border radius and shapes that we will use on other platforms than Android. On Android, we will use the default Material-3 shapes.

```dart
/// Const theme token values.
///
/// These could be token definitions from a design made in Figma or other
/// 3rd party design tools that have been imported into Flutter.
sealed class ThemeTokens {
  // Colors used in the app brand palette.
  // : as above ...

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
```

### ColorScheme.fromSeed

If we seed the `ColorScheme` with `ThemeTokens.avocado` and pin it `primary` in light mode and `primaryContainer` in dark mode, we get these light and dark color schemes:

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/from_tonal_spot_l.png" alt="ColorScheme.fromSeed light using avocado token" />

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/from_tonal_spot_d.png" alt="ColorScheme.fromSeed light using avocado token" />

They do not fully represent the desired vibe and ambiance of color token palette.

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/design_colors_2.png" alt="Design colors 2" />

### SeedColorScheme.fromSeeds

Since `ColorScheme.fromSeed` can only use one seed color, we are going to take a pass on it and instead use a package that can generate a `ColorScheme` from multiple seed colors. We will use the [`flex_seed_scheme`](https://pub.dev/packages/flex_seed_scheme) package for this. With the `flex_seed_scheme` package we can use the `SeedColorScheme.fromSeeds` constructor to generate a `ColorScheme` from multiple seed colors. It also offers many other useful methods to tune and modify the generated `ColorScheme`.

In this example we not only use it to create a `ColorScheme` from multiple seed colors, we also create a `ColorScheme` that is **colorful**, which is what we want for our app. To do so, wew here as `tones` for the `ColorScheme` generation use the `FlexTones.chroma` configuration. It will create a colorful `ColorScheme` based on the chromacity of each seed color, or key colors, as they are called in the `flex_seed_scheme` package. If our key color inputs are colorful, then the generated ColorScheme will also be so.

As primary color we will use the `avocado` color, as secondary the `avocadoRipe` color. We selected the `avocadoRipe` color as secondary, as it is a color that is close to the primary color, but also a bit dimmer and less colorful that our primary `avocvado`selection. This selection fits well with the design intent of the Material-3 color system. 

As tertiary seed or key color, we use the `avocadoCore` color. This is intended to be used as an effect color when so desired in app. By default, the tertiary palette colors are rarely used by Material-3 components as their default colors. It is only used by default for one element in the Material time picker. We can change mappings on some components if we want to use tertiary colors more, but in this demo we will not do so.

You can always use any color in your `ColorScheme` by getting it with `Theme.of(context).colorScheme` and then using the color you want in your custom widgets, or as a one-off override on defaults for some built-in components too. However, if you want a built-in Material component to use another color than its default all the time, you should change the default color mapping by creating a component theme in your `ThemeData`, with the desired override. We will see a lot of usage of that in this example, just not with the `tetiary` colors.

To make our seed generated `ColorScheme` will also pin all the design color tokens to carefully selected `ColorScheme` colors, like the `primaryContainer` color to the `avocadoMeat` color in light mode, and to the `avocadoPrime` color in dark mode.


```dart
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
    primaryKey: ThemeTokens.avocado,
    secondaryKey: ThemeTokens.avocadoRipe,
    tertiaryKey: ThemeTokens.avocadoCore,
    // We use the tones chroma that has colorfulness that is fully driven
    // by the given key colors' chromacity. We also make all surface shades
    // monochrome on none Android builds or if it is a web build.
    tones: FlexTones.chroma(Brightness.light)
        .monochromeSurfaces(ThemeTokens.isNotAndroidOrIsWeb),

    // Color overrides to design token values.
    // TIP: Visualize the color scheme without any pinned colors first and
    // then see what colors you need to pin to get the desired result and where
    // the colors in your palette will fit in the generated color scheme.
    primary: ThemeTokens.avocado,
    primaryContainer: ThemeTokens.avocadoMeat,
    secondary: ThemeTokens.avocadoRipe,
    secondaryContainer: ThemeTokens.avocadoTender,
    tertiary: ThemeTokens.avocadoCore,
    tertiaryContainer: ThemeTokens.effectLight,
    onTertiaryContainer: ThemeTokens.effectDark,
  );

  /// App's dark ColorScheme.
  static final ColorScheme dark = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    // Use the same key colors and tones as light mode in dark mode.
    primaryKey: ThemeTokens.avocado,
    secondaryKey: ThemeTokens.avocadoRipe,
    tertiaryKey: ThemeTokens.avocadoCore,
    tones: FlexTones.chroma(Brightness.dark)
        .monochromeSurfaces(ThemeTokens.isNotAndroidOrIsWeb),

    // Color overrides to design token values.
    // Overrides are different from light mode, typically inverse selections, 
    // but you can also deviate from this when appropriate as done here.
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
```

The first colors to pin in light theme mode, is to pin the seed colors to the corresponding palette's main colors. So in this case, in light mode:
 
* The `primaryKey` color `ThemeTokens.avocado` is pinned to `primary`
* The `secondaryKey` color `ThemeTokens.avocadoRipe` is pinned to `secondary` 
* The `tertiaryKey` color `ThemeTokens.avocadoCore` is pinned to `tertiary`.  

This guarantees that the `ColorScheme`'s main colors `primary`, `seondary` and `tertiary` will have exactly the same color values as the important design tokens. Typically, the seed or key color values do not end up in the generated `ColorScheme` otherwise. This override works well when the seed colors have high chromacity (are colorful) and also have a brightness that prefers white or light contrast color. Typically, if you have brand colors that are intended to be used on white printed paper, they work fine as main colors in light theme mode.

Due to contrast issue of brand colors intended for printing on white paper, they may not always work well if pinned and used as main colors in dark mode. 

If we had only the three colors as our design tokens, and no colors suitable for dark mode, we would then typically pin them to `primaryContainer`, `secondaryContainer` and `tertiaryContainer`. This ensures the main colors are also present in dark mode. In this case we actually did so for the `secondaryContainer` and `tertiaryContainer` colors in dark mode. However, for `primaryContainer` we used `ThemeTokens.avocadoPrime`.

We also made sure to add all the rest of our `ThemeToken` colors to the `ColorScheme` as selected overrides in both light and dark mode for a few more colors. It is important to use care when doing so. Do it in a way that fits with the palettes generated by each seed color. As long as the override is a reasonable match in brightness and hue to the color generated by the respective seed color, it will work well. If the override is too different, it may not work as well. 

You may have noticed that we also used one of the `tones` modifier functions, in this case `.monochromeSurfaces()`. This modifier makes all the surface colors monochrome, it removes the slight primary color-based tint surface colors normally get in seed generated color schemes. There is one more twist, we use the boolean flag `ThemeTokens.isNotAndroidOrIsWeb` to trigger this method only when we build for any none Android platform, so Android builds will thus still use their signature Material-3 surface color tinting. 

It is also worth noticing that the `FlexTones.chroma` based seed generation configuration, is also **very** subtle in its surface color tinting, as typically `ColorScheme.fromSeed` and its `DynamicSchemeVariants` are too aggressive in their surface tinting, a matter of personal preference of course. 

### Result Light Mode

With the above settings we get a generated `ColorScheme` that incorporates all our design tokens and also is colorful and vibrant. It has a slight different result on Android, where there is a very subtle primary color tint in all the surface colors. This color tint is missing on iOS and all other none Android platforms, their surface colors are fully monochrome. 

The light mode `ColorScheme` result on iOS and all none Android platforms: 

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/result_ios_light.png" alt="ColorScheme result on iOS in light mode" />

The light mode `ColorScheme` result Android platform. There is a very subtle primary color tint in all the surface colors:

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/result_and_light.png" alt="ColorScheme result on Android in light mode" />

### Result Dark Mode

The dark mode `ColorScheme` result on iOS and all none Android platforms:

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/result_ios_dark.png" alt="ColorScheme result on iOS in dark mode" />

The dark mode `ColorScheme` result Android platform. There is a very subtle primary color tint in all the surface colors:

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/result_and_dark.png" alt="ColorScheme result on Android in dark mode" />

The tinting used on Android is quite subtle, the difference to the tinted version is not super obvious, but it is there. We could use more aggressive tinting if we wanted to on Android, but we chose to keep it very subtle. Typically, the surface tinting in Android is a bit too aggressive for our preference. With this demo we wanted to show a way to also make more subtle tinted surfaces with `flex_seed_scheme`. You can make totally custom tinting and color mapping to `ColorScheme` colors, with `flex_seed_scheme` by defining your own custom `FlexTones`.

We can also see that the above generated `ColorsScheme`s all include our designer colors from the provided palette and generally match the design intent of the designer's palette. Also for all generated supporting colors. The color schemes are also colorful and have good contrast, except for the `fixedDim` colors which intentionally have much lower contrast as it is in their design intent.

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/design_colors_2.png" alt="Design colors 2" />


## Setting up the Theme

Now that we have our platform adaptive `ColorScheme` define we can start using it and defining our adaptive application theme.

### Our MaterialApp

The `MaterialApp` for our simple example app looks like this:

```dart
class AdaptiveThemeDemoApp extends StatefulWidget {
  const AdaptiveThemeDemoApp({super.key});

  @override
  State<AdaptiveThemeDemoApp> createState() => _AdaptiveThemeDemoAppState();
}

class _AdaptiveThemeDemoAppState extends State<AdaptiveThemeDemoApp> {
  // We just have simple data class with 3 properties for demo purposes.
  // No state management package is used in this example. We just pass the
  // data class around and modify it where needed via callbacks.
  ThemeSettings themeSettings = const ThemeSettings(
    useMaterial3: true,
    zoomBlogFonts: false,
    themeMode: ThemeMode.system,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avocado Deli',
      theme: AppTheme.use(Brightness.light, themeSettings),
      darkTheme: AppTheme.use(Brightness.dark, themeSettings),
      themeMode: themeSettings.themeMode,
      home: HomePage(
        settings: themeSettings,
        onSettings: (ThemeSettings settings) {
          setState(() {
            themeSettings = settings;
          });
        },
      ),
    );
  }
}
```

### Theme Settings

The `ThemeSettings` is a simple data class that we use to hold the settings for our app. It is passed down to the `HomePage` widget, where we have a settings page that can change the theme settings. The `HomePage` widget will then call the `onSettings` callback to update the theme settings in the `AdaptiveThemeDemoApp` widget. We on purpose avoid all state management packages in this example, to keep it simple and focused on the theme design and adaptive theming.

```dart
/// A Theme Settings class to bundle properties we want to modify in our
/// theme interactively.
///
/// We can pass it down or use it with a ValueNotifier if so desired.
@immutable
class ThemeSettings with Diagnosticable {
  final bool useMaterial3;
  final bool zoomBlogFonts;
  final ThemeMode themeMode;

  const ThemeSettings({
    required this.useMaterial3,
    required this.zoomBlogFonts,
    required this.themeMode,
  });

  /// Flutter debug properties override, includes toString.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('useMaterial3', useMaterial3));
    properties.add(DiagnosticsProperty<bool>('zoomBlogFonts', zoomBlogFonts));
    properties.add(EnumProperty<ThemeMode>('themeMode', themeMode));
  }

  /// Copy the object with one or more provided properties changed.
  ThemeSettings copyWith({
    bool? useMaterial3,
    bool? zoomBlogFonts,
    ThemeMode? themeMode,
  }) {
    return ThemeSettings(
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      zoomBlogFonts: zoomBlogFonts ?? this.zoomBlogFonts,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ThemeSettings &&
        other.useMaterial3 == useMaterial3 &&
        other.zoomBlogFonts == zoomBlogFonts &&
        other.themeMode == themeMode;
  }

  /// Override for hashcode.
  @override
  int get hashCode => Object.hashAll(<Object?>[
        useMaterial3.hashCode,
        zoomBlogFonts.hashCode,
        themeMode.hashCode,
      ]);
}
```

### The AppTheme

We make a `class` called `AppTheme`, it is just `sealed` so it cannot be extended or implemented. It will only contain static methods and properties bundled together in a readable name space. To make a theme with our `AppTheme` helper we will use the `AppTheme.use(brightness, themeSettings)` function.

In the `AppTheme.use` function we based on the passed `brightness` get our platform adaptive `ColorScheme` that we defined earlier. 

```dart
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
    // continued...
  }
}
```

We also define a custom `visualDensity` for our app. This is a platform adaptive visual density that we will use in our `ThemeData` and also in the `ToggleButtons` component theme that does not have built-in visual density support. This platform adaptation is used to demonstrate that you don't have to use the default one that is adaptive to `compact` on desktops. This is an alternative that is adaptive to `comfortable` on desktops and to `standard` on mobile platforms. 

This approach makes desktop builds a bit less dense and more touch friendly. This is useful if an app is used on laptops with touch screens. It is still significantly denser than the `standard` density would be. Using `standard` on desktop builds makes the user interface a bit too large and space wasting looking. The usage of `comfortable` is here presented as an alternative that is more touch-friendly, but still not as space wasting as `standard` would be.

```dart
/// Returns a [VisualDensity] that is [defaultTargetPlatform] adaptive to
/// [VisualDensity.comfortable] instead of to [VisualDensity.compact].
///
/// For desktop platforms, this returns [VisualDensity.comfortable], and
/// for other platforms, it returns the default [VisualDensity.standard].
///
/// This is a variant of the [VisualDensity.adaptivePlatformDensity] that
/// returns [VisualDensity.compact] for desktop platforms.
///
/// The comfortable visual density is useful on desktop and desktop web
/// laptops that have touch screens, as it keeps touch targets a bit larger
/// than when using compact.
VisualDensity get comfortablePlatformDensity =>
    defaultComfortablePlatformDensity(defaultTargetPlatform);

/// Returns a [VisualDensity] that is adaptive based on the given [platform].
///
/// For desktop platforms, this returns [VisualDensity.comfortable], and for
/// other platforms, it returns a default [VisualDensity.standard].
///
/// See also:
///
/// * [comfortablePlatformDensity] which returns a [VisualDensity] that is
///   adaptive based on [defaultTargetPlatform].
VisualDensity defaultComfortablePlatformDensity(TargetPlatform platform) {
  switch (platform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
    case TargetPlatform.fuchsia:
      break;
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return VisualDensity.comfortable;
  }
  return VisualDensity.standard;
}
```

### Building the ThemeData

Time to define `ThemeData` since that is always fun and interesting.

While this app allows us to toggle to Material-2, it is just provided for demo purposes. Please don't use M2 in a new app in Flutter anymore. Use Material-3, really don’t use Material-2 anymore!

We apply our platform adaptive `ColorScheme` and `VisualDensity` (1) that we stored `scheme` and `visualDensity` in the `AppTheme.use` function. 

We also set the `cupertinoOverrideTheme` to `true` this ensures that all `CupertinoThemeData` properties will inherit defaults from the `ColorScheme` in our `ThemeData`. This part is needed to ensure that `CupertinoSwitch` and `Switch.adaptive` will use the same colors as our themed `Switch`.

```dart
    // ...continued from above AppTheme and `use` function.
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
```

Above we also use a custom splash factory `InstantSplash` (2) on any other platform than Android.

The `InstantSplash` is a copy of built-in `InkSplash.splashFactory` with modified animation durations and splash velocity. There is also a built-in `NoSplash.splashFactory`, alternatively it can also be used. It animates the tap highlight, this custom one is instant. Used as an example in this demo app, you may prefer the `NoSplash.splashFactory` for a similar, but less instant effect.

You can find the custom `InstantSplash.splashFactory` [here](https://github.com/rydmike/adaptive_theme_demo/blob/master/lib/theme/instant_splash.dart).

Prefer using the Material-3 typography, even if you still use Material-2, it is much nicer. Below (3), we ensure that we use the Material-3 typography even if we switch to M2 mode, which this demo app allows.

Next we fix all legacy colors (4, 5 and 6) in `ThemeData`. Eventually these will be deprecated, but as long as they exist, set them to our `ColorScheme` colors, that we have available in the `scheme` object.

```dart
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
```

The above mappings are important to make sure that all the legacy colors in `ThemeData` are set to the correct colors in our `ColorScheme`. This is important as these colors are used by many built-in components and widgets in Flutter in Material-2 mode. If you do not set them, they will not match the rest of your app's design. Also by setting them, you ensure that if they are used by accident in your custom widgets, they will still match the rest of your app's design.

You can read more about these direct `ThemeData` color deprecations plan [in issue #91772](https://github.com/flutter/flutter/issues/91772).

### Defining Component Themes

Defining a lot of elaborate custom component themes can be tedious. However, with component themes you can often bring the Material components default styles exactly to where you want them to be, or close enough to what your design calls for.

You can then avoid using custom widget wrappers to style the components. To build your app you use the default Material components and they have the correct style they should have in your app by default. This also makes it easy to on-board new developers to your codebase, as they can use the standard components to build user interfaces and everything will look as intended for your app's design.

So while component theming can feel tedious, the benefits may also be worth the effort. Also, once you have set it up for one app, you can reuse the same definitions with slight modifications in other apps.

#### AppBar Theme

      
We use a custom AppBar theme with a custom color mapping with slight opacity and very minor scroll under elevation that with shadow  will look like a faint underline in light theme mode.

Our `AppBar` theme has minor “secret” sauce in it, which is a shape, that is just same as its default shape, but it is needed to get the scroll under effect change to animate, as it should in Material-3 design spec, but does not by default in Flutter. The need for this is actually a work-around to [issue #131042](https://github.com/flutter/flutter/issues/131042). 

The scroll-under color is also modified by defining a custom `surfaceTintColor` for the `AppBarTheme` so that it is a monochrome color for other than Android platforms. After the **Flutter 3.22** release, the `AppBar` is one of the few widgets that still uses the elevation tint effect to change its color with elevation. Here we customize its tint color so we do not get any primary tint on it on other platforms than Android. Instead, we get just a monochrome color that is a bit darker than the surface color.  

Shadow is put back and used for a faint underline separation on the scrolled under state. Background also has a hint of opacity, and we also use a custom font.

```dart
      // 7) AppBar

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface.withOpacity(isLight ? 0.96 : 0.95),
        foregroundColor: scheme.secondary,
        elevation: 0,
        scrolledUnderElevation: isLight ? 0.5 : 2,
        shadowColor: scheme.shadow,
        centerTitle: defaultTargetPlatform == TargetPlatform.iOS,
        surfaceTintColor:
            ThemeTokens.isNotAndroidOrIsWeb ? scheme.outline : scheme.primary,
        shape: const RoundedRectangleBorder(),
        titleTextStyle: appBarTextStyle(scheme),
      ),
```

Generally don't try to change the app's `TexTheme` and its `TextStyle`s to make a given component use a different style by adjusting the style it uses by default from `ThemeData.textTheme`. Many other components may use the same style as their default, and you may not want them to use the same modified style. Instead make a new `TextStyle` that fits your component and use it in the component theme.

Here (25) we do so for a very custom `AppBar` title font, that will only apply to all `AppBar`s in the app, nothing else.


```dart
  // 25) Make a totally custom text style for a component theme: AppBar
  static TextStyle appBarTextStyle(ColorScheme scheme) {
    return GoogleFonts.lobster(
      fontWeight: FontWeight.w400,
      fontSize: 26,
      color: scheme.primary,
    );
  }
```

With this `AppBarTheme` we get an `AppBar` that looks like this:

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/
AppBar.gif" alt="AppBar theme"/>

