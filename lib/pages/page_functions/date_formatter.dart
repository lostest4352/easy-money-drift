import 'package:intl/intl.dart';

const String monthFormatter = "MMMM, y";
const String dayFormatter = "MMMM d, y: EEEE";
const String shortDayFormatter = "d MMM y";

extension DateHelper on DateTime {
  String formatMonth() {
    final formatter = DateFormat(monthFormatter);
    return formatter.format(this);
  }

  String formatDay() {
    final formatter = DateFormat(dayFormatter);
    return formatter.format(this);
  }

  String formatDayShort() {
    final formatter = DateFormat(shortDayFormatter);
    return formatter.format(this);
  }
}
