import 'package:flutter/material.dart';
import 'package:orda/config/gen/assets.gen.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';

class CheckoutItemCard extends StatefulWidget {
  const CheckoutItemCard({required this.item, super.key});

  final CartItem item;

  @override
  State<CheckoutItemCard> createState() => _CheckoutItemCardState();
}

class _CheckoutItemCardState extends State<CheckoutItemCard> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      child: IntrinsicHeight(
        child: Row(
          spacing: 16,
          children: [
            SizedBox(
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: item.menuItem.imageUrl.isEmpty
                    ? Assets.images.blankItem.image(fit: BoxFit.cover)
                    : Image.network(item.menuItem.imageUrl),
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.menuItem.name,
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        item.menuItem.price.toVND(),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text('x${item.quantity}'),
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
