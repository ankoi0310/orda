import 'package:fpdart/fpdart.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';
import 'package:orda/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  const ShopRepositoryImpl({required this.remoteDataSource});

  final ShopRemoteDataSource remoteDataSource;

  @override
  ResultFuture<Shop> loadShop({required String shopId}) async {
    try {
      final shop = await remoteDataSource.getShop(shopId: shopId);
      return right(shop);
    } on ServerException catch (e) {
      return left(ValidationFailure(e.message));
    }
  }
}
