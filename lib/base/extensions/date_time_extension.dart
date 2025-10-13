import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate {
    return DateFormat('dd.MM.yy').format(this);
  }

  String get formattedTime {
    return DateFormat('HH:mm').format(this);
  }

  String get formattedFullDate {
    return DateFormat('dd.MM.yy, HH:mm').format(this);
  }
}
