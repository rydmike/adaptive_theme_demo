import 'dart:async';

import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/copy_color_to_clipboard.dart';

const Size _colorChipSize = Size(160, 50);
const Size _onChipSize = Size(160, 36);
const Size _equalFourChipSize = Size(160, 43);
const Size _equalThreeChipSize = Size(160, 57.333);

/// A view that shows all the colors in a [ColorScheme].
///
/// It also allows copying the color values to the clipboard by tapping the
/// scheme color.
class ShowColorSchemeColors extends StatelessWidget {
  const ShowColorSchemeColors({
    super.key,
    this.scheme,
    this.showColorValue = true,
  });

  final ColorScheme? scheme;
  final bool showColorValue;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = scheme ?? theme.colorScheme;
    final bool useMaterial3 = theme.useMaterial3;
    const double spacing = 6;

    final FlexTones tones = FlexTones.candyPop(theme.brightness);

    // Grab the card border from the theme card shape
    ShapeBorder? border = theme.cardTheme.shape;
    // If we had one, copy in a border side to it.
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(color: colorScheme.outlineVariant),
      );
      // If
    } else {
      // If border was null, make one matching Card default, but with border
      // side, if it was not null, we leave it as it was.
      border ??= RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(useMaterial3 ? 12 : 4)),
        side: BorderSide(color: colorScheme.outlineVariant),
      );
    }
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 0,
          shape: border,
        ),
      ),
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: <Widget>[
          ColorGroup(children: <Widget>[
            ColorChip(
              label: 'primary',
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'P:${tones.primaryTone}',
            ),
            ColorChip(
              label: 'onPrimary',
              color: colorScheme.onPrimary,
              onColor: colorScheme.primary,
              showValue: showColorValue,
              tone: 'P:${tones.onPrimaryTone}',
            ),
            ColorChip(
              label: 'primaryContainer',
              color: colorScheme.primaryContainer,
              onColor: colorScheme.onPrimaryContainer,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'P:${tones.primaryContainerTone}',
            ),
            ColorChip(
              label: 'onPrimaryContainer',
              color: colorScheme.onPrimaryContainer,
              onColor: colorScheme.primaryContainer,
              showValue: showColorValue,
              tone: 'P:${tones.onPrimaryContainerTone}',
            ),
          ]),
          ColorGroup(children: <Widget>[
            ColorChip(
              label: 'primaryFixed',
              color: colorScheme.primaryFixed,
              onColor: colorScheme.onPrimaryFixed,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'P:${tones.primaryFixedTone}',
            ),
            ColorChip(
              label: 'onPrimaryFixed',
              color: colorScheme.onPrimaryFixed,
              onColor: colorScheme.primaryFixed,
              showValue: showColorValue,
              tone: 'P:${tones.onPrimaryFixedTone}',
            ),
            ColorChip(
              label: 'primaryFixedDim',
              color: colorScheme.primaryFixedDim,
              onColor: colorScheme.onPrimaryFixedVariant,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'P:${tones.primaryFixedDimTone}',
            ),
            ColorChip(
              label: 'onPrimaryFixedVariant',
              color: colorScheme.onPrimaryFixedVariant,
              onColor: colorScheme.primaryFixedDim,
              showValue: showColorValue,
              tone: 'P:${tones.onPrimaryFixedVariantTone}',
            ),
          ]),
          ColorGroup(children: <Widget>[
            ColorChip(
              label: 'secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'S:${tones.secondaryTone}',
            ),
            ColorChip(
              label: 'onSecondary',
              color: colorScheme.onSecondary,
              onColor: colorScheme.secondary,
              showValue: showColorValue,
              tone: 'S:${tones.onSecondaryTone}',
            ),
            ColorChip(
              label: 'secondaryContainer',
              color: colorScheme.secondaryContainer,
              onColor: colorScheme.onSecondaryContainer,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'S:${tones.secondaryContainerTone}',
            ),
            ColorChip(
              label: 'onSecondaryContainer',
              color: colorScheme.onSecondaryContainer,
              onColor: colorScheme.secondaryContainer,
              showValue: showColorValue,
              tone: 'S:${tones.onSecondaryContainerTone}',
            ),
          ]),
          ColorGroup(children: <Widget>[
            ColorChip(
              label: 'secondaryFixed',
              color: colorScheme.secondaryFixed,
              onColor: colorScheme.onSecondaryFixed,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'S:${tones.secondaryFixedTone}',
            ),
            ColorChip(
              label: 'onSecondaryFixed',
              color: colorScheme.onSecondaryFixed,
              onColor: colorScheme.secondaryFixed,
              showValue: showColorValue,
              tone: 'S:${tones.onSecondaryFixedTone}',
            ),
            ColorChip(
              label: 'secondaryFixedDim',
              color: colorScheme.secondaryFixedDim,
              onColor: colorScheme.onSecondaryFixedVariant,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'S:${tones.secondaryFixedDimTone}',
            ),
            ColorChip(
              label: 'onSecondaryFixedVariant',
              color: colorScheme.onSecondaryFixedVariant,
              onColor: colorScheme.secondaryFixedDim,
              showValue: showColorValue,
              tone: 'S:${tones.onSecondaryFixedVariantTone}',
            ),
          ]),
          ColorGroup(
            children: <Widget>[
              ColorChip(
                label: 'tertiary',
                color: colorScheme.tertiary,
                onColor: colorScheme.onTertiary,
                size: _colorChipSize,
                showValue: showColorValue,
                tone: 'T:${tones.tertiaryTone}',
              ),
              ColorChip(
                label: 'onTertiary',
                color: colorScheme.onTertiary,
                onColor: colorScheme.tertiary,
                showValue: showColorValue,
                tone: 'T:${tones.onTertiaryTone}',
              ),
              ColorChip(
                label: 'tertiaryContainer',
                color: colorScheme.tertiaryContainer,
                onColor: colorScheme.onTertiaryContainer,
                size: _colorChipSize,
                showValue: showColorValue,
                tone: 'T:${tones.tertiaryContainerTone}',
              ),
              ColorChip(
                label: 'onTertiaryContainer',
                color: colorScheme.onTertiaryContainer,
                onColor: colorScheme.tertiaryContainer,
                showValue: showColorValue,
                tone: 'T:${tones.onTertiaryContainerTone}',
              ),
            ],
          ),
          ColorGroup(children: <Widget>[
            ColorChip(
              label: 'tertiaryFixed',
              color: colorScheme.tertiaryFixed,
              onColor: colorScheme.onTertiaryFixed,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'T:${tones.tertiaryFixedTone}',
            ),
            ColorChip(
              label: 'onTertiaryFixed',
              color: colorScheme.onTertiaryFixed,
              onColor: colorScheme.tertiaryFixed,
              showValue: showColorValue,
              tone: 'T:${tones.onTertiaryFixedTone}',
            ),
            ColorChip(
              label: 'tertiaryFixedDim',
              color: colorScheme.tertiaryFixedDim,
              onColor: colorScheme.onTertiaryFixedVariant,
              size: _colorChipSize,
              showValue: showColorValue,
              tone: 'T:${tones.tertiaryFixedDimTone}',
            ),
            ColorChip(
              label: 'onTertiaryFixedVariant',
              color: colorScheme.onTertiaryFixedVariant,
              onColor: colorScheme.tertiaryFixedDim,
              showValue: showColorValue,
              tone: 'T:${tones.onTertiaryFixedVariantTone}',
            ),
          ]),
          ColorGroup(
            children: <Widget>[
              ColorChip(
                label: 'error',
                color: colorScheme.error,
                onColor: colorScheme.onError,
                size: _colorChipSize,
                showValue: showColorValue,
                tone: 'E:${tones.errorTone}',
              ),
              ColorChip(
                label: 'onError',
                color: colorScheme.onError,
                onColor: colorScheme.error,
                showValue: showColorValue,
                tone: 'E:${tones.onErrorTone}',
              ),
              ColorChip(
                label: 'errorContainer',
                color: colorScheme.errorContainer,
                onColor: colorScheme.onErrorContainer,
                size: _colorChipSize,
                showValue: showColorValue,
                tone: 'E:${tones.errorContainerTone}',
              ),
              ColorChip(
                label: 'onErrorContainer',
                color: colorScheme.onErrorContainer,
                onColor: colorScheme.errorContainer,
                showValue: showColorValue,
                tone: 'E:${tones.onErrorContainerTone}',
              ),
            ],
          ),
          ColorGroup(
            children: <Widget>[
              ColorChip(
                label: 'surface',
                color: colorScheme.surface,
                onColor: colorScheme.onSurface,
                size: _colorChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceTone}',
              ),
              ColorChip(
                label: 'onSurface',
                color: colorScheme.onSurface,
                onColor: colorScheme.surface,
                showValue: showColorValue,
                tone: 'N:${tones.onSurfaceTone}',
              ),
              ColorChip(
                label: 'surfaceContainer',
                color: colorScheme.surfaceContainer,
                onColor: colorScheme.onSurfaceVariant,
                size: _colorChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceContainerTone}',
              ),
              ColorChip(
                label: 'onSurfaceVariant',
                color: colorScheme.onSurfaceVariant,
                onColor: colorScheme.surfaceContainer,
                showValue: showColorValue,
                tone: 'NV:${tones.onSurfaceVariantTone}',
              ),
            ],
          ),
          ColorGroup(
            children: <Widget>[
              ColorChip(
                label: 'surfaceContainerLowest',
                color: colorScheme.surfaceContainerLowest,
                onColor: colorScheme.onSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceContainerLowestTone}',
              ),
              ColorChip(
                label: 'surfaceContainerLow',
                color: colorScheme.surfaceContainerLow,
                onColor: colorScheme.onSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceContainerLowTone}',
              ),
              ColorChip(
                label: 'surfaceContainerHigh',
                color: colorScheme.surfaceContainerHigh,
                onColor: colorScheme.onSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceContainerHighTone}',
              ),
              ColorChip(
                label: 'surfaceContainerHighest',
                color: colorScheme.surfaceContainerHighest,
                onColor: colorScheme.onSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceContainerHighestTone}',
              ),
            ],
          ),
          ColorGroup(
            children: <Widget>[
              ColorChip(
                label: 'surfaceDim',
                color: colorScheme.surfaceDim,
                onColor: colorScheme.onSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceDimTone}',
              ),
              ColorChip(
                label: 'surfaceBright',
                color: colorScheme.surfaceBright,
                onColor: colorScheme.onSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.surfaceBrightTone}',
              ),
              ColorChip(
                label: 'inverseSurface',
                color: colorScheme.inverseSurface,
                onColor: colorScheme.onInverseSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.inverseSurfaceTone}',
              ),
              ColorChip(
                label: 'onInverseSurface',
                color: colorScheme.onInverseSurface,
                onColor: colorScheme.inverseSurface,
                size: _equalFourChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.onInverseSurfaceTone}',
              ),
            ],
          ),
          ColorGroup(
            children: <Widget>[
              ColorChip(
                label: 'outline',
                color: colorScheme.outline,
                onColor: colorScheme.surface,
                size: _equalThreeChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.outlineTone}',
              ),
              ColorChip(
                label: 'outlineVariant',
                color: colorScheme.outlineVariant,
                size: _equalThreeChipSize,
                showValue: showColorValue,
                tone: 'NV:${tones.outlineVariantTone}',
              ),
              ColorChip(
                label: 'scrim',
                color: colorScheme.scrim,
                size: _equalThreeChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.scrimTone}',
              ),
            ],
          ),
          ColorGroup(
            children: <Widget>[
              ColorChip(
                label: 'surfaceTint',
                color: colorScheme.surfaceTint,
                size: _equalThreeChipSize,
                showValue: showColorValue,
                tone: 'P:${tones.surfaceTintTone}',
              ),
              ColorChip(
                label: 'inversePrimary',
                color: colorScheme.inversePrimary,
                onColor: colorScheme.inverseSurface,
                size: _equalThreeChipSize,
                showValue: showColorValue,
                tone: 'P:${tones.inversePrimaryTone}',
              ),
              ColorChip(
                label: 'shadow',
                color: colorScheme.shadow,
                size: _equalThreeChipSize,
                showValue: showColorValue,
                tone: 'N:${tones.shadowTone}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorGroup extends StatelessWidget {
  const ColorGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  const ColorChip({
    super.key,
    required this.color,
    required this.label,
    this.onColor,
    this.size,
    this.copyEnabled = true,
    this.showValue = false,
    this.tone = '',
  });

  final Color color;
  final Color? onColor;
  final String label;
  final Size? size;
  final bool copyEnabled;
  final bool showValue;
  final String tone;

  static Color _contrastColor(Color color) {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    switch (brightness) {
      case Brightness.dark:
        return Colors.white;
      case Brightness.light:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color labelColor = onColor ?? _contrastColor(color);
    final Size effectiveSize = size ?? _onChipSize;

    return SizedBox(
      width: effectiveSize.width,
      height: effectiveSize.height,
      child: Tooltip(
        waitDuration: const Duration(milliseconds: 700),
        message: copyEnabled
            ? 'Color #${color.hexCode}.'
                '\nTap box to copy RGB value to Clipboard.'
            : '',
        child: ColoredBox(
          color: color,
          child: InkWell(
            onTap: copyEnabled
                ? () {
                    unawaited(copyColorToClipboard(context, color));
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      showValue ? '$label\n#${color.hexCode}  $tone' : label,
                      style: TextStyle(color: labelColor, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
