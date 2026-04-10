enum OrderStatus {
  confirmed('confirmed'),
  ready('ready'),
  completed('completed'),
  cancelled('cancelled');

  const OrderStatus(this.value);

  final String value;

  /// Parse từ DB
  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => OrderStatus.confirmed,
    );
  }
}
