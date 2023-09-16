 
import 'package:EMIY/components/Widget/app_input.dart'; 
import 'package:EMIY/components/Widget/app_text_divider.dart';

import 'package:EMIY/components/Button/customBtn.dart'; 
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/textStyle.dart'; 
import 'package:EMIY/utils/Services/validators.dart'; 
import "package:flutter/material.dart"; 
import 'package:get/get.dart'; 
// import 'package:EMIY/components/informationComponent.dart';
import 'package:EMIY/styles/colorApp.dart'; 
// ignore: must_be_immutable
class UserManageView extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(
      builder: (_manager) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: kMarginX),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text('Solde '),
                      ),
                      Container(
                          child: InkWell(
                              child: Icon(Icons.location_searching_outlined),
                              onTap: () => _manager.deconnectUser())),
                    ],
                  ),
                  Container(
                    child: Text(
                      '${_manager.Compte.solde} XAF',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  AppTextDivider(
                    texte: 'Informations personnels  ',
                  ),
                  Form(
                      key: _manager.formKeyUpdateU,
                      child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: kMarginY * 2,
                              ),
                              child: AppInput(
                                controller: _manager.nameU,
                                label: 'labelname'.tr,
                                icon: Icon(Icons.account_box),
                                validator: (value) {
                                  return Validators.isValidUsername(value!);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: kMarginY * 2,
                              ),
                              child: AppInput(
                                controller: _manager.surnameU,
                                icon: Icon(Icons.account_box),
                                label: 'labelsurname'.tr,
                                validator: (value) {
                                  return Validators.isValidUsername(value!);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: kMarginY * 2,
                              ),
                              child: AppInput(
                                controller: _manager.emailU,
                                icon: Icon(Icons.mail),
                                label: 'labelemail'.tr,
                                validator: (value) {
                                  return Validators.isValidEmail(value);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: kMarginY * 2,
                              ),
                              child: AppInput(
                                controller: _manager.phoneU,
                                label: 'labelphone'.tr,
                                icon: Icon(Icons.phone),
                                validator: (value) {
                                  return Validators.usPhoneValid(value!);
                                },
                              ),
                            ),
                            CustomBtn(
                                color: ColorsApp.secondBlue,
                                title: 'Mettre a jour',
                                onTap: () async {
                                  if (_manager.formKeyUpdateU.currentState!
                                      .validate()) {
                                    await _manager.updateUser();
                                  }
                                })
                          ])),
                  AppTextDivider(
                    texte: 'Mot de passe ',
                  ),
                  Form(
                      key: _manager.formKeyUpdatePassU,
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: kMarginY * 2,
                            ),
                            child: AppInputPassword(
                              controller: _manager.pwdCurrentU,
                              label: 'labelnewpassword'.tr,
                              obscureText: true,
                              validator: (value) {
                                return Validators.isValidPassword(value!);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: kMarginY * 2,
                            ),
                            child: AppInputPassword(
                              controller: _manager.newpwdU,
                              label: 'labelpassword'.tr,
                              obscureText: true,
                              validator: (value) {
                                return Validators.isValidPassword(value!);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kMarginY * 2,
                            ),
                            child: AppInputPassword(
                              controller: _manager.rnewpwdU,
                              label: 'labelrpassword'.tr,
                              obscureText: true,
                              validator: (value) {
                                return Validators.isValidRePassword(
                                    _manager.repass.text != _manager.pass.text);
                              },
                            ),
                          ),
                          CustomBtn(
                              color: ColorsApp.secondBlue,
                              title: 'Mettre a jour',
                              onTap: () async {
                                if (_manager.formKeyUpdatePassU.currentState!
                                    .validate()) {
                                  await _manager.updateUser();
                                }
                              })
                        ],
                      ))
                ])));
      },
    );
  }
}
