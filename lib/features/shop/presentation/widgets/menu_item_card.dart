import 'package:flutter/material.dart';
import 'package:orda/config/gen/assets.gen.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/shop/domain/entities/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({required this.item, super.key});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          spacing: 16,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Assets.images.blankItem.image(
                width: context.width * 0.2,
                height: context.width * 0.2,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(item.name, style: context.textTheme.bodyLarge),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium,
                  ),
                  const Spacer(),
                  Text(
                    item.price.toVND(),
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colors.primary,
                    ),
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
