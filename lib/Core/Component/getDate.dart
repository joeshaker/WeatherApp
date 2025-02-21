import 'package:intl/intl.dart';

String getDayName(String dateString) {
  DateTime date = DateTime.parse(dateString); // Convert string to DateTime
  return DateFormat('EEEE').format(date); // Get full day name
}