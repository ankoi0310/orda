import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_item_card.dart';

class CheckoutItemListView extends StatelessWidget {
  const CheckoutItemListView({required this.items, super.key});

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
      ),
      child: ListView.separated(
        itemCount: items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = items[index];
          return CheckoutItemCard(item: item);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
