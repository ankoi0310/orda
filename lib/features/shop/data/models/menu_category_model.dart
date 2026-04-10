import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/shop/data/models/menu_item_model.dart';
import 'package:orda/features/shop/domain/entities/menu_category.dart';

class MenuCategoryModel extends MenuCategory {
  const MenuCategoryModel({
    required super.id,
    required super.name,
    required super.items,
  });

  factory MenuCategoryModel.fromJson(JsonData json) {
    return MenuCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      items: List<JsonData>.from(
        json['menu_items'] as List,
      ).map(MenuItemModel.fromJson).toList(),
    );
  }
}
