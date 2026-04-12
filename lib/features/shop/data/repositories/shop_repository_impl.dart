import 'package:fpdart/fpdart.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/extensions/string_extension.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';
import 'package:orda/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  const ShopRepositoryImpl({required this.remoteDataSource});

  final ShopRemoteDataSource remoteDataSource;

  @override
  ResultFuture<Shop> loadShop(String? shopId) async {
    if (shopId == null || !shopId.isValidUuid) {
      return Left(ValidationFailure('Mã cửa hàng không hợp lệ'));
    }

    try {
      final shop = await remoteDataSource.getShop(shopId);
      return Right(shop);
    } on ServerException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
