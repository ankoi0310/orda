import 'package:equatable/equatable.dart';

class MonthlyStats extends Equatable {
  const MonthlyStats({
    required this.totalOrders,
    required this.monthSpending,
  });

  final int totalOrders;
  final int monthSpending;

  @override
  List<Object?> get props => [totalOrders, monthSpending];
}
