import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';
import 'package:orda/features/shop/domain/repositories/shop_repository.dart';

class LoadShopUseCase implements UseCase<Shop, String> {
  const LoadShopUseCase({required this.repository});

  final ShopRepository repository;

  @override
  ResultFuture<Shop> call(String shopId) async {
    return repository.loadShop(shopId: shopId);
  }
}
