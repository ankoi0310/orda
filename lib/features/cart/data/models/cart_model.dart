import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/data/models/cart_item_model.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';

class CartModel extends Cart<CartItemModel> {
  const CartModel({required super.shopId, required super.items});

  factory CartModel.fromJson(JsonData json) {
    return CartModel(
      shopId: json['shopId'] as String,
      items: List<JsonData>.from(
        json['menu_items'] as List,
      ).map(CartItemModel.fromJson).toList(),
    );
  }

  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      shopId: cart.shopId,
      items: cart.items.map(CartItemModel.fromEntity).toList(),
    );
  }

  JsonData toJson() {
    return {
      'shopId': shopId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
