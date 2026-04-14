import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/domain/usecases/get_order_history_use_case.dart';
import 'package:orda/features/order/domain/usecases/get_order_use_case.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required GetOrderHistoryUseCase getOrderHistory,
    required GetOrderDetailUseCase getOrderDetail,
  }) : _getOrderHistory = getOrderHistory,
       _getOrderDetail = getOrderDetail,
       super(OrderInitial()) {
    on<LoadOrderHistory>(_onGetOrderHistory);
  }

  final GetOrderHistoryUseCase _getOrderHistory;
  final GetOrderDetailUseCase _getOrderDetail;

  Future<void> _onGetOrderHistory(
    LoadOrderHistory event,
    Emitter<OrderState> emit,
  ) async {
    emit(LoadingOrderHistory());
    final result = await _getOrderHistory(const OrderFilter());

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(LoadOrderHistorySuccess(orders)),
    );
  }
}
