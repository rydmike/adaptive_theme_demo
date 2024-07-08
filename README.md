Readme

# Adaptive Theming Demo at Fluttercon 2024

This is the repo used at the Material talk held July 4th, 2024, in Berlin at the Fluttercon conference, in the adaptive theming part in the talk **"Everything Material All At Once"**, given by Mike Rydstrom and Taha Tesser.

## The Theming Goal

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

You can watch the presentation deck used at Fluttercon 24 [here](https://docs.google.com/presentation/d/1-JH1vDJAjbj4XK-qb7le9hT7R-I_CW7THtPPUorJsTU/edit?usp=sharing). It contains all slides and also more extensive speaker notes than there time to go into during the talk.


# Adaptive Theming

This part of the readme is still **work in progress**. While in WIP phase the doc additions are being committed as they are written, they will be incomplete and may have error. When the doc section is completed, this WIP info will be removed.

The intent is to make this readme into an article, describing the setup and how to achieve the adaptive theming in the demo. It will also explain some of the made choices and how they affect the app's look and feel.

## Design Color Tokens

Typically, in a custom branded app, we have one or two brand colors that must be present in our app's colors to some extend. In some cases we may have an entire palette of colors that are part of the brand or desired ambiance of the app.

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

In this example, we will create a custom theme that is adaptive to the platform it runs on. We will let Android use default Material-3 design when it comes to its shapes and interaction effects. While all other platforms and also any build on web, we will use a more platform-agnostic design. It will be a bit more iOS like in its design for shapes and interaction effects.  

The choice to make it impact all web platforms, means that when the app is run in a browser on Android, it will also then use the none Material default design. If you prefer, you could also make the platform adaptive response so that in a web browser on Android it also uses the default Material style. This might make more sense if you intend for the web build to be used as a PWA on Android devices. To use the PWA instead of compiled Android app, or as a solution for causal users that do not want to install an app. However, in this example, all web usage will look the same and use the none default Material design, while only the build as an Android app will use the Material default design. 

Some of our adaptive design examples are shown below:

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design1.png" alt="Adaptive design goals one" />
<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design2.png" alt="Adaptive design goals two" />
<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design3.png" alt="Adaptive design goals three" />
<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/adaptive_design4.png" alt="Adaptive design goals four" />


To achieve this design goal we weill add some addtional design tokes to our `ThemeTokens` class. These will be used to determine if the build is an Android build or not, and if it is a web build or not. We will also add some design tokens that will be used to determine the shape and style of the buttons, switches, and chips in the app.

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

### ColorScheme

Since `ColorScheme.fromSeed` can only use one seed color, we are going to take a pass on it and instead use a package that can generate a ColorScheme from multiple seed colors. We will use the [`flex_seed_scheme`](https://pub.dev/packages/flex_seed_scheme) package for this.

By using it we can create a `ColorScheme` from multiple seed colors, and we can also create a `ColorScheme` that is colorful, which is what we want for our app. As `tones` for the `ColorScheme` we will use the `FlexTones.chroma` method, which creates a colorful `ColorScheme` based on the chromacity of each seed color.

As primary color we will use the `avocado` color, as secondary the `avocadoRipe` color, and as tertiary the `avocadoCore` color. We will also pin some of the design tokens to the `ColorScheme` colors, like the `primaryContainer` color to the `avocadoMeat` color.




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
    // Same key colors and tones as light mode.
    primaryKey: ThemeTokens.avocado,
    secondaryKey: ThemeTokens.avocadoRipe,
    tertiaryKey: ThemeTokens.avocadoCore,
    tones: FlexTones.chroma(Brightness.dark)
        .monochromeSurfaces(ThemeTokens.isNotAndroidOrIsWeb),

    // Color overrides to design token values.
    // Overrides are different from light mode,
    // typically inverse selections.
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

### Result Light Mode

### Result Dark Mode


