import 'package:intl/intl.dart';

class FormatDateTime {
  String dateToMonth(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("MMM").format(dateTime);
  }

  String dateToDay(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("d").format(dateTime);
  }

  String dateToYear(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("yyyy").format(dateTime);
  }

  String formatTime(value) {
    final dateTime = DateTime.parse(value);
    final format = DateFormat('HH:mm');
    final clockString = format.format(dateTime);
    return clockString;
  }

   
}
