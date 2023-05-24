import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  /// Creates an [IconButton] with the appropriate "back" icon for the current
  /// target platform.
  const AppBackButton({Key? key, this.color}) : super(key: key);

  /// The color to use for the icon.
  ///
  /// Defaults to the [IconThemeData.color] specified in the ambient [IconTheme],
  /// which usually matches the ambient [Theme]'s [ThemeData.iconTheme].
  final Color? color;

  /// An override callback to perform instead of the default behavior which is
  /// to pop the [Navigator].
  ///
  /// It can, for instance, be used to pop the platform's navigation stack
  /// via [SystemNavigator] instead of Flutter's [Navigator] in add-to-app
  /// situations.
  ///

  @override
  Widget build(BuildContext context) {
    // assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: Icon(Icons.keyboard_arrow_left_outlined),
      color: Colors.black,
      // tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        Get.back();
      },
    );
  }
}
