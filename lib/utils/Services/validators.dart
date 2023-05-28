import 'package:get/get.dart';

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z!])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String? email) {
    if (email == null) return null;
    return _emailRegExp.hasMatch(email.trim()) ? null : 'invalidMail'.tr;
  }

  static isValidEmailOrNum(String? email) {
    if (email == null) return null;
    return _emailRegExp.hasMatch(email.trim()) ? null : 'invalidMail'.tr;
  }

  static String? isValidPassword(String password) {
    if (password.length < 5) {
      return "invalidCaractP".tr;
    }
    return null;
  }

  static String? isValidRePassword(bool verif) {
    if (verif) {
      return "invalidRepasss".tr;
    }
    return null;
  }

  static isValidUsername(String username) {
    return username.length > 3 ? null : "invalidCaract".tr;
  }

  static usPhoneValid(String input) {
    final RegExp phone =
        RegExp(r'^(\+0?1\s)?((\d{3})|(\(\d{3}\)))?(\s|-)\d{3}(\s|-)\d{4}$');

    if (input.length == 9) {
      if (int.tryParse(input) != null) {
        return null;
      } else {
        return 'invalidPhone'.tr;
      }
    } else {
      return 'invalidPhone'.tr;
    }
  }

  static usNumeriqValid(String input) {
    //print(int.tryParse(input));
    if (int.tryParse(input) != null) {
      return null;
    } else {
      return 'invalidChiffre'.tr;
    }
  }

  static String? required(String field, String? value) {
    if (value == null) return null;
    return value.isEmpty ? " $field Obligatoire" : null;
  }

  static String? isValidDate(String? inputDate) {
    final RegExp date = RegExp(r'/^\d{2}\/\d{2}\/\d{4}$/');

    if (date.hasMatch(inputDate!) == false) {
      return "Invalid date Format";
    }
  }
}
