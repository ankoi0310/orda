import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/date_time_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';
import 'package:orda/features/order/presentation/widgets/order_detail_modal.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
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
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is LoadingOrderHistory) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OrderError) {
              return Center(child: Text(state.message));
            }

            if (state is LoadOrderHistorySuccess) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('Chưa có đơn nào'));
              }

              final ordersGroupedByDate = <DateTime, List<Order>>{};
              for (final order in state.orders) {
                final local = order.createdAt;

                final dateOnly = DateTime(
                  local.year,
                  local.month,
                  local.day,
                );

                ordersGroupedByDate.putIfAbsent(dateOnly, () => []);
                ordersGroupedByDate[dateOnly]!.add(order);
                print(order.createdAt);
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: ordersGroupedByDate.entries.map((
                      entry,
                    ) {
                      final date = entry.key;
                      final orders = entry.value;

                      return Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          Text(date.format()),
                          ListView.separated(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              final order = orders[index];
                              return GestureDetector(
                                onTap: () async {
                                  await showModalBottomSheet<void>(
                                    context: context,
                                    useRootNavigator: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.directional(
                                            topStart: Radius.circular(
                                              16,
                                            ),
                                            topEnd: Radius.circular(
                                              16,
                                            ),
                                          ),
                                    ),
                                    builder: (context) {
                                      return OrderDetailModal(
                                        order: order,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    border: Border.all(
                                      color: context.colors.outline,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: .stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            '#${order.orderNumber}',
                                            style: context
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          buildOrderStatus(
                                            context,
                                            order.status,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            '${order.totalItems} món',
                                          ),
                                          Text(
                                            order.totalPrice.toVND(),
                                            style: const TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(order.createdAt.format()),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Container buildOrderStatus(
    BuildContext context,
    OrderStatus status,
  ) {
    late Color backgroundColor, textColor;

    switch (status) {
      case OrderStatus.confirmed:
      case OrderStatus.preparing:
      case OrderStatus.completed:
        backgroundColor = context.colors.outlineVariant;
        textColor = context.colors.primary;
      case OrderStatus.cancelled:
        backgroundColor = context.colors.errorContainer;
        textColor = context.colors.error;
    }
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.label,
        style: context.textTheme.bodyMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
