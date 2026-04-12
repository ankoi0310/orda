import 'package:flutter/material.dart';
import 'package:orda/config/gen/assets.gen.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.outline),
      ),
      child: IntrinsicHeight(
        child: Row(
          spacing: 16,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12),
                child: item.imageUrl.isEmpty
                    ? Assets.images.blankItem.image(fit: BoxFit.cover)
                    : Image.network(item.imageUrl, fit: BoxFit.cover),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: context.textTheme.bodyLarge),
                  Text(
                    item.price.toVND(),
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
