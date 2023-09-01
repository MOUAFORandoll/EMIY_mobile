import 'package:toast/toast.dart';

toastShow(message, color, context) {
  Toast.show(
    message,

    duration: 6,
    // gravity: Toast.BOTTOM,
    backgroundColor: color,
  );
}
