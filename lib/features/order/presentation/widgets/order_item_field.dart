import 'package:flutter/material.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/order/domain/entities/order_item.dart';

class OrderItemField extends StatelessWidget {
  const OrderItemField({required this.item, super.key});

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      spacing: 8,
      children: [
        Text(
          '${item.quantity}x',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [Text(item.name)],
          ),
        ),
        Text((item.price * item.quantity).toVND()),
      ],
    );
  }
}
