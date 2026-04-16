import 'package:equatable/equatable.dart';

class WeekdayStats extends Equatable {
  const WeekdayStats({
    required this.weekday,
    required this.totalOrders,
    required this.totalSpending,
  });

  final int weekday;
  final int totalOrders;
  final int totalSpending;

  @override
  List<Object?> get props => [weekday, totalOrders, totalSpending];
}
