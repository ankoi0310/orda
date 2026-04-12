part of 'payment_method_cubit.dart';

sealed class PaymentMethodState extends Equatable {
  const PaymentMethodState();
}

final class PaymentMethodInitial extends PaymentMethodState {
  @override
  List<Object> get props => [];
}
