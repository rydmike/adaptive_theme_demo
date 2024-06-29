import 'package:flutter/material.dart';

import '../../universal/stateful_header_card.dart';
import 'order_status_model.dart';
import 'order_status_widgets.dart';

// Display all the order status widgets in an expandable container.
class OrderStatesCard extends StatelessWidget {
  const OrderStatesCard({super.key, required this.useTheme});
  final bool useTheme;

  @override
  Widget build(BuildContext context) {
    return StatefulHeaderCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: const Icon(Icons.notifications_active_outlined),
      isOpen: false,
      title: useTheme
          ? const Text('OrderStatus Theme Based')
          : const Text('OrderStatus Token Based'),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final OrderStatus status in OrderStatus.values)
              useTheme
                  ? OrderStatusThemeBased(status: status)
                  : OrderStatusTokenBased(status: status)
          ],
        ),
      ),
    );
  }
}
