import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/cart/presentation/bloc/cart_cubit.dart';

class ItemQuantity extends StatelessWidget {
  const ItemQuantity({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Row(
      children: [
        GestureDetector(
          onTap: () =>
              cubit.updateQty(item.menuItemId, item.quantity - 1),
          child: const Icon(Iconsax.minus_cirlce_copy),
        ),
        Container(
          padding: const EdgeInsetsGeometry.all(8),
          child: Text(
            '${item.quantity}',
            style: context.textTheme.bodyLarge,
          ),
        ),
        GestureDetector(
          onTap: () =>
              cubit.updateQty(item.menuItemId, item.quantity + 1),
          child: const Icon(Iconsax.add_circle_copy),
        ),
      ],
    );
  }
}
