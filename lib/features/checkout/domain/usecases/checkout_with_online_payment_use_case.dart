import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';

class CheckoutWithOnlinePaymentUseCase
    implements
        UseCase<CheckoutResult, CheckoutWithOnlinePaymentParams> {
  @override
  ResultFuture<CheckoutResult> call(
    CheckoutWithOnlinePaymentParams params,
  ) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class CheckoutWithOnlinePaymentParams {}
