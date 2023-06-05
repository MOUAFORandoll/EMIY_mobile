import 'dart:io';

import 'package:Fahkap/model/data/BoutiqueModel.dart';
import 'package:Fahkap/model/data/BoutiqueUserModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/CommandeBoutiqueModel.dart';
import 'package:Fahkap/model/data/ProduitBoutiqueModel.dart';
import 'package:Fahkap/model/data/ShortModel.dart';
import 'package:Fahkap/repository/ShortRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/Services/storageService2.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:video_player/video_player.dart';

class ShortController extends GetxController {
  final service = new ApiService();
  VideoPlayerController? controller;
  // ChewieController? chewieController;
  final ShortRepo shortRepo;
  ShortController({required this.shortRepo});
  List<ShortModel> _listShort = [];
  bool _initialise = false;
  bool get initialise => _initialise;
  double _progressValue = 0;
  double get progressValue => _progressValue;

  changeVideoSlide(index) async {
    _progressValue = controller!.value.position.inSeconds.toDouble() /
        controller!.value.duration.inSeconds.toDouble();
    update();
    controller!.seekTo(Duration(seconds: index.toInt()));
  }

  changeVideoSlide0() async {
    _progressValue = controller!.value.position.inSeconds.toDouble() /
        controller!.value.duration.inSeconds.toDouble();
    update();
  }

  changeVideo(index) async {
    // listShort[index].controller.initialize();
    //print('---------------------');
    _initialise = false;
    // update();
    // ignore: unnecessary_null_comparison
    // if (listShort[index].controller == null) {
    listShort[index].loadController();
    // }
    // changeVideoSlide(0.0);
    controller = listShort[index].controller;

    controller!.play();
    _initialise = true;
    // update();
    // ignore: unused_local_variable
    int prevVideo = (index - 1) > 0 ? index - 1 : 0;
    // ignore: unnecessary_null_comparison
    // if (listShort[prevVideo].controller != null) controller!.pause();

    //print(index);
    controller!.addListener(() async {
      //print('0000');

      _progressValue = Get.find<ShortController>()
                  .controller!
                  .value
                  .duration
                  .inSeconds
                  .toDouble() ==
              0
          ? 0
          : Get.find<ShortController>()
                  .controller!
                  .value
                  .position
                  .inSeconds
                  .toDouble() /
              Get.find<ShortController>()
                  .controller!
                  .value
                  .duration
                  .inSeconds
                  .toDouble();
      update();
      // //print(
      //   'poition******${_progressValue}',
      // );
      if (_progressValue == 1) {
        // await listShort[index].loadController();

        // //print(
        //   'ici***************',
        // );
      }
    });

    return 0;
  }

  disposePLayer() {
    if (controller != null) {
      controller!.pause();

      update();
    }
  }

  List<ShortModel> get listShort => _listShort;
  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;
  int _isCurrent = 0;
  int get isCurrent => _isCurrent;
  setCOurrent(indexC) {
    _isCurrent = indexC;
    update();
  }

  late PageController _pageController;
  get pageController => _pageController;
  @override
  void onInit() {
    print('-----------init--------------');

    super.onInit();
    _pageController = PageController(initialPage: 0);
    _pageController = PageController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    print('-----------uuuuuuuu---');

    if (isCurrent + 3 >= _listShort.length) {
      print('-----------00000000---');

      getListShort();
    }
  }

  bool _loaddata = false;
  bool get loaddata => _loaddata;

  int indexC = 1;
  Future<void> getListShort() async {
    // //print('***short******************response**********');

    if (_loaddata == false) {
      print('-----------get---');
      _isLoadedP = 0;
      _loaddata = true;
      update();
      try {
        Response response = await shortRepo.getListShort(indexC);

        // _listShort = [];
        // _listShort.clear();
        // update();
        print(
            '-----------------------------------88888${response.body['data']}');
        if (response.body != null) {
          if (response.body['data'] != null) {
            if (response.body['data'].length != 0) {
              //print('short**************************');
              //print(response.body['data']);
              _listShort.addAll((response.body['data'] as List)
                  .map((e) => ShortModel.fromJson(e))
                  .toList());
            }
            _isLoadedP = 1;
           indexC++;

            _loaddata = false;
            update();
          }
        }
      } catch (e) {
        _loaddata = false;
        update();
        //print(e);
      }
    }
  }

  int _currentShort = 0;
  int get currentShort => _currentShort;
  setCurrent(index) {
    _currentShort = index;
    update();
  }
}
