import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';

class ItemQuantity extends StatefulWidget {
  const ItemQuantity({required this.item, super.key});

  final CartItem item;

  @override
  State<ItemQuantity> createState() => _ItemQuantityState();
}

class _ItemQuantityState extends State<ItemQuantity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
          },
          child: const Icon(Iconsax.minus_cirlce_copy),
        ),
        Container(
          padding: const EdgeInsetsGeometry.all(8),
          child: Text(
            '${widget.item.quantity}',
            style: context.textTheme.bodyLarge,
          ),
        ),
        GestureDetector(
          onTap: () {
            // item.copyWith(
            //   quantity: item.quantity + 1,
            // );
          },
          child: const Icon(Iconsax.add_circle_copy),
        ),
      ],
    );
  }
}
