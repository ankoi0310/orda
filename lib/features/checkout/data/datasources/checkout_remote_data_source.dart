import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/data/models/cart_model.dart';
import 'package:orda/features/checkout/data/models/checkout_result_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutResultModel> createOrder({required CartModel cart});
}

class CheckoutRemoteDataSourceImpl
    implements CheckoutRemoteDataSource {
  const CheckoutRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<CheckoutResultModel> createOrder({
    required CartModel cart,
  }) async {
    final currentUser = client.auth.currentUser;
    if (currentUser == null) {
      throw const ServerException('Người dùng chưa đăng nhập');
    }

    try {
      final totalPrice = cart.items.fold(
        0,
        (sum, item) => sum + item.total,
      );
      final json = await client.rpc<JsonData>(
        'create_order_with_items',
        params: {
          'p_shop_id': cart.shopId,
          'p_user_id': currentUser.id,
          'p_total_price': totalPrice,
          'p_items': cart.items.map((item) => item.toJson()).toList(),
        },
      );

      return CheckoutResultModel.fromJson(json);
    } catch (e) {
      throw const ServerException('Có lỗi khi tạo đơn hàng');
    }
  }
}
