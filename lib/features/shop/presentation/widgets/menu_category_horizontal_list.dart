import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/shop/domain/entities/menu_category.dart';
import 'package:orda/features/shop/presentation/widgets/menu_category_chip.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuCategoryHorizontalList extends StatelessWidget {
  const MenuCategoryHorizontalList({
    required this.controller,
    super.key,
  });

  final ItemScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.secondaryContainer,
        border: Border(
          bottom: BorderSide(
            width: 3,
            color: context.colors.outlineVariant,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 16,
          children: [
            const SizedBox(),
            ...fakeCategories.map((category) {
              final index = fakeCategories.indexWhere(
                (cat) => cat.id == category.id,
              );
              return MenuCategoryChip(
                controller: controller,
                index: index,
                category: category,
              );
            }),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
