import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUseCase implements UseCaseWithoutParams<void> {
  const ClearCartUseCase({required this.repository});

  final CartRepository repository;

  @override
  VoidFuture call() async {
    return repository.clearCart();
  }
}
