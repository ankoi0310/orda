import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  const OrderItem({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
