import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase implements UseCaseWithoutParams<Cart> {
  const GetCartUseCase({required this.repository});

  final CartRepository repository;

  @override
  ResultFuture<Cart> call() async {
    return repository.getCart();
  }
}
