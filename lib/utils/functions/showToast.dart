import 'package:toast/toast.dart';

toastShow(message, color, context) {
  Toast.show(
    message,
    context,
    duration: 6,
    gravity: Toast.BOTTOM,
    backgroundColor: color,
  );
}
