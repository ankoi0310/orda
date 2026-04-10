import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/shop/domain/entities/menu_category.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({required this.categories, super.key});

  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    final valueListenable = ValueNotifier<String?>(
      categories.first.id,
    );
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        valueListenable: valueListenable,
        onChanged: (value) {
          valueListenable.value = value;
        },
        items: categories
            .map(
              (e) => DropdownItem(
                value: e.id,
                child: Text(
                  e.name,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            )
            .toList(),
        buttonStyleData: ButtonStyleData(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
