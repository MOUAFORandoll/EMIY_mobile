import 'dart:math';

import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("Nom du titulaire de la carte"),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Nom complet",
              ),
            ),
            SizedBox(height: 20),
            Text("Numéro de carte"),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "XXXX XXXX XXXX XXXX",
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date d'expiration"),
                      TextField(
                        controller: _expiryDateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "MM/YY",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CVV"),
                      TextField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "XXX",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Envoyer les informations de paiement au serveur
              },
              child: Text("Payer"),
            ),
          ],
        ),
      ),
    );
  }
}
