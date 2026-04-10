import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/shop/data/models/menu_item_model.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.menuItem,
    required super.quantity,
  });

  factory CartItemModel.fromJson(JsonData json) {
    return CartItemModel(
      menuItem: MenuItemModel.fromJson(json['item'] as JsonData),
      quantity: json['quantity'] as int,
    );
  }

  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      menuItem: cartItem.menuItem,
      quantity: cartItem.quantity,
    );
  }

  JsonData toJson() {
    return {
      'item': (menuItem as MenuItemModel).toJson(),
      'quantity': quantity,
    };
  }
}
