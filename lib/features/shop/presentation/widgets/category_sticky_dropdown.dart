import 'package:flutter/material.dart';
import 'package:orda/features/shop/domain/entities/menu_category.dart';

class CategoryStickyDropdown extends StatelessWidget {
  const CategoryStickyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CategoryHeaderDelegate(
        categories: fakeCategories,
        selected: fakeCategories.first.id,
        onChanged: (value) {
          // setState(() {
          //   selectedCategory = value!;
          // });
        },
      ),
    );
  }
}

/// 📌 Sticky Header Delegate
class CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  const CategoryHeaderDelegate({
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  final List<MenuCategory> categories;
  final String selected;
  final ValueChanged<String?> onChanged;

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: DropdownButton<String>(
        value: selected,
        underline: const SizedBox(),
        items: categories
            .map(
              (e) =>
                  DropdownMenuItem(value: e.id, child: Text(e.name)),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CategoryHeaderDelegate oldDelegate) {
    return oldDelegate.selected != selected;
  }
}
