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

  String dateToSimpleDate(value) {
    DateTime dateTime = DateTime.parse(value);

    DateFormat formatter = DateFormat("dd/MM/yyyy HH:mm");
    String formattedDate = formatter.format(dateTime);
    return formattedDate.toString().split(' ')[0] +
        ' ' +
        'a' +
        ' ' +
        formattedDate.toString().split(' ')[1];
  }

  String formatTime(value) {
    final dateTime = DateTime.parse(value);
    final format = DateFormat('HH:mm');
    final clockString = format.format(dateTime);
    return clockString;
  }
}
