import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';

abstract class CheckoutRepository {
  ResultFuture<CheckoutResult> placeOrder({required Cart cart});
}
