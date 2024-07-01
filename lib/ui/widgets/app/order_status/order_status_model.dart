import 'package:flutter/material.dart';

import '../../../../theme/app_theme_extension.dart';
import '../../../../theme/theme_tokens.dart';

/// Enum used to model our order status value,
/// also includes labels, icons and colors for each status.
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

  /// Returns the color associated with the order status. Uses the
  /// context to determine if it should be the token for light or dark mode.
  Color orderStatusTokenColor(BuildContext context) {
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

  /// Returns the on-color associated with the order status. Uses the
  /// context to determine if it should be the token for light or dark mode.
  Color onOrderStatusTokenColor(BuildContext context) {
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

  /// Returns the color associated with the order status. Uses
  /// Theme.of(context).extension, to get the color. If the extension is not
  /// defined, it falls back to the direct token based color.
  Color orderStatusColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (this) {
      case OrderStatus.received:
        return theme.extension<AppThemeExtension>()?.received ??
            orderStatusTokenColor(context);
      case OrderStatus.preparing:
        return theme.extension<AppThemeExtension>()?.making ??
            orderStatusTokenColor(context);
      case OrderStatus.inDelivery:
        return theme.extension<AppThemeExtension>()?.inDelivery ??
            orderStatusTokenColor(context);
      case OrderStatus.delivered:
        return theme.extension<AppThemeExtension>()?.delivered ??
            orderStatusTokenColor(context);
    }
  }

  /// Returns the on-color associated with the order status. Uses
  /// Theme.of(context).extension, to get the color. If the extension is not
  /// defined, it falls back to the direct token based on-color.
  Color onOrderStatusColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (this) {
      case OrderStatus.received:
        return theme.extension<AppThemeExtension>()?.onReceived ??
            onOrderStatusTokenColor(context);
      case OrderStatus.preparing:
        return theme.extension<AppThemeExtension>()?.onMaking ??
            onOrderStatusTokenColor(context);
      case OrderStatus.inDelivery:
        return theme.extension<AppThemeExtension>()?.onInDelivery ??
            onOrderStatusTokenColor(context);
      case OrderStatus.delivered:
        return theme.extension<AppThemeExtension>()?.onDelivered ??
            onOrderStatusTokenColor(context);
    }
  }
}
