import 'package:intl/intl.dart';

extension CurrencyFormatting on num {
  /// 1,000
  String toDecimal({String locale = 'en'}) {
    return NumberFormat.decimalPattern(locale).format(this);
  }

  /// 1,000.50
  String toDecimal2({String locale = 'en'}) {
    return NumberFormat('#,##0.00', locale).format(this);
  }

  /// $1,000.50
  String toCurrency({String locale = 'vi_VN', String symbol = 'đ'}) {
    return NumberFormat.currency(
      locale: locale,
      symbol: symbol,
    ).format(this);
  }

  /// 1.000 ₫
  String toVND() {
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(this);
  }

  /// 50%
  String toPercent({String locale = 'en'}) {
    return NumberFormat.percentPattern(locale).format(this);
  }
}
