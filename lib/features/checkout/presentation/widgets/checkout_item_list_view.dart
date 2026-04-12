import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:orda/features/checkout/presentation/widgets/cart_item_card.dart';
import 'package:orda/features/checkout/presentation/widgets/item_quantity.dart';

class CheckoutItemListView extends StatelessWidget {
  const CheckoutItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartCubit>().state;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = state.items[index];
        return Stack(
          children: [
            CartItemCard(item: item),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => context.read<CartCubit>().removeItem(
                  item.menuItemId,
                ),
                child: const Icon(Iconsax.close_circle_copy),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 8,
              child: ItemQuantity(item: item),
            ),
          ],
        );
      },
      itemCount: state.items.length,
    );
  }
}
