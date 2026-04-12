import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';

abstract class ShopRepository {
  ResultFuture<Shop> loadShop(String? shopId);
}
