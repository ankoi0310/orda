import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/shop/data/models/menu_category_model.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required super.id,
    required super.name,
    required super.description,
    required super.address,
    required super.imageUrl,
    required super.categories,
  });

  factory ShopModel.fromJson(JsonData json) {
    return ShopModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      imageUrl: json['image_url'] as String,
      categories: List<JsonData>.from(
        json['menu_categories'] as List,
      ).map(MenuCategoryModel.fromJson).toList(),
    );
  }
}
