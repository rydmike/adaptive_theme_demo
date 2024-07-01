import 'package:flutter/material.dart';

import 'order_status_model.dart';

/// Dialog to show mock order status.
class OrderStatusDialog extends StatelessWidget {
  const OrderStatusDialog({
    super.key,
    required this.status,
    required this.useTheme,
  });
  final OrderStatus status;
  final bool useTheme;

  /// Show this dialog
  static Future<void> show(
      BuildContext context, OrderStatus status, bool useTheme) async {
    await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return OrderStatusDialog(status: status, useTheme: useTheme);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = useTheme
        ? status.orderStatusColor(context)
        : status.orderStatusTokenColor(context);
    return AlertDialog(
      title: Text(status.label),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(status.describe),
          const SizedBox(height: 16),
          Icon(
            status.icon,
            size: 40,
            color: iconColor,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close')),
      ],
    );
  }
}
