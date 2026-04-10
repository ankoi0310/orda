import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/shop/domain/entities/menu_category.dart';
import 'package:orda/features/shop/presentation/widgets/menu_item_card.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuItemScrollableList extends StatelessWidget {
  const MenuItemScrollableList({
    required this.itemScrollController,
    required this.categories,
    super.key,
  });

  final ItemScrollController itemScrollController;
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    final scrollOffsetController = ScrollOffsetController();
    final itemPositionsListener = ItemPositionsListener.create();
    final scrollOffsetListener = ScrollOffsetListener.create();

    return Expanded(
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: context.colors.secondaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    category.name,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ScrollablePositionedList.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: category.items.length,
                  itemBuilder: (context, index) {
                    final item = category.items[index];
                    return MenuItemCard(item: item);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 1);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
