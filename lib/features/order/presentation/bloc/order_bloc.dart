import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/domain/usecases/get_order_list_use_case.dart';
import 'package:orda/features/order/domain/usecases/get_order_use_case.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required GetOrderListUseCase getOrderList,
    required GetOrderDetailUseCase getOrderDetail,
  }) : _getOrderList = getOrderList,
       _getOrderDetail = getOrderDetail,
       super(OrderInitial()) {
    on<LoadOrderHistory>(_onGetOrderHistory);
  }

  final GetOrderListUseCase _getOrderList;
  final GetOrderDetailUseCase _getOrderDetail;

  Future<void> _onGetOrderHistory(
    LoadOrderHistory event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _getOrderList(const OrderFilter());

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(LoadOrderHistorySuccess(orders)),
    );
  }
}
