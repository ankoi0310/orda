import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/extensions/string_extension.dart';
import 'package:orda/features/shop/data/models/shop_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ShopRemoteDataSource {
  Future<ShopModel> getShop(String shopId);
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  const ShopRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<ShopModel> getShop(String shopId) async {
    if (!shopId.isValidUuid) {
      throw const ServerException('Mã cửa hàng không hợp lệ');
    }

    final json = await client
        .from('shops')
        .select('*, menu_categories(*, menu_items(*))')
        .eq('id', shopId)
        .maybeSingle();

    if (json == null) {
      throw const ServerException('Không tìm thấy cửa hàng');
    }

    return ShopModel.fromJson(json);
  }
}
