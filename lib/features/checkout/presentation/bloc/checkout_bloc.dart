import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';
import 'package:orda/features/checkout/domain/entities/payment_method.dart';
import 'package:orda/features/checkout/domain/usecases/checkout_with_cash_use_case.dart';
import 'package:orda/features/checkout/domain/usecases/initiate_payment_use_case.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.shopId,
    required InitiatePaymentUseCase initiatePayment,
    required CheckoutWithCashUseCase checkoutWithCash,
  }) : _initiatePayment = initiatePayment,
       _checkoutWithCash = checkoutWithCash,
       super(CheckoutInitial());

  final String shopId;
  final InitiatePaymentUseCase _initiatePayment;
  final CheckoutWithCashUseCase _checkoutWithCash;

  Future<void> checkout(
    PaymentMethod paymentMethod,
    List<CartItem> items,
  ) async {
    switch (paymentMethod) {
      case PaymentMethod.cash:
        return confirmCash(items);
      case PaymentMethod.momo:
      case PaymentMethod.vnpay:
      case PaymentMethod.zalopay:
        return initOnlinePayment(items);
    }
  }

  /// Pay in cash
  Future<void> confirmCash(List<CartItem> items) async {
    emit(CheckoutProcessing());

    final result = await _checkoutWithCash(
      CheckoutWithCashParams(shopId: shopId, items: items),
    );

    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (checkoutResult) => emit(CheckoutSuccess(checkoutResult)),
    );
  }

  /// Online payment
  Future<void> initOnlinePayment(List<CartItem> items) async {}

  /// Callback from deeplink
  // Future<void> onPaymentCallback({
  //   required String transactionId,
  //   required List<CartItem> items,
  // }) async {
  //   final current = state as CheckoutIdle;
  //   final orderNumber = await _checkout(
  //     storeId,
  //     current.items,
  //     transactionId: transactionId, // lưu reference thanh toán
  //   );
  //   final result = await _checkout(
  //     CheckoutWithCashParams(shopId: shopId, items: items),
  //   );
  //
  //   result.fold(
  //     (failure) => emit(CheckoutError(failure.message)),
  //     (checkoutResult) => emit(CheckoutSuccess(checkoutResult)),
  //   );
  // }
}
