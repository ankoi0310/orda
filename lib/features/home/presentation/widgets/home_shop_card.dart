import 'package:flutter/material.dart';
import 'package:orda/config/gen/assets.gen.dart';
import 'package:orda/core/extensions/build_context_extension.dart';

class HomeShopCard extends StatelessWidget {
  const HomeShopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: context.colors.secondaryContainer,
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: IntrinsicHeight(
        child: Row(
          spacing: 8,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Assets.images.blankItem.image(
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Cua hang 1',
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colors.onSecondaryContainer,
                    ),
                  ),
                  Text.rich(
                    const TextSpan(
                      text: 'Địa chỉ: ',
                      children: [TextSpan(text: 'Dia chi')],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colors.outline,
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
