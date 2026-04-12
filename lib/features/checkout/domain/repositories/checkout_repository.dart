import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';
import 'package:orda/features/checkout/domain/usecases/checkout_with_cash_use_case.dart';

abstract class CheckoutRepository {
  ResultFuture<CheckoutResult> createOrder(
    CheckoutWithCashParams params,
  );
}
