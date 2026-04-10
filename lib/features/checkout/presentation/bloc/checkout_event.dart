part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

final class PlaceOrder extends CheckoutEvent {
  const PlaceOrder({required this.cart});

  final Cart cart;

  @override
  List<Object?> get props => [cart];
}
