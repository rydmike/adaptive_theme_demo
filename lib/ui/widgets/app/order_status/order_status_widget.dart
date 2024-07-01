import 'package:flutter/material.dart';

import 'order_status_dialog.dart';
import 'order_status_model.dart';

/// Order status widget
class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.status,
    required this.useTheme,
  });

  final OrderStatus status;
  final bool useTheme;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = useTheme
        ? status.orderStatusColor(context)
        : status.orderStatusTokenColor(context);
    final Color foregroundColor = useTheme
        ? status.onOrderStatusColor(context)
        : status.onOrderStatusTokenColor(context);

    return GestureDetector(
      onTap: () async {
        await OrderStatusDialog.show(context, status, useTheme);
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
