import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BoxInputMessaage extends StatelessWidget {
  BoxInputMessaage(
      {this.controller, this.hint, this.sending = false, this.onTap});
  var onTap, inconSize, sending;

  final controller;
  String? hint = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: ColorsApp.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorsApp.secondBlue,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 22.0),
            ),
          ),
          Flexible(
            flex: 10,
            child: Container(
              constraints:
                  BoxConstraints(maxHeight: kHeight / 3, minHeight: 18),
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: TextField(
                controller: controller,
                maxLines: null,
                onChanged: (val) {},
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                  labelText: hint,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 5,
                  ),
                ),
              ),
            ),
          ),
          !sending
              ? InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorsApp.secondBlue,
                    ),
                    child: Container(
                        width: 22,
                        height: 22,
                        child:
                            Icon(Icons.send, color: Colors.white, size: 22.0)),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsApp.secondBlue,
                  ),
                  child: Container(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: ColorsApp.greenLight,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
