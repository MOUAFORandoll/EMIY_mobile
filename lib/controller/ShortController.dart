import 'dart:io';

import 'package:EMIY/model/data/BoutiqueModel.dart';
import 'package:EMIY/model/data/BoutiqueUserModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/CommandeBoutiqueModel.dart';
import 'package:EMIY/model/data/CommentShortModel.dart';
import 'package:EMIY/model/data/ProduitBoutiqueModel.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/repository/ShortRepo.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/utils/Services/storageService2.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:video_player/video_player.dart';

class ShortController extends GetxController {
  final service = new ApiService();
  VideoPlayerController? controller;
  final dababase = Get.find<DataBaseController>();

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
    print(listShort[index].src);
    _initialise = false;

    listShort[index].loadController();
    controller = listShort[index].controller;

    controller!.play();
    _initialise = true;

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
    var key = await dababase.getKey();

    if (_loaddata == false) {
      print('-----------get---');
      _isLoadedP = 0;
      _loaddata = true;
      update();
      try {
        Response response = await shortRepo.getListShort(indexC, key);

        // _listShort = [];
        // _listShort.clear();
        // update();

        if (response.body != null) {
          if (response.body['data'] != null) {
            if (response.body['data'].length != 0) {
              print('short**************************');

              // (response.body['data'] as List).forEach((e) async {
              //   var ver = await checkVideoFormat(e['src']);
              //   print(e['src']);
              //   print(ver);
              //   if (ver == true) {
              //     print('---------------------------------is ok');
              //     _listShort.add((ShortModel.fromJson(e)));
              //     update();
              //     // print(
              //     //     '----------------------------------- ${_listShort.length}');
              //   } else {
              //     print('---------------------------------is errorrr');
              //   }
              // });
              _listShort.addAll((response.body['data'] as List)
                  .map((e) => ShortModel.fromJson(e))
                  .toList());
              indexC++;
              print(_listShort.length);
              currentShortData = _listShort.first;
              _loaddata = false;
              _isLoadedP = 1;
              update();
              print(_isLoadedP);
            }
          }
        }
      } catch (e) {
        _loaddata = false;
        update();
        //print(e);
      }
    }
  }

  late VideoPlayerController _controller;
  Future checkVideoFormat(videoUrl) async {
    _controller = VideoPlayerController.network(videoUrl);

    try {
      await _controller.initialize();
      return true;
    } catch (error) {
      print('Erreur de format vidéo : $error');
      return false;
    }
  }

  int _currentShort = 0;
  int get currentShort => _currentShort;
  var currentShortData;
  setCurrent(index) {
    _currentShort = index;
    currentShortData = _listShort[_currentShort];
    update();
  }

  newLikeShort() async {
    currentShortData.nbre_like = currentShortData.is_like
        ? currentShortData.nbre_like - 1
        : currentShortData.nbre_like + 1;
    currentShortData.is_like = !currentShortData.is_like;
    update();
    var key = await dababase.getKey();

    try {
      var data = {'id': currentShortData.id, 'keySecret': key};
      print(data);
      Response response = await shortRepo.newLike(data);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['short'] != null) {
            print(response.body['short']);
            var newShort = ShortModel.fromJson(response.body['short']);

            int index =
                _listShort.indexWhere((short) => short.id == newShort.id);
            if (index >= 0) {
              _listShort[index] = newShort;

              update();
            }
            update();
          }
        }
      } else {
        currentShortData.nbre_like = !currentShortData.is_like
            ? currentShortData.nbre_like - 1
            : currentShortData.nbre_like + 1;
        update();
      }
    } catch (e) {
      // fn.closeSnack();
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      currentShortData.nbre_like = !currentShortData.is_like
          ? currentShortData.nbre_like - 1
          : currentShortData.nbre_like + 1;
      currentShortData.is_like = !currentShortData.is_like;
      update();
      //print(e);
    }
  }

  bool _sendComment = false;
  bool get sendComment => _sendComment;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;
  newCommentShort() async {
    _sendComment = true;
    update();
    var key = await dababase.getKey();
    var data = {
      'id': currentShortData.id,
      'keySecret': key,
      'comment': textEditingController.text
    };
    try {
      textEditingController.text = '';
      print(data);
      Response response = await shortRepo.newComment(data);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['commentaire'] != null) {
            print(response.body['commentaire']);

            _sendComment = false;
            _listCommentShort
                .add(CommentShortModel.fromJson(response.body['commentaire']));
            int index = _listShort
                .indexWhere((short) => short.id == currentShortData.id);
            if (index >= 0) {
              _listShort[index].nbre_commentaire = _listCommentShort.length;

              update();
            }
            update();
          }
        }
      } else {
        textEditingController.text = data['comment'];
        update();
      }
    } catch (e) {
      textEditingController.text = data['comment'];
      // fn.closeSnack();
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      _sendComment = false;
      update();
      //print(e);
    }
  }

  List<CommentShortModel> _listCommentShort = [];
  List<CommentShortModel> get listCommentShort => _listCommentShort;

  int _loadComment = 0;
  int get loadComment => _loadComment;
  getListCommentShort() async {
    _listCommentShort = [];
    _loadComment = 0;
    update();

    try {
      Response response = await shortRepo.getListComment(currentShortData.id);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['data'] != null) {
            print(response.body['data']);

            _listCommentShort.addAll((response.body['data'] as List)
                .map((e) => CommentShortModel.fromJson(e))
                .toList());
            _loadComment = 1;
            update();
          }
        }
      }
    } catch (e) {
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

      update();
      //print(e);
    }
  }
}
