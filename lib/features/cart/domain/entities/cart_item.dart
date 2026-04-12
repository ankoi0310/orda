import 'package:equatable/equatable.dart';
import 'package:orda/features/shop/domain/entities/menu_item.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory CartItem.test({
    String? menuItemId,
    String? name,
    int? price,
    String? imageUrl,
    int? quantity,
  }) {
    return CartItem(
      menuItemId: menuItemId ?? MenuItem.test().id,
      name: name ?? MenuItem.test().name,
      price: price ?? MenuItem.test().price,
      imageUrl: imageUrl ?? MenuItem.test().imageUrl,
      quantity: quantity ?? 1,
    );
  }

  final String menuItemId;
  final String name;
  final int price;
  final String imageUrl;
  final int quantity;

  int get subtotal => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      menuItemId: menuItemId,
      name: name,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [menuItemId, quantity];
}

final List<CartItem> fakeCartItems = [
  CartItem.test(),
  CartItem.test(),
  CartItem.test(),
  CartItem.test(),
];
