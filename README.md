Readme

# Adaptive Theming Demo at Fluttercon 2024

This is the repo used at the Material talk held July 4th, 2024, in Berlin at the Fluttercon and Droidcon event, for the adaptive theming part in the talk **"Everything Material All At Once"**.

## The Theming Goal

We will create a custom theme that uses: 

* Multiple input colors to make custom seed generated Colors scheme
* The seeded ColorScheme contain our brand color tokens and is colorful
* We have theme extension for custom semantic colors and content text styles, their changes animate with the rest of theme changes
* The AppBar theme shows some nice tricks.
* Generated theme is platform adaptive, where:   
  * We only have animated Material spreading ink effect splash on Android, on all other platform the splash taps are just an instant highlight color on tap. This makes tap interactions feel less like "Material" on iOS, desktop and web platforms.
  * Buttons have iOS like radius and style on none Android platforms, but Material style on Android.
  * The Material Switch looks like an iOS switch on none Android platforms, but like Material Switch on Android.
  * The legacy ToggleButtons is themed to match the style of the FilledButton and OutlinedButton.
  * Chips are themed to be stadium shaped on none Android platforms, but Material rounded corners on Android. This gives them a style in both adaptive modes that differentiates them from the used button styles.


<img src="https://raw.githubusercontent.com/rydmike/theming_workshop/master/doc_images/avo-target.png" alt="avo-target"/>

## Slides

You can watch the presentation deck used at Fluttercon 24 [here](https://docs.google.com/presentation/d/1-JH1vDJAjbj4XK-qb7le9hT7R-I_CW7THtPPUorJsTU/edit?usp=sharing). It contains all slides and often also more extensive speaker notes than what was explain during the talk.

## Theme Setup

A description and code walk through may be added here later for convenience, the slide deck already covers it well though. 