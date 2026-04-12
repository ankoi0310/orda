enum PaymentMethod {
  cash('Tiền mặt'),
  vnpay('VNpay'),
  momo('MoMo'),
  zalopay('Zalopay');

  const PaymentMethod(this.label);

  final String label;
}
