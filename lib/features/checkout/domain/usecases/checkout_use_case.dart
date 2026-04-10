import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';
import 'package:orda/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutUseCase implements UseCase<CheckoutResult, Cart> {
  const CheckoutUseCase({required this.repository});

  final CheckoutRepository repository;

  @override
  ResultFuture<CheckoutResult> call(Cart cart) async {
    return repository.placeOrder(cart: cart);
  }
}
