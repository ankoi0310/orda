import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadOrderHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt hàng'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<OrderBloc>().add(LoadOrderHistory());
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderError) {
              return Center(child: Text(state.message));
            }

            if (state is LoadOrderHistorySuccess) {
              final orders = state.orders;

              if (orders.isEmpty) {
                return Center(child: Text('Chưa có đơn nào'));
              }

              return Text('Danh sach don hang');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
