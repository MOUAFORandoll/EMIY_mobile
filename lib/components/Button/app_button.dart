import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String text;
  final Widget? leading;
  final VoidCallback? onTap;
  final bool disabled;
  final MainAxisSize size;
  final BoxBorder? border;
  AppButton({
    Key? key,
    required this.text,
    this.bgColor = ColorsApp.blue,
    this.textColor = Colors.white,
    this.onTap,
    this.leading,
    this.border,
    this.disabled = false,
    this.size = MainAxisSize.min,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 35),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: disabled ? bgColor.withOpacity(.5) : bgColor,
            border: border),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: size,
          children: [
            if (leading != null)
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: leading!,
              ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: disabled ? textColor.withOpacity(.5) : textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
