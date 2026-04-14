part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutProcessing extends CheckoutState {}

final class CheckoutAwaitingPayment extends CheckoutState {
  const CheckoutAwaitingPayment(this.paymentUrl);

  final String paymentUrl; // deep link sang VNPay/Momo app
  @override
  List<Object?> get props => [paymentUrl];
}

final class CheckoutSuccess extends CheckoutState {
  const CheckoutSuccess(this.checkoutResult);

  final CheckoutResult checkoutResult;

  @override
  List<Object?> get props => [checkoutResult];
}

final class CheckoutError extends CheckoutState {
  const CheckoutError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
