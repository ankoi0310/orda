import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  /// Format theo pattern (dd/MM/yyyy, HH:mm, ...)
  String format([String pattern = 'dd/MM/yyyy']) {
    return DateFormat(pattern).format(this);
  }

  /// Format giờ phút
  String get hhmm => DateFormat('HH:mm').format(this);

  /// Format đầy đủ
  String get fullDateTime =>
      DateFormat('dd/MM/yyyy HH:mm').format(this);

  String get fullTimeDate {
    return DateFormat('HH:mm, dd/MM/yyyy').format(this);
  }

  /// So sánh cùng ngày
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  /// Là hôm nay
  bool get isToday => isSameDate(DateTime.now());

  /// Là hôm qua
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(
      const Duration(days: 1),
    );
    return isSameDate(yesterday);
  }

  /// Đầu ngày (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Cuối ngày (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// Time ago (5 phút trước, 2 ngày trước...)
  String timeAgo({bool short = false}) {
    final diff = DateTime.now().difference(this);

    if (diff.inSeconds < 60) {
      return short ? 'vừa xong' : 'vừa xong';
    } else if (diff.inMinutes < 60) {
      return short
          ? '${diff.inMinutes}p'
          : '${diff.inMinutes} phút trước';
    } else if (diff.inHours < 24) {
      return short ? '${diff.inHours}h' : '${diff.inHours} giờ trước';
    } else if (diff.inDays < 7) {
      return short ? '${diff.inDays}d' : '${diff.inDays} ngày trước';
    } else {
      return format();
    }
  }

  /// So sánh trước/sau
  bool isBeforeOrEqual(DateTime other) =>
      isBefore(other) || isAtSameMomentAs(other);

  bool isAfterOrEqual(DateTime other) =>
      isAfter(other) || isAtSameMomentAs(other);

  /// Cộng/trừ ngày
  DateTime addDays(int days) => add(Duration(days: days));

  DateTime subtractDays(int days) => subtract(Duration(days: days));
}
