import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.menuItemId,
    required super.name,
    required super.price,
    required super.imageUrl,
  });

  factory CartItemModel.fromEntity(CartItem entity) => CartItemModel(
    menuItemId: entity.menuItemId,
    name: entity.name,
    price: entity.price,
    imageUrl: entity.imageUrl,
  );

  JsonData toJson() {
    return {
      'menu_item_id': menuItemId,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'quantity': quantity,
    };
  }
}
