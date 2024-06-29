import 'package:flutter/material.dart';

import 'order_status_model.dart';

/// Dialog to show mock order status.
class OrderStatusDialog extends StatelessWidget {
  const OrderStatusDialog({super.key, required this.status});
  final OrderStatus status;

  /// Show this dialog
  static Future<void> show(BuildContext context, OrderStatus status) async {
    await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return OrderStatusDialog(status: status);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Token based 'backgroundColor' and extension based 'background'
    final Color iconColor = status.backgroundTokenColor(context);
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
