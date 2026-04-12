import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';
import 'package:orda/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutWithCashUseCase
    implements UseCase<CheckoutResult, CheckoutWithCashParams> {
  const CheckoutWithCashUseCase({required this.repository});

  final CheckoutRepository repository;

  @override
  ResultFuture<CheckoutResult> call(CheckoutWithCashParams params) async {
    return repository.createOrder(params);
  }
}

class CheckoutWithCashParams {
  const CheckoutWithCashParams({required this.shopId, required this.items});

  final String shopId;
  final List<CartItem> items;
}
