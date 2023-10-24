import 'package:EMIY/components/Button/AppIconButton.dart';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../styles/colorApp.dart';

// ignore: must_be_immutable
class ShareButton extends StatelessWidget {
  var libelle;
  ShareButton({this.libelle});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onTap: () {
        Share.share(libelle, subject: 'Look what I made!');
      },
      icon: Icons.share,
      color : ColorsApp.secondBlue,
    );
  }
}
