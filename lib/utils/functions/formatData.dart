import 'package:intl_phone_field/phone_number.dart';

class FormatData {
  bool present(args) {
    //print(args.toString());
    //print(!args.toString().isEmpty);
    return !args.toString().isEmpty;
  }

  bool phoneNumber(args) {
    //print((args.toString().split('')[0]));
    return (!args.toString().isEmpty &&
        args.toString().length == 9 &&
        (args.toString().split('')[0] == '6' ||
            args.toString().split('')[0] == '2'));
  }
  
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
