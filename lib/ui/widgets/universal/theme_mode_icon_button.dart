import 'package:flutter/material.dart';

/// Widget using [IconButton] that can be used to toggle the theme mode
/// of an application.
///
/// This is a simple Flutter "Universal" Widget that only depends on the SDK and
/// can be dropped into any application.
class ThemeModeIconButton extends StatelessWidget {
  const ThemeModeIconButton({
    super.key,
    required this.themeMode,
    required this.onChanged,
  });
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;

    return IconButton(
        icon: Icon(isLight ? Icons.wb_sunny : Icons.bedtime),
        onPressed: () {
          if (isLight) {
            onChanged(ThemeMode.dark);
          } else {
            onChanged(ThemeMode.light);
          }
        });
  }
}
