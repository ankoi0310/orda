part of 'cart_cubit.dart';

enum CartStatus { initial, updating, updated, error }

final class CartState extends Equatable {
  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.error,
  });

  final CartStatus status;
  final List<CartItem> items;
  final String? error;

  bool get isUpdating => status == CartStatus.updating;

  bool get isUpdated => status == CartStatus.updated;

  bool get isError => status == CartStatus.error;

  double get total => items.fold(0, (sum, e) => sum + e.subtotal);

  int get itemCount => items.fold(0, (sum, e) => sum + e.quantity);

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? items,
    String? error,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, items, error];
}
