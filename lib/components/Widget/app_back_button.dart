import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';

// ignore: must_be_immutable
class AppBackButton extends StatelessWidget {
  /// Creates an [IconButton] with the appropriate "back" icon for the current
  /// target platform.
  AppBackButton({Key? key, this.color, this.backEvent}) : super(key: key);

  /// The color to use for the icon.
  ///
  /// Defaults to the [IconThemeData.color] specified in the ambient [IconTheme],
  /// which usually matches the ambient [Theme]'s [ThemeData.iconTheme].
    Color? color = Colors.white;
  var backEvent;

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
    return InkWell(
      child: Container(
        margin: EdgeInsets.zero,
        // padding: EdgeInsets.all(5),
        decoration: BoxDecoration(

            // borderRadius: BorderRadius.circular(20),
            ),
        child: Icon(Icons.arrow_back_ios_new, color: color, size: 25.0),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
