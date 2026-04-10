part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class LoadingOrderHistory extends OrderState {}

final class LoadOrderHistorySuccess extends OrderState {
  const LoadOrderHistorySuccess(this.orders);

  final List<Order> orders;

  @override
  List<Object> get props => [orders];
}

final class OrderError extends OrderState {
  const OrderError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
