import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/shop/domain/entities/menu_category.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuCategoryChip extends StatelessWidget {
  const MenuCategoryChip({
    required this.controller,
    required this.index,
    required this.category,
    super.key,
  });

  final ItemScrollController controller;
  final int index;
  final MenuCategory category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Chip(
        color: WidgetStatePropertyAll<Color>(context.colors.primary),
        labelStyle: context.textTheme.labelMedium!.copyWith(
          color: context.colors.onPrimary,
        ),
        label: Text(category.name),
      ),
    );
  }
}
