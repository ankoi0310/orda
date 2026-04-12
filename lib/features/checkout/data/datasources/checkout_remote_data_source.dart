import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/data/models/cart_item_model.dart';
import 'package:orda/features/checkout/data/models/checkout_result_model.dart';
import 'package:orda/features/checkout/domain/usecases/checkout_with_cash_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutResultModel> createOrder(
    CheckoutWithCashParams params,
  );
}

class CheckoutRemoteDataSourceImpl
    implements CheckoutRemoteDataSource {
  const CheckoutRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<CheckoutResultModel> createOrder(
    CheckoutWithCashParams params,
  ) async {
    final currentUser = client.auth.currentUser;
    if (currentUser == null) {
      throw const ServerException('Người dùng chưa đăng nhập');
    }

    try {
      final json = await client
          .rpc<JsonData>(
            'create_order_with_items',
            params: {
              'p_shop_id': params.shopId,
              'p_user_id': currentUser.id,
              'p_items': params.items
                  .map(
                    (item) => CartItemModel.fromEntity(item).toJson(),
                  )
                  .toList(),
            },
          )
          .select()
          .single();

      return CheckoutResultModel.fromJson(json);
    } catch (e) {
      print(e);
      throw const ServerException('Có lỗi khi tạo đơn hàng');
    }
  }
}
