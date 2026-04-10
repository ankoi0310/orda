import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/extensions/string_extension.dart';
import 'package:orda/features/order/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrderList({
    DateTime? from,
    DateTime? to,
    List<String>? statuses,
  });

  Future<OrderModel> getOrder({required String id});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  const OrderRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<OrderModel>> getOrderList({
    DateTime? from,
    DateTime? to,
    List<String>? statuses,
  }) async {
    var query = client.from('orders').select();

    if (from != null) {
      query = query.gte('created_at', from.toIso8601String());
    }

    if (to != null) {
      query = query.lte('created_at', to.toIso8601String());
    }

    if (statuses != null) {
      query = query.inFilter('status', statuses);
    }

    final jsonList = await query;

    return jsonList.map(OrderModel.fromJson).toList();
  }

  @override
  Future<OrderModel> getOrder({required String id}) async {
    if (id.isValidUuid) {
      throw const ServerException('Mã đơn hàng không hợp lệ');
    }

    final json = await client
        .from('orders')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (json == null) {
      throw const ServerException('Đơn hàng không tồn tại');
    }

    return OrderModel.fromJson(json);
  }
}
