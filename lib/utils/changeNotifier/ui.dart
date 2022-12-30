import 'package:flutter/material.dart';

class UI with ChangeNotifier {
  bool theme = false;
  set choiseTheme(themefinal) {
    theme = themefinal;
    notifyListeners();
  }

  get choiseTheme => theme;

  get changeTheme => theme;
}

class IsRead with ChangeNotifier {
  bool read = true;
  bool close = false;
  set changeState(newRead) {
    read = newRead;
    notifyListeners();
  }
  set closeState(newClose) {
    close = newClose;
    notifyListeners();
  }
  get start => read;

  get changeTheme => read;
}
