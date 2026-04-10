import 'package:equatable/equatable.dart';
import 'package:orda/features/shop/domain/entities/menu_item.dart';

class CartItem extends Equatable {
  const CartItem({required this.menuItem, required this.quantity});

  factory CartItem.test({MenuItem? menuItem, int? quantity}) {
    return CartItem(
      menuItem: menuItem ?? MenuItem.test(),
      quantity: quantity ?? 1,
    );
  }

  final MenuItem menuItem;
  final int quantity;

  int get total => menuItem.price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      menuItem: menuItem,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [menuItem, quantity];
}

final List<CartItem> fakeCartItems = [
  CartItem.test(),
  CartItem.test(),
  CartItem.test(),
  CartItem.test(),
];
