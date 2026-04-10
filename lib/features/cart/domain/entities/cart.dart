import 'package:equatable/equatable.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';

class Cart<T extends CartItem> extends Equatable {
  const Cart({required this.shopId, required this.items});

  final String shopId;
  final List<T> items;

  Cart copyWith({List<CartItem>? items}) {
    return Cart(shopId: shopId, items: items ?? this.items);
  }

  @override
  List<Object?> get props => [shopId, items];
}
