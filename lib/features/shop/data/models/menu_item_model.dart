import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/shop/domain/entities/menu_item.dart';

class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
    required super.isAvailable,
  });

  factory MenuItemModel.fromJson(JsonData json) {
    return MenuItemModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      price: json['price'] as int,
      isAvailable: json['is_available'] as bool,
    );
  }

  JsonData toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'price': price,
      'is_available': isAvailable,
    };
  }
}
