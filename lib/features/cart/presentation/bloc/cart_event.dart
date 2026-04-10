part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

final class SetShop extends CartEvent {
  const SetShop({required this.shopId});

  final String shopId;

  @override
  List<Object?> get props => [shopId];
}

final class AddToCart extends CartEvent {
  const AddToCart({required this.item, this.quantity = 1});

  final MenuItem item;
  final int quantity;

  @override
  List<Object?> get props => [item, quantity];
}

final class IncreaseQuantity extends CartEvent {
  const IncreaseQuantity({required this.itemId});

  final String itemId;

  @override
  List<Object?> get props => [itemId];
}

final class DecreaseQuantity extends CartEvent {
  const DecreaseQuantity({required this.itemId});

  final String itemId;

  @override
  List<Object?> get props => [itemId];
}

final class RemoveFromCart extends CartEvent {
  const RemoveFromCart({required this.itemId});

  final String itemId;

  @override
  List<Object?> get props => [itemId];
}

final class ClearCart extends CartEvent {}
