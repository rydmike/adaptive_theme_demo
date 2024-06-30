import 'package:flutter/material.dart';

import 'order_status_dialog.dart';
import 'order_status_model.dart';

/// Order status widget with color properties.
class OrderStatusWithColor extends StatelessWidget {
  const OrderStatusWithColor({
    super.key,
    required this.status,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final OrderStatus status;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await OrderStatusDialog.show(context, status);
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: backgroundColor,
        child: SizedBox(
          width: 170,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(status.icon, color: foregroundColor),
                  const SizedBox(width: 8),
                  Text(
                    status.label,
                    style: TextStyle(color: foregroundColor),
                  )
                ],
              ),
              Text(
                backgroundColor.toString(),
                style: TextStyle(color: foregroundColor, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Example of a token based custom widget.
///
/// Theme changes do not get animated transitions.
class OrderStatusTokenBased extends StatelessWidget {
  const OrderStatusTokenBased({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = status.backgroundTokenColor(context);
    final Color foregroundColor = status.foregroundTokenColor(context);

    return OrderStatusWithColor(
      status: status,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}

/// Example of a theme extension based custom widget.
///
/// Theme changes not get animated transitions. This is using a theme extension
/// for the theme color, but the color could also of course come from any
/// existing color definition in ThemeData and its sub-themes, it would still
/// bee theme based and animate, it would just not have its owo custom theme
/// and would be "limited" to color values that can be defined in ThemeData.
class OrderStatusThemeBased extends StatelessWidget {
  const OrderStatusThemeBased({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = status.backgroundThemeColor(context);
    final Color foregroundColor = status.foregroundThemeColor(context);

    return OrderStatusWithColor(
      status: status,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}
