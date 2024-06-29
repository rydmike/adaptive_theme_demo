import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
