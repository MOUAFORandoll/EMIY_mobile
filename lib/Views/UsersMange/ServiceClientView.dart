import 'package:EMIY/components/Button/AppIconSendButton.dart';
import 'package:EMIY/components/Widget/InputMessaage.dart';
import 'package:EMIY/components/Widget/OwnMessgaeCrad.dart';
import 'package:EMIY/components/Widget/ReplyCard.dart';
import 'package:EMIY/controller/ServiceClientController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ServiceClientView extends StatefulWidget {
  ServiceClientView({Key? key}) : super(key: key);

  @override
  State<ServiceClientView> createState() => _ServiceClientViewState();
}

class _ServiceClientViewState extends State<ServiceClientView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    print(scrollController.position.maxScrollExtent);
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceClientController>(builder: (_sc) {
      return Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: ColorsApp.bleuLight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: kWidth / 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorsApp.textBlue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.supervised_user_circle,
                                        color: ColorsApp.white,
                                      ),
                                    ),
                                    Text(
                                      'service client',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorsApp.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.call,
                                  color: ColorsApp.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2, bottom: 3),
                          child: Text(
                            'Posez vos questions ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorsApp.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 2, bottom: 3),
                                  height: 3,
                                  width: kMdWidth * .5,
                                  decoration: BoxDecoration(
                                    gradient: GradientApp.blueG,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      width: double.maxFinite,
                    ),
                  ),
                  expandedHeight: 150,
                  floating: false,
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                      child: ListView.builder(
                        shrinkWrap: true,
                        // controller: scrollController,
                        physics: const BouncingScrollPhysics(),
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
                    childCount: 1,
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              /*    Container(
                    margin: EdgeInsets.symmetric(horizontal: kMarginX),
                    child:  */
              InputMessaage(
                controller: _sc.textEditingController,
              ),
              AppIconSendButton(
                  icon: Icons.send,
                  sending: _sc.sending,
                  onTap: () => _sc.newMessageMessageEchange()),
            ],
          ),
        ),
      );
    });
  }
}
