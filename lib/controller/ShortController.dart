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
  final ShortRepo shortRepo;
  ShortController({required this.shortRepo});
  final service = new ApiService();
  var controller;

  final dababase = Get.find<DataBaseController>();
  var fn = new ViewFunctions();

  void onInit() async {
    super.onInit();
    _pageController = PageController(initialPage: 0);
    _pageController = PageController()..addListener(_scrollListener);
  }

  bool _loadSuivis = true;
  bool get loadSuivis => _loadSuivis;

  // bool forYou = true;
  // bool _firstget = true;
  int _stateShortPage = 0;
  int get stateShortPage => _stateShortPage;

  setStateShortPage(index) async {
    _stateShortPage = index;

    update();
    print('-----------------------${index}----');
    if (index == 0) {
      print('----------------------hh-');
      if (listSuivisShort.isNotEmpty) {
        listSuivisShort[indexSuivis].controller.pause();
      }
    }
    if (index == 1) {
      print('----------------------hh111---');
      if (listForYouShort.isNotEmpty) {
        listForYouShort[indexForYou].controller.pause();
      }
    }
    var key = await dababase.getKey();
    print(key);
    if (key != null && _stateShortPage == 1) {
      print('-----------------------00sss----');
      await getListSuivisShort();
    }
  }

  // onChangeList() {
  //   if (forYou) {
  //     _listShort = _listForYouShort;
  //     update();
  //   } else {
  //     _listShort = _listSuivisShort;
  //     update();
  //   }
  // }

  // ChewieController? chewieController;
  // List<ShortModel> _listShort = [];

  // List<ShortModel> get listShort => _listShort;
  bool _initialise = false;
  bool get initialise => _initialise;

  int _indexForYou = 0;
  int get indexForYou => _indexForYou;
  init() {
    stateShortPage == 0
        ? listForYouShort[indexForYou].controller.play()
        : stateShortPage == 1
            ? listSuivisShort[indexSuivis].controller.play()
            : listBoutiqueShort[indexShortBoutique].controller.play();
  }

  changeVideoForYou(index) async {
    if (listForYouShort.isNotEmpty) {
     
      _indexForYou = index;
      print(
          '-debut lecture listForYouShort -----------${index}----${listForYouShort[index].src}-----------------------' +
              listForYouShort[index].src);
      _initialise = false;
      setCurrent(index);

      listForYouShort[index].controller.seekTo(Duration.zero);
      listForYouShort[index].controller.play();
      update(); 

      _initialise = true;

      bool getNext = listForYouShort.length < 2
          ? true
          : index + 2 == listForYouShort.length;
      if (getNext) {
        await getListForYouShort();
      }
      await readShort(listForYouShort[index].codeShortInit);

      return 0;
    }
  }

  int _indexSuivis = 0;
  int get indexSuivis => _indexSuivis;

  changeVideoSuivis(index) async {
    if (listSuivisShort.isNotEmpty) {
      _indexSuivis = index;

      print(
          '-debut lecture short -----------${index}----${listSuivisShort[index].src}-----------------------' +
              listSuivisShort[index].src);
      _initialise = false;
      setCurrent(index);
      listSuivisShort[index].controller.seekTo(Duration.zero);
      listSuivisShort[index].controller.play();
      update(); 
      _initialise = true;
 
      bool getNext = listSuivisShort.length < 2
          ? true
          : index + 2 == listSuivisShort.length;
      if (getNext) {
        await getListSuivisShort();
      }
      await readShort(listSuivisShort[index].codeShortInit);

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
    // listSuivisShort[_indexCurrentShort].controller?.dispose();
    // listShort[_indexCurrentShort].controller?.pause();

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
    // listShort[_indexCurrentShort].controller.dispose();
    if (controller != null) {
      // listShort[_indexCurrentShort]
      //     .controller
      //     ?.dispose(); // controller!.dispose();

      update();
    }
  }

  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;
  int _isCurrent = 0;
  int get isCurrent => _isCurrent;

  late PageController _pageController;
  get pageController => _pageController;
  @override
  void _scrollListener() {
    print('-----------uuuuuuuu---');

    if (isCurrent + 3 >= _listForYouShort.length) {
      print('-----------00000000---');

      getListForYouShort();
    }
  }

  bool _loaddata = false;
  bool _intoShortView = false;
  bool get intoShortView => _intoShortView;
  setIntoShortView(val) {
    _intoShortView = val;
    update();
  }

  List<ShortModel> _listForYouShort = [];

  List<ShortModel> get listForYouShort => _listForYouShort;
  List<ShortModel> _listForYouShortSave = [];
  int indexIncrementForYou = 1;

  Future<void> getListForYouShort() async {
    var key = await dababase.getKey();

    if (_loaddata == false) {
      print('-----------get---');
      _isLoadedP = 0;
      _loaddata = true;
      update();
      try {
        Response response =
            await shortRepo.getListForYouShort(indexIncrementForYou, key);

        // _listShort = [];
        // _listShort.clear();
        // update();

        if (response.body != null) {
          if (response.body['data'] != null) {
            if (response.body['data'].length != 0) {
              print('short**************************');

              _listForYouShort.addAll((response.body['data'] as List)
                  .map((e) => ShortModel.fromJson(e))
                  .toList());
              _listForYouShortSave.addAll((response.body['data'] as List)
                  .map((e) => ShortModel.fromJson(e))
                  .toList());
              indexIncrementForYou++;
              // if (_firstget) {
              //   print('***first get******************response**********');

              //   // _listShort = _listForYouShort;
              //   _firstget = false;
              //   update();
              // }
              _checkGetting();
              // print(_listShort.length);
              print(
                  '_listShort=+++}+++++++++++++++++++++++++++}-=======================================================');
              _loaddata = false;
              _isLoadedP = 1;
              update();
              print(_isLoadedP);
              if (indexIncrementForYou - 1 == 1 && intoShortView) {
                print(
                    '----------------------------------- ${_listForYouShort.length}');
                changeVideoForYou(0);
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

  List<ShortModel> _listSuivisShort = [];

  List<ShortModel> get listSuivisShort => _listSuivisShort;
  List<ShortModel> _listSuivisShortSave = [];
  int indexIncrementSuivis = 1;
  bool _loadedFirstSuivisShort = false;
  get loadedFirstSuivisShort => _loadedFirstSuivisShort;
  Future<void> getListSuivisShort() async {
    var key = await dababase.getKey();
    print('getListSuivisShort**************************');

    // if (_loaddata == false) {
    // print('-----------get---');
    // _isLoadedP = 0;
    // _loaddata = true;
    // update();
    try {
      Response response =
          await shortRepo.getListSuivisShort(indexIncrementSuivis, key);

      // _listShort = [];
      // _listShort.clear();
      // update();

      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            print('short**************************');

            _listSuivisShort.addAll((response.body['data'] as List)
                .map((e) => ShortModel.fromJson(e))
                .toList());
            _listSuivisShortSave.addAll((response.body['data'] as List)
                .map((e) => ShortModel.fromJson(e))
                .toList());
            indexIncrementSuivis++;
            _loadedFirstSuivisShort = true;
            // if (_firstget) {
            //   print('***first get******************response**********');

            //   // _listShort = _listSuivisShort;
            //   _firstget = false;
            //   update();
            // }

            print(_listSuivisShort.length);
            print(
                '_listSuivisShort=+++}+++++++++++++++++++++++++++}-=======================================================');
            _loaddata = false;
            _isLoadedP = 1;
            update();
            if (indexIncrementSuivis - 1 == 1 && intoShortView) {
              print(
                  '----------------------------------- ${_listSuivisShort.length}');
              changeVideoSuivis(0);
            }
          }
        }
      }
    } catch (e) {
      _loaddata = false;
      update();
      //print(e);
    }
    // } else {
    //   print('***pppppp bouriqe******************response**********');
    // }
  }

  _checkGetting() {
    _currentReadShortData = stateShortPage == 0
        ? listForYouShort.first
        : stateShortPage == 1
            ? listSuivisShort.first
            : listBoutiqueShort.first;
  }

  cleanListShort() {
    _listForYouShort = [];
    _listForYouShort.clear();
    // controller = null;
    _currentReadShortData = null;
    indexIncrementForYou = 1;
    indexC2 = 1;
    _listForYouShort = _listForYouShortSave;
    update();
  }

  List<ShortModel> _listBoutiqueShort = [];

  List<ShortModel> get listBoutiqueShort => _listBoutiqueShort;
  int indexC2 = 1;
  int _isLoadedForBoutiqueShort = 0;
  int get isLoadedForBoutiqueShort => _isLoadedForBoutiqueShort;

  int _indexShortBoutique = 0;
  int get indexShortBoutique => _indexShortBoutique;
  changeVideoForBoutique(index) async {
    if (listBoutiqueShort.isNotEmpty) {
      //  }else{}
      _indexForYou = index;
      print(
          '-debut lecture short -----------${index}----${listBoutiqueShort[index].src}-----------------------' +
              listBoutiqueShort[index].src);
      _initialise = false;
      setCurrent(index);
      //  await   listBoutiqueShort[index].loadController();
      controller = listBoutiqueShort[index].controller;
      controller.seekTo(Duration.zero);
      update();
      // controller.;
      controller.play();
      _initialise = true;

      // controller!.addListener(() async {
      //   //print('0000');

      //   _progressValue = Get.find<ShortController>()
      //               .controller!
      //               .value
      //               .duration
      //               .inSeconds
      //               .toDouble() ==
      //           0
      //       ? 0
      //       : Get.find<ShortController>()
      //               .controller!
      //               .value
      //               .position
      //               .inSeconds
      //               .toDouble() /
      //           Get.find<ShortController>()
      //               .controller!
      //               .value
      //               .duration
      //               .inSeconds
      //               .toDouble();

      //   update();
      // });
      bool getNext = listForYouShort.length < 2
          ? true
          : index + 2 == listForYouShort.length;
      if (getNext) {
        await getListShortForBoutique(_saveCodeBoutique);
      }
      await readShort(listForYouShort[index].codeShortInit);

      return 0;
    }
  }

  var _saveCodeBoutique = '';
  Future<void> getListShortForBoutique(codeBoutique) async {
    print('***short bouriqe******************response**********');
    _saveCodeBoutique = codeBoutique;
    _isLoadedForBoutiqueShort = 0;

    _listBoutiqueShort = [];
    _listBoutiqueShort.clear();
    update();
    var key = await dababase.getKey();
    try {
      Response response =
          await shortRepo.getListShortForBoutique(codeBoutique, key, indexC2);

      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            _listBoutiqueShort.addAll((response.body['data'] as List)
                .map((e) => ShortModel.fromJson(e))
                .toList());
            indexC2++;
            print('***short bouriqe*********ok*********response**********');

            print(_listBoutiqueShort.length);
            _currentReadShortData = _listBoutiqueShort.first;
          }
          // changeVideo(0);
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

  int _indexCurrentShort = 0;
  int get indexCurrentShort => _indexCurrentShort;
  ShortModel? _currentReadShortData;
  get currentReadShortData => _currentReadShortData;
  setCurrent(index) {
    _indexCurrentShort = index;
    print(listSuivisShort.length);
    _currentReadShortData = _stateShortPage == 0
        ? _listForYouShort[_indexCurrentShort]
        : _stateShortPage == 1
            ? _listSuivisShort[_indexCurrentShort]
            : _listBoutiqueShort[_indexCurrentShort];
    update();
  }

  newLikeShort() async {
    currentReadShortData.nbre_like = currentReadShortData.is_like
        ? (currentReadShortData.nbre_like - 1) < 0
            ? 0
            : (currentReadShortData.nbre_like - 1)
        : currentReadShortData.nbre_like + 1;
    currentReadShortData.is_like = !currentReadShortData.is_like;
    update();
    var key = await dababase.getKey();

    try {
      var data = {'id': currentReadShortData.id, 'keySecret': key};
      print(data);
      Response response = await shortRepo.newLike(data);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['short'] != null) {
            print(response.body['short']);
            var newShort = ShortModel.fromJson(response.body['short']);

            int index = stateShortPage == 0
                ? listForYouShort.indexWhere((short) => short.id == newShort.id)
                : stateShortPage == 1
                    ? listSuivisShort
                        .indexWhere((short) => short.id == newShort.id)
                    : listBoutiqueShort
                        .indexWhere((short) => short.id == newShort.id);

            // int index =   _listShort.indexWhere((short) => short.id == newShort.id);
            if (index >= 0) {
              stateShortPage == 0
                  ? listForYouShort[index]
                  : stateShortPage == 1
                      ? listSuivisShort[index]
                      : listBoutiqueShort[index] = newShort;

              update();
            }
            update();
          }
        }
      } else {
        currentReadShortData.nbre_like = !currentReadShortData.is_like
            ? currentReadShortData.nbre_like - 1
            : currentReadShortData.nbre_like + 1;
        update();
      }
    } catch (e) {
      // fn.closeSnack();
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      currentReadShortData.nbre_like = !currentReadShortData.is_like
          ? currentReadShortData.nbre_like - 1
          : currentReadShortData.nbre_like + 1;
      currentReadShortData.is_like = !currentReadShortData.is_like;
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
            'id': currentReadShortData.id,
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
              // int index = _listShort
              //     .indexWhere((short) => short.id == currentReadShortData.id);

              int index = stateShortPage == 0
                  ? listForYouShort.indexWhere(
                      (short) => short.id == currentReadShortData.id)
                  : stateShortPage == 1
                      ? listSuivisShort.indexWhere(
                          (short) => short.id == currentReadShortData.id)
                      : listBoutiqueShort.indexWhere(
                          (short) => short.id == currentReadShortData.id);
              if (index >= 0) {
                stateShortPage == 0
                    ? listForYouShort[index].nbre_commentaire =
                        _listCommentShort.length
                    : stateShortPage == 1
                        ? listSuivisShort[index].nbre_commentaire =
                            _listCommentShort.length
                        : listBoutiqueShort[index].nbre_commentaire =
                            _listCommentShort.length;

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
            await shortRepo.getListComment(currentReadShortData.id, key);

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
      com.nbre_like_com = com.is_like_com
          ? (com.nbre_like_com - 1 < 0 ? 0 : com.nbre_like_com - 1)
          : com.nbre_like_com + 1;
      com.is_like_com = !com.is_like_com;
      update();
    }

    if (type == 1) {
      com = comselect;
      com.nbre_like_com = com.is_like_com
          ? (com.nbre_like_com - 1 < 0 ? 0 : com.nbre_like_com - 1)
          : com.nbre_like_com + 1;
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

            _currentReadShortData = ShortModel.fromJson(response.body['data']);
            _isUnique = 1;

            currentReadShortData.loadController();
            _isUniqueVideoPlayer = currentReadShortData.controller;

            _isUniqueVideoPlayer.seekTo(Duration.zero);
            update();
            // controller.;
            _isUniqueVideoPlayer.play();
            update();
            print("-----short+++++++---------------$_currentReadShortData.id");
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
      var data = {'id': currentReadShortData.id, 'keySecret': key};
      print(data);
      Response response = await shortRepo.newLikeComment(data);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['short'] != null) {
            print(response.body['short']);
            var newShortComm =
                CommentShortModel.fromJson(response.body['short']);

            // _currentReadShortData = newShortComm;

            update();
          }
        }
      } else {
        currentReadShortData.nbre_like_com = !currentReadShortData.is_like_com
            ? currentReadShortData.nbre_like_com - 1
            : currentReadShortData.nbre_like_com + 1;
        update();
      }
    } catch (e) {
      // fn.closeSnack();
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      currentReadShortData.nbre_like_com = !currentReadShortData.is_like_com
          ? currentReadShortData.nbre_like_com - 1
          : currentReadShortData.nbre_like_com + 1;
      currentReadShortData.is_like_com = !currentReadShortData.is_like_com;
      update();
      //print(e);
    }
  }

  disposeUniquePLayer() {
    // currentReadShortData.controller.dispose();
    if (_isUniqueVideoPlayer != null) {
      _isUniqueVideoPlayer!.dispose();

      update();
    }
  }
}
