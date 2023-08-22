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
  /* VideoPlayerController? */ var controller;
  final dababase = Get.find<DataBaseController>();
  var fn = new ViewFunctions();

  bool _forYou = true;
  bool get forYou => _forYou;
  setForYou(val) {
    _forYou = val;
    update();
  }

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
    if (listShort.isNotEmpty) {
      //  }else{}
      print(
          '-debut lecture short -----------${index}---------------------------' +
              listShort[index].src);
      _initialise = false;

      listShort[index].loadController();
      controller = listShort[index].controller;

      update();
      controller.play();
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
      });
      bool getNext =
          listShort.length < 2 ? true : index + 2 == listShort.length;
      if (getNext) {
        await getListShort();
      }
      await readShort(listShort[index].codeShortInit);

      return 0;
    }
  }

  Future<void> readShort(codeShort) async {
    // //print('***short******************response**********');
    var key = await dababase.getKey();

    if (_loaddata == false) {
      print('-------in readddddddd----get---');
      _isLoadedP = 0;
      // _loaddata = true;
      // update();
      try {
        Response response = await shortRepo.readShort(codeShort, key);

        print('read**************************');

        print(
            'read=+++}+++${response.body}+++++++++++++++++++++++}-=======================================================');
      } catch (e) {
        //print(e);
      }
    }
  }

  dispose() {
    super.dispose();
    // listShort[_currentShort].controller?.dispose();
    listShort[_currentShort].controller?.pause();

    controller!.pause();
    // controller!.dispose();
  }

  disposePLayer() {
    if (controller != null) {
      print(
          '--------------${controller!.value.isInitialized}----------is dispose');
      ;

      // update();
    }
  }

  disposePLayerAll() {
    print('------------------------is dispose');
    // listShort[_currentShort].controller.dispose();
    if (controller != null) {
      listShort[_currentShort].controller?.dispose(); // controller!.dispose();

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

      // getListShort();
    }
  }

  bool _loaddata = false;
  bool _intoShortView = false;
  bool get intoShortView => _intoShortView;
  setIntoShortView(val) {
    _intoShortView = val;
    update();
  }

  List<ShortModel> _listShortSave = [];
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

              _listShort.addAll((response.body['data'] as List)
                  .map((e) => ShortModel.fromJson(e))
                  .toList());
              _listShortSave.addAll((response.body['data'] as List)
                  .map((e) => ShortModel.fromJson(e))
                  .toList());
              indexC++;
              print(_listShort.length);
              currentShortData = _listShort.first;
              print(
                  '_listShort=+++}+++++++++++++++++++++++++++}-=======================================================');
              _loaddata = false;
              _isLoadedP = 1;
              update();
              print(_isLoadedP);
              if (indexC - 1 == 1 && intoShortView) {
                print(
                    '----------------------------------- ${_listShort.length}');
                changeVideo(0);
              }
            }
          }
        }
      } catch (e) {
        _loaddata = false;
        update();
        //print(e);
      }
    } else {
      print('***pppppp bouriqe******************response**********');
    }
  }

  cleanListShort() {
    _listShort = [];
    _listShort.clear();
    // controller = null;
    currentShortData = null;
    indexC = 1;
    indexC2 = 1;
    _listShort = _listShortSave;
    update();
  }

  int indexC2 = 1;
  int _isLoadedForBoutiqueShort = 0;
  int get isLoadedForBoutiqueShort => _isLoadedForBoutiqueShort;
  Future<void> getListShortForBoutique(codeBoutique) async {
    print('***short bouriqe******************response**********');

    _isLoadedForBoutiqueShort = 0;

    _listShort = [];
    _listShort.clear();
    update();
    var key = await dababase.getKey();
    try {
      Response response =
          await shortRepo.getListShortForBoutique(codeBoutique, key, indexC2);

      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            _listShort.addAll((response.body['data'] as List)
                .map((e) => ShortModel.fromJson(e))
                .toList());
            indexC2++;
            print('***short bouriqe*********ok*********response**********');

            print(_listShort.length);
            currentShortData = _listShort.first;
          }
          changeVideo(0);
          setCurrent(0);
          _isLoadedForBoutiqueShort = 1;
          update();
        }
      }
    } catch (e) {
      //print(e);
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
  get currentShortData0 => currentShortData;
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

  var _refCom;
  get refCom => _refCom;
  //CommentShortModel
  setIdRef(ref) {
    _refCom = ref;
    _textEditingController.selection;
    update();
  }

  newCommentShort() async {
    if (textEditingController.text.length == 0) {
      _sendComment = false;
      update();
      return false;
    }
    _sendComment = true;
    update();
    var key = await dababase.getKey();
    var data = refCom == null
        ? {
            'id': currentShortData.id,
            'keySecret': key,
            'comment': textEditingController.text
          }
        : {
            'idRef': refCom.id,
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

            if (refCom == null) {
              _listCommentShort.insert(
                  0, CommentShortModel.fromJson(response.body['commentaire']));
              int index = _listShort
                  .indexWhere((short) => short.id == currentShortData.id);
              if (index >= 0) {
                _listShort[index].nbre_commentaire = _listCommentShort.length;

                update();
              }
            } else {
              int index =
                  _listCommentShort.indexWhere((com) => com.id == refCom.id);
              if (index >= 0) {
                _listCommentShort[index].nbre_com =
                    _listCommentShort[index].nbre_com + 1;
                _listCommentShort[index].comments.add(
                    CommentShortModel.fromJson(response.body['commentaire']));

                update();
              }
            }
            fn.notifivation(
              'Commente',
            );
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
  bool loadingC = false;
  getListCommentShort() async {
    if (!loadingC) {
      _listCommentShort = [];
      _loadComment = 0;
      _idCurrentComment = 0;
      loadingC = true;
      _refCom = null;
      _sendComment = false;
      update();
      var key = await dababase.getKey();

      try {
        Response response =
            await shortRepo.getListComment(currentShortData.id, key);

        if (response.statusCode == 200) {
          if (response.body != null) {
            if (response.body['data'] != null) {
              print(response.body['data']);

              _listCommentShort.addAll((response.body['data'] as List)
                  .map((e) => CommentShortModel.fromJson(e))
                  .toList());
              _loadComment = 1;
              loadingC = false;
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

  int _idCurrentComment = 0;
  int get idCurrentComment => _idCurrentComment;
  int _loadCommentComment = 1;
  int get loadCommentComment => _loadCommentComment;
  getListCommentCommentShort(CommentShortModel currentComment) async {
    update();
    if (_loadComment == 1) {
      _loadCommentComment = 0;
      _idCurrentComment = currentComment.id;
      update();
      var key = await dababase.getKey();

      try {
        Response response =
            await shortRepo.getListCommentComment(currentComment.id, key);

        if (response.statusCode == 200) {
          if (response.body != null) {
            if (response.body['data'] != null) {
              print(response.body['data']);

              currentComment.comments.addAll((response.body['data'] as List)
                  .map((e) => CommentShortModel.fromJson(e))
                  .toList());
              _loadCommentComment = 1;

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

  newLikeShortCom(CommentShortModel comselect, type) async {
    var com;
    // var commentF = _listCommentShort[
    //     _listCommentShort.indexWhere((comm) => comm.id == currentComment.id)];
    if (type == 0) {
      com = _listCommentShort[
          _listCommentShort.indexWhere((short) => short.id == comselect.id)];
      com.nbre_like_com =
          com.is_like_com ? com.nbre_like_com - 1 : com.nbre_like_com + 1;
      com.is_like_com = !com.is_like_com;
      update();
    }

    if (type == 1) {
      com = comselect;
      com.nbre_like_com =
          com.is_like_com ? com.nbre_like_com - 1 : com.nbre_like_com + 1;
      com.is_like_com = !com.is_like_com;
      update();
    }
    var key = await dababase.getKey();

    try {
      var data = {'id': com.id, 'keySecret': key};
      print(data);
      Response response = await shortRepo.newLikeComment(data);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['short'] != null) {
            print(response.body['short']);
            var newShortComm =
                CommentShortModel.fromJson(response.body['short']);

            com = newShortComm;

            update();
          }
        }
      } else {
        com.nbre_like_com =
            !com.is_like_com ? com.nbre_like_com - 1 : com.nbre_like_com + 1;
        update();
      }
    } catch (e) {
      // fn.closeSnack();
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      com.nbre_like_com =
          !com.is_like_com ? com.nbre_like_com - 1 : com.nbre_like_com + 1;
      com.is_like_com = !com.is_like_com;
      update();
      //print(e);
    }
  }

  // late ScrollController _controllerT;
  // get controllerT => _controllerT;

  ScrollController _scrollController = new ScrollController();
  get scrollController => _scrollController;

  void _scrollToEnd() {
    print(
      '--------------------------  ${_scrollController.position.maxScrollExtent}',
    );
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    update();
  }

  var _isUniqueVideoPlayer;
  get isUniqueVideoPlayer => _isUniqueVideoPlayer;
  int _isUnique = 0;
  get isUnique => _isUnique;
  getUniqueShort(idShort, code) async {
    update();
    _isUnique = 0;

    update();
    var key = await dababase.getKey();

    try {
      Response response = await shortRepo.getUniqueShort(idShort, code, key);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['data'] != null) {
            print('--short----------***************************');
            print(response.body['data']);

            currentShortData = ShortModel.fromJson(response.body['data']);
            _isUnique = 1;

            currentShortData.loadController();
            _isUniqueVideoPlayer = currentShortData.controller;
            update();
            print("-----short+++++++---------------$currentShortData0.id");
          }
        }
      }
    } catch (e) {
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

      update();
      //print(e);
    }
  }

  newLikeShortComSecond() async {
    var key = await dababase.getKey();

    try {
      var data = {'id': currentShortData.id, 'keySecret': key};
      print(data);
      Response response = await shortRepo.newLikeComment(data);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['short'] != null) {
            print(response.body['short']);
            var newShortComm =
                CommentShortModel.fromJson(response.body['short']);

            currentShortData = newShortComm;

            update();
          }
        }
      } else {
        currentShortData.nbre_like_com = !currentShortData.is_like_com
            ? currentShortData.nbre_like_com - 1
            : currentShortData.nbre_like_com + 1;
        update();
      }
    } catch (e) {
      // fn.closeSnack();
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      currentShortData.nbre_like_com = !currentShortData.is_like_com
          ? currentShortData.nbre_like_com - 1
          : currentShortData.nbre_like_com + 1;
      currentShortData.is_like_com = !currentShortData.is_like_com;
      update();
      //print(e);
    }
  }

  disposeUniquePLayer() {
    // currentShortData.controller.dispose();
    if (_isUniqueVideoPlayer != null) {
      _isUniqueVideoPlayer!.dispose();

      update();
    }
  }
}
