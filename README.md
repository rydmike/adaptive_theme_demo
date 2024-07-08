Readme

# Adaptive Theming Demo at Fluttercon 2024

This is the repo used at the Material talk held July 4th, 2024, in Berlin at the Fluttercon conference, in the adaptive theming part in the talk **"Everything Material All At Once"**, given by Mike Rydstrom and Taha Tesser.

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

You can watch the presentation deck used at Fluttercon 24 [here](https://docs.google.com/presentation/d/1-JH1vDJAjbj4XK-qb7le9hT7R-I_CW7THtPPUorJsTU/edit?usp=sharing). It contains all slides and also more extensive speaker notes than there time to go into during the talk.


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


To achieve this design goal we weill add some additional design tokes to our `ThemeTokens` class. These will be used to determine if the build is an Android build or not, and if it is a web build or not. We will also add some design tokens that will be used to determine the shape and style of the buttons, switches, and chips in the app.

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

We can also see that the above generated `ColorsScheme`s all include our designer colors from the provide palette and generally match the design intent of the designer's palette. Also for all generated supporting colors. The color schemes are also colorful and have good contrast, except for the `fixedDim` colors which intentionally have much lower contrast as it is in their design intent.

<img src="https://raw.githubusercontent.com/rydmike/adaptive_theme_demo/master/images/design_colors_2.png" alt="Design colors 2" />


## Defining the Theme

