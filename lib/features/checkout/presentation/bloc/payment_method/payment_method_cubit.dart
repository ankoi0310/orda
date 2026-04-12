import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());
}
