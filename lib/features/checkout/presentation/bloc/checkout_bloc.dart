import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';
import 'package:orda/features/checkout/domain/usecases/checkout_use_case.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({required CheckoutUseCase checkout})
    : _checkout = checkout,
      super(CheckoutInitial()) {
    on<PlaceOrder>((event, emit) async {
      emit(CheckoutLoading());

      final result = await _checkout(event.cart);

      result.fold(
        (failure) => emit(CheckoutError(failure.message)),
        (result) => emit(CheckoutSuccess(result)),
      );
    });
  }

  final CheckoutUseCase _checkout;
}
