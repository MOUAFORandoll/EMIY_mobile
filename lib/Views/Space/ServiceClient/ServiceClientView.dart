import 'package:EMIY/components/Button/AppIconSendButton.dart';
import 'package:EMIY/components/Widget/InputMessaage.dart';
import 'package:EMIY/components/Widget/OwnMessgaeCrad.dart';
import 'package:EMIY/components/Widget/ReplyCard.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/controller/ServiceClientController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ServiceClientView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceClientController>(builder: (_sc) {
      return _sc.isLoadEchange == 0
          ? AppLoading()
          : Stack(
              children: [
                SizedBox(
                  height: kHeight * .75,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: _sc.listMessageEchange.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _sc.listMessageEchange.length) {
                        return Container(
                          height: 70,
                        );
                      }
                      if (_sc.listMessageEchange[index].emetteurId ==
                          _sc.idUser) {
                        return OwnMessageCard(
                          message: _sc.listMessageEchange[index].message,
                          time: _sc.listMessageEchange[index].heure,
                        );
                      } else {
                        return ReplyCard(
                          message: _sc.listMessageEchange[index].message,
                          time: _sc.listMessageEchange[index].heure,
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    // height: 170,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(color: ColorsApp.white),
                    child: Row(
                      children: [
                        InputMessaage(
                          controller: _sc.textEditingController,
                        ),
                        AppIconSendButton(
                          icon: Icons.send,
                          sending: _sc.sending,
                          onTap: () => _sc.newMessageMessageEchange(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
    });
  }
}
