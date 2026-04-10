part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

final class LoadOrderHistory extends OrderEvent {}

final class GetOrderDetail extends OrderEvent {
  const GetOrderDetail({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
