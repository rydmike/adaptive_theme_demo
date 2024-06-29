import 'package:flutter/material.dart';

import '../../../../theme/app_theme_extension.dart';
import '../../../../theme/theme_tokens.dart';

/// An enum used to model our order status value
///
/// It also includes labels, icons and colors for each status.
enum OrderStatus {
  received(
    label: 'Order received',
    describe: 'Thank you!\nWe have received your order\n'
        'and will prepare it shortly.',
    icon: Icons.thumb_up,
  ),
  preparing(
    label: 'Preparing',
    describe: 'Our chef is preparing your order from\nfresh sustainably '
        'produced ingredients.',
    icon: Icons.soup_kitchen,
  ),
  inDelivery(
    label: 'In delivery',
    describe: 'We are delivering your\nAvocado Deli meal to you.',
    icon: Icons.electric_moped,
  ),
  delivered(
    label: 'Delivered',
    describe: 'Your order has been delivered.\nEnjoy your meal and thank '
        'you\nfor choosing Avocado Deli!',
    icon: Icons.ramen_dining,
  );

  const OrderStatus({
    required this.label,
    required this.describe,
    required this.icon,
  });

  final String label;
  final String describe;
  final IconData icon;

  /// Returns the foreground color associated with the order status. Uses the
  /// context to determine if it should be the token for light or dark mode.
  Color backgroundTokenColor(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    switch (this) {
      case OrderStatus.received:
        return isLight ? ThemeTokens.receivedLight : ThemeTokens.receivedDark;
      case OrderStatus.preparing:
        return isLight ? ThemeTokens.preparingLight : ThemeTokens.preparingDark;
      case OrderStatus.inDelivery:
        return isLight ? ThemeTokens.deliveryLight : ThemeTokens.deliveryDark;
      case OrderStatus.delivered:
        return isLight ? ThemeTokens.deliveredLight : ThemeTokens.deliveredDark;
    }
  }

  /// Returns the background color associated with the order status. Uses the
  /// context to determine if it should be the token for light or dark mode.
  Color foregroundTokenColor(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    switch (this) {
      case OrderStatus.received:
        return isLight ? ThemeTokens.receivedDark : ThemeTokens.receivedLight;
      case OrderStatus.preparing:
        return isLight ? ThemeTokens.preparingDark : ThemeTokens.preparingLight;
      case OrderStatus.inDelivery:
        return isLight ? ThemeTokens.deliveryDark : ThemeTokens.deliveryLight;
      case OrderStatus.delivered:
        return isLight ? ThemeTokens.deliveredDark : ThemeTokens.deliveredLight;
    }
  }

  /// Returns the background color associated with the order status. Uses the
  /// context the context to get it from Theme.of(context). In this case
  /// we are getting the color value from a Theme extension. If there is no
  /// theme extension defined, ot falls back to the direct token based value.
  Color backgroundThemeColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (this) {
      case OrderStatus.received:
        return theme.extension<AppThemeExtension>()?.received ??
            backgroundTokenColor(context);
      case OrderStatus.preparing:
        return theme.extension<AppThemeExtension>()?.making ??
            backgroundTokenColor(context);
      case OrderStatus.inDelivery:
        return theme.extension<AppThemeExtension>()?.inDelivery ??
            backgroundTokenColor(context);
      case OrderStatus.delivered:
        return theme.extension<AppThemeExtension>()?.delivered ??
            backgroundTokenColor(context);
    }
  }

  /// Returns the foreground color associated with the order status. Uses the
  /// context the context to get it from Theme.of(context). In this case
  /// we are getting the color value from a Theme extension. If there is no
  /// theme extension defined, ot falls back to the direct token based value.
  Color foregroundThemeColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (this) {
      case OrderStatus.received:
        return theme.extension<AppThemeExtension>()?.onReceived ??
            foregroundTokenColor(context);
      case OrderStatus.preparing:
        return theme.extension<AppThemeExtension>()?.onMaking ??
            foregroundTokenColor(context);
      case OrderStatus.inDelivery:
        return theme.extension<AppThemeExtension>()?.onInDelivery ??
            foregroundTokenColor(context);
      case OrderStatus.delivered:
        return theme.extension<AppThemeExtension>()?.onDelivered ??
            foregroundTokenColor(context);
    }
  }
}