import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
