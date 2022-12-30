import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: smallText(text: 'Search')),
    );
  }
}
