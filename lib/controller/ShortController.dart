import 'package:EMIY/components/Widget/UserTagComponent.dart';
import 'package:EMIY/model/data/CommentShortModel.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/model/data/UserTagModel.dart';
import 'package:EMIY/repository/ShortRepo.dart';

import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flexible_text_editing_controller/flexible_text_editing_controller.dart';

class ShortController extends GetxController {
  final ShortRepo shortRepo;
  ShortController({required this.shortRepo});
  final dababase = Get.find<DataBaseController>();
  var fn = new ViewFunctions();

  bool _comment = false;
  bool get comment => _comment;

  setComment() {
    _comment = true;
    update();
  }

  unSetComment() {
    _comment = false;
    update();
  }

  bool _loadSuivis = true;
  bool get loadSuivis => _loadSuivis;
  onReady() {
    setPageForYouController();

    setPageSuivisController();
  }

  int _stateShortPage = 0;
  int get stateShortPage => _stateShortPage;

  Future<void> readShort(codeShort) async {
    var key = await dababase.getKey();

    if (_loaddata == false) {
      print('-------in readddddddd----get---');
      _isLoadedP = 0;

      try {
        Response response = await shortRepo.readShort(codeShort, key);

        print('read**************************');

        print(
            'read=+++}+++${response.body}+++++++++++++++++++++++}-=======================================================');
      } catch (e) {
        print(e);
      }
    }
  }

  /***
   *Start Block For you 
   * 
   * 
   */
  var _controllerForYou;

  get controllerForYou => _controllerForYou;

  setControllerForYou(VideoPlayerController _controller) {
    print('-----------------------${_controller.value.isInitialized}----');
    _controllerForYou = _controller;
    update();
  }

  setStateShortPage(index) async {
    _stateShortPage = index;

    update();
    print('-----------------------${index}----');
    if (index == 0) {
      print('----------------------hh-');
      setPageSuivisController();
      if (listSuivisShort.isNotEmpty) {
        // listSuivisShort[indexSuivis].controller.pause();
      }
    }
    if (index == 1) {
      print('----------------------hh111---');
      setPageForYouController();
      if (listForYouShort.isNotEmpty) {
        // listForYouShort[indexForYou].controller.pause();
      }
    }
    var key = await dababase.getKey();
    print(key);
    if (key != null && _stateShortPage == 1) {
      print('-----------------------00sss----');
      await getListSuivisShort();
    }
  }

  bool _initialise = false;
  bool get initialise => _initialise;

  int _indexForYou = 0;
  int get indexForYou => _indexForYou;

  changeVideoForYou(index) async {
    if (listForYouShort.isNotEmpty) {
      _initialise = false;
      update();
      _indexForYou = index;
      print(
          '-debut lecture listForYouShort -----------${index}----${listForYouShort[index].src}-----------------------' +
              listForYouShort[index].src);
      _initialise = false;
      setCurrent(index);
      // await listForYouShort[index].controller
      //   ..initialize().then((_) {
      //     print('**************lectyre');
      //     _initialise = true;
      //     update();
      //     // controller.play();
      //   }).catchError((e) {
      //     print('*****${e}*********erorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');

      //     // listForYouShort[index].resetPlayer();
      //   });

      //   listForYouShort[index].controller.seekTo(Duration.zero);
      // listForYouShort[index].controller.play();

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

      await shortRepo
          .getListForYouShort(indexIncrementForYou, key)
          .then((response) async {
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
      }).catchError((error) {
        _loaddata = false;
        update();
        print(error);
      });
    }
  }

/***
   * End Block For you 
   * 
   * 
   */

/***
   * Start Block Suivis
   * 
   * 
   */

  var _controllerSuivis;

  get controllerSuivis => _controllerSuivis;
  setControllerSuivis(VideoPlayerController _controller) {
    print('-----------------------${_controller.value.isInitialized}----');
    _controllerSuivis = _controller;
    update();
  }

  int _indexSuivis = 0;
  int get indexSuivis => _indexSuivis;

  changeVideoSuivis(index) async {
    if (listSuivisShort.isNotEmpty) {
      _indexSuivis = index;
      _initialise = false;
      update();
      print(
          '-debut lecture short -----------${index}----${listSuivisShort[index].src}-----------------------' +
              listSuivisShort[index].src);
      _initialise = false;
      setCurrent(index);
      // await findSaveShort(listSuivisShort[index])
      //   ..initialize().then((_) {
      //     print('**************lectyre');
      //     _initialise = true;
      //     update();
      //     // controller.play();
      //   });
      // listSuivisShort[index].controller.seekTo(Duration.zero);
      // listSuivisShort[index].controller.play();
      // saveShort(listSuivisShort[index].id, listSuivisShort[index].controller);
      // update();

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

  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;
  int _isCurrent = 0;
  int get isCurrent => _isCurrent;

  late PageController _pageForYouController;
  get pageForYouController => _pageForYouController;
  setPageForYouController() {
    _pageForYouController = PageController(initialPage: _indexForYou);
    update();
    print('----------${_indexForYou}--------------');
  }

  late PageController _pageSuivisController;
  get pageSuivisController => _pageSuivisController;
  setPageSuivisController() {
    _pageSuivisController = PageController(initialPage: _indexSuivis);
    update();
    print('----------${_indexSuivis}--------------');
  }

  bool _loaddata = false;
  bool _intoShortView = false;
  bool get intoShortView => _intoShortView;
  setIntoShortView(val) {
    _intoShortView = val;
    update();
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

    await shortRepo
        .getListSuivisShort(indexIncrementSuivis, key)
        .then((response) async {
      print('short**************************');

      if (response.body != null) {
        _listSuivisShort.addAll((response.body['data'] as List)
            .map((e) => ShortModel.fromJson(e))
            .toList());
        _listSuivisShortSave.addAll((response.body['data'] as List)
            .map((e) => ShortModel.fromJson(e))
            .toList());
        indexIncrementSuivis++;
        _loadedFirstSuivisShort = true;

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
    }).catchError((error) {
      _loaddata = false;
      update();
      print(error);
    });
  }

  _checkGetting() {
    _currentReadShortData = stateShortPage == 0
        ? listForYouShort.isNotEmpty
            ? listForYouShort.first
            : null
        : stateShortPage == 1
            ? listSuivisShort.first
            : listBoutiqueShort.first;
  }

/**
 *
 *  End Short For Suivis
 */
/**
 *
 *  Start Short For Boutique
 */
  List<ShortModel> _listBoutiqueShort = [];

  List<ShortModel> get listBoutiqueShort => _listBoutiqueShort;
  int indexIncrementShortBoutique = 1;
  int indexShortBoutique = 1;
  int _isLoadedForBoutiqueShort = 0;
  int get isLoadedForBoutiqueShort => _isLoadedForBoutiqueShort;

  var _controllerShortBoutique;

  get controllerShortBoutique => _controllerShortBoutique;

  setControllerShortBoutique(VideoPlayerController _controller) {
    print('-----------------------${_controller.value.isInitialized}----');
    _controllerShortBoutique = _controller;
    update();
  }

  changeVideoForBoutique(index) async {
    if (listBoutiqueShort.isNotEmpty) {
      indexShortBoutique = index;
      print(
          '-debut lecture short -----------${index}----${listBoutiqueShort[index].src}-----------------------' +
              listBoutiqueShort[index].src);
      _initialise = false;
      setCurrent(index);

      bool getNext = _listBoutiqueShort.length < 2
          ? true
          : index + 2 == _listBoutiqueShort.length;
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

    update();
    var key = await dababase.getKey();

    await shortRepo
        .getListShortForBoutique(codeBoutique, key, indexIncrementShortBoutique)
        .then((response) async {
      _listBoutiqueShort.addAll((response.body['data'] as List)
          .map((e) => ShortModel.fromJson(e))
          .toList());
      if (response.body['data'].length != 0) {
        indexIncrementShortBoutique++;
      }
      print('***short bouriqe*********ok*********response**********');

      print(_listBoutiqueShort.length);
      _currentReadShortData = _listBoutiqueShort.first;
      setCurrent(0);
      _isLoadedForBoutiqueShort = 1;
      update();
      changeVideoForBoutique(0);
    }).catchError((error) {
      _loaddata = false;
      update();
      print(error);
    });
  }

/**
 *
 *  End Short For Boutique
 */

/***
 * 
 * Start  Short Unique  
 * 
 */
  var _isUniqueVideoPlayer;
  get isUniqueVideoPlayer => _isUniqueVideoPlayer;
  int _isUnique = 0;
  get isUnique => _isUnique;
  getUniqueShort(idShort, code) async {
    _isUniqueVideoPlayer = null;
    _currentReadShortData = null;
    _isUnique = 0;
    update();
    print('-sss-short----------***************************');

    var key = await dababase.getKey();

    try {
      Response response = await shortRepo.getUniqueShort(idShort, code, key);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['data'] != null) {
            print('--short----------***************************');
            print(response.body['data']);

            // _isUniqueVideoPlayer = ShortModel.fromJson(response.body['data']);
            _currentReadShortData = ShortModel.fromJson(response.body['data']);
            _isUnique = 1;

            update();
            // controller.;
            update();
            print(
                "-----short+++++++---------------${_currentReadShortData!.id}");
          }
        }
      }
    } catch (e) {
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

      update();
      //print(e);
    }
  }

  setControllerUniquePlayer(VideoPlayerController _controller) {
    print('-----------------------${_controller.value.isInitialized}----');
    _isUniqueVideoPlayer = _controller;
    update();
  }
/**
 *
 *  End Short For Unique
 */
/***
 * 
 * Start  Short Action  
 * 
 */

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
  // TextEditingController _textEditingController = TextEditingController();
  // TextEditingController get textEditingController => _textEditingController;

  // styler(String text, TextStyle? defaultStyle) {
  //   List<TextSpan> children = [];
  //   for (int i = 0; i < text.length; i++) {
  //     i % 2 == 0
  //         ? children.add(TextSpan(
  //             text: text.substring(i, i + 1),

  //             ///red for even,
  //             style: const TextStyle(color: Colors.red)))
  //         : children.add(TextSpan(
  //             text: text.substring(i, i + 1),

  //             ///blue for odd
  //             style: const TextStyle(color: Colors.blue)));
  //   }
  //   return TextSpan(style: defaultStyle, children: children);
  // }

  TextSpan styler(String text, TextStyle? defaultStyle) {
    List<TextSpan> children = [];

    // Use a regular expression to find the pattern "@xxxxxxxxxxx"
    RegExp regex = RegExp(r'@(\w+)');
    Iterable<RegExpMatch> matches = regex.allMatches(text);

    int currentPos = 0;

    // Iterate through matches and add TextSpans accordingly
    for (RegExpMatch match in matches) {
      // Add regular text before the match
      children.add(TextSpan(
        text: text.substring(currentPos, match.start),
        style: defaultStyle,
      ));

      // Add the match with the specified style
      children.add(TextSpan(
        text: match.group(0),
        style: TextStyle(color: ColorsApp.red, fontWeight: FontWeight.w500),

        // Change the color as needed
      ));

      // Update the current position
      currentPos = match.end;
    }

    // Add the remaining text
    children.add(TextSpan(
      text: text.substring(currentPos),
      style: defaultStyle,
    ));

    return TextSpan(children: children);
  }

  late FlexibleTextEditingController _textEditingController;
  FlexibleTextEditingController get textEditingController =>
      _textEditingController;

  int _isLoadingUsertag = 1;
  int get isLoadingUsertag => _isLoadingUsertag;
  List<UserTagModel> _usertagList = [];
  List<UserTagModel> get usertagList => _usertagList;

  bool _openTagList = false;
  bool get openTagList => _openTagList;
  // void onInit() async {
  //   _textEditingController =
  //       FlexibleTextEditingController(styler: (text, defaultStyle) {
  //     return styler(text, defaultStyle);
  //   });
  //   print('init text------------------------------');
  //   _textEditingController.addListener(() {
  //     String text = _textEditingController.text;
  //     print(
  //         'search texte ${text}----------${text.contains('@')}--------------------');
  //     // Vérifier si le caractère "@" a été supprimé
  //     if (text.contains('@') && text.length > 1) {
  //       _openTagList = true;
  //       update();
  //       print('Contains texte ${text}------------------------------');

  //       findUserByTag(text);
  //       // openModalUserTag();
  //       // Le caractère "@" est toujours présent
  //     } else {
  //       _openTagList = false;
  //       update();
  //     }
  //   });
  //   super.onInit();
  //   // _textEditingController.
  // }
  void onInit() async {
    _textEditingController =
        FlexibleTextEditingController(styler: (text, defaultStyle) {
      return styler(text, defaultStyle);
    });

    int lastCursorPosition = 0;

    print('init text------------------------------');

    _textEditingController.addListener(() {
      String text = _textEditingController.text;

      final TextSelection cursorPosition = _textEditingController.selection;

      // Vérifier si la position du curseur a changé
      if (cursorPosition.start != lastCursorPosition) {
        lastCursorPosition = cursorPosition.start;

        // Vérifier si la position du curseur est valide
        if (cursorPosition.start > -1 && cursorPosition.start > 0) {
          // Trouver la position du dernier @ avant le curseur
          int previousAtPosition =
              text.lastIndexOf('@', cursorPosition.start - 1);

          // Récupérer le texte entre le dernier @ et la position actuelle du curseur
          String tagText =
              text.substring(previousAtPosition + 1, cursorPosition.start);

          // Arrêter la récupération si un espace est rencontré
          int spacePosition = tagText.indexOf(' ');
          if (spacePosition != -1) {
            tagText = tagText.substring(0, spacePosition);
          }

          // Vérifier si le texte extrait après le dernier "@" et avant la position actuelle du curseur n'est pas une chaîne vide ou ne contient que des espaces
          if (tagText.trim().isNotEmpty) {
            if (text.contains('@') &&
                    text.length > 1 &&
                    previousAtPosition > -1 &&
                    !isSelect /* &&
                _textEditingController.text[cursorPosition.start - 1] == '@' */
                ) {
              _openTagList = true;
              update();
              print(
                  'Contains texte $text - cursor position: ${cursorPosition.start}-${cursorPosition.end}');

              print('Tag text: $tagText');
              findUserByTag(tagText);
            }
          }

          // Vérifier si le caractère "@" a été supprimé
          else if (!text.contains('@') && cursorPosition.start > 0) {
            _openTagList = false;
            isSelect = false;
            _usertagList.clear();
            update();

            print(
                'Does not contain @ - cursor position: ${cursorPosition.start}-${cursorPosition.end}');
          } else {
            print(
                ' No open @ - cursor position: ${cursorPosition.start}-${cursorPosition.end}');
            // _usertagList.clear();
            findUserByTag('');
            isSelect = false;
            _openTagList = true;
            update();
          }
        } else {
          _usertagList.clear();
          print(
              '000000 No open @ - cursor position: ${cursorPosition.start}-${cursorPosition.end}');
          isSelect = false;
          _openTagList = true;
          update();
        }
      }
    });

    super.onInit();
  }

  var _userTagSelect = '';
  get userTagSelect => _userTagSelect;

  bool isSelect = false;
  selectUserTag(String newText) {
    final TextSelection cursor = _textEditingController.selection;
    String currentText = _textEditingController.text;

    // Trouver la position du "@" précédent
    int previousAtSymbolIndex = currentText.lastIndexOf('@', cursor.start - 1);

    // Si aucun "@" précédent n'est trouvé, la position est 0
    if (previousAtSymbolIndex == -1) {
      previousAtSymbolIndex = 0;
    }

    // Extraire la partie du texte à conserver avant le "@" précédent
    String textToPreserveBefore =
        currentText.substring(0, previousAtSymbolIndex);

    // Trouver la position du "@" suivant (à partir de la position actuelle du curseur)
    int nextAtSymbolIndex = currentText.indexOf('@', cursor.start);

    // Si aucun "@" suivant n'est trouvé, la position est la fin du texte
    if (nextAtSymbolIndex == -1) {
      nextAtSymbolIndex = currentText.length;
    }

    // Extraire la partie du texte à conserver après le "@" suivant
    String textToPreserveAfter = currentText.substring(nextAtSymbolIndex);

    print('---------*-*-**-*-***-*' + textToPreserveAfter);
    // Construire le nouveau texte en remplaçant le contenu entre les "@" par "@ + texte"
    String newTextWithReplacement =
        textToPreserveBefore + ' @$newText ' + textToPreserveAfter;
    _userTagSelect = newText;
    // Mettre à jour le texte dans le TextEditingController
    _textEditingController.text = newTextWithReplacement;

    // Mettre à jour la sélection du curseur après le nouvel ajout
    _textEditingController.selection = TextSelection.collapsed(
        offset: previousAtSymbolIndex + newText.length + 2);
    _openTagList = false;
    isSelect = true;
    update();
  }

  findUserByTag(text) async {
    print('${_isLoadingUsertag}....${text}.....');
    if (_isLoadingUsertag != 0) {
      _isLoadingUsertag = 0;
      print('find}.........');

      await shortRepo.findUserBuyTag(text).then((response) async {
        _usertagList.clear();
        update();

        if (response.body['data'].length != 0) {
          _usertagList.addAll((response.body['data'] as List)
              .map((e) => UserTagModel.fromJson(e))
              .toList());
          print(_usertagList.length);
          _isLoadingUsertag = 1;
          update();
        } else {
          _isLoadingUsertag = 1;
          update();
        }
      }).catchError((error) {
        _isLoadingUsertag = 2;
        update();
        print(error);
      });
    }
  }

  FocusNode _focusNodeComment = FocusNode();
  FocusNode get focusNodeComment => _focusNodeComment;
  var _refCom;
  get refCom => _refCom;
  setIdRef(ref) {
    _refCom = ref;

    _focusNodeComment.requestFocus();
    print(_focusNodeComment.size);
    update();
  }

  newCommentShort() async {
    if (textEditingController.text.length == 0) {
      _sendComment = false;
      _openTagList = false;
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

    textEditingController.text = '';
    _openTagList = false;
    update();
    print(data);
    await shortRepo.newComment(data).then((response) async {
      _sendComment = false;
      update();

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
                ? listForYouShort
                    .indexWhere((short) => short.id == currentReadShortData.id)
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
          _sendComment = false;
          update();
        }
      } else {
        textEditingController.text = data['comment'];
        _sendComment = false;
        update();
      }
    }).catchError((error) {
      textEditingController.text = data['comment'];
      // fn.closeSnack();
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      _sendComment = false;
      update();
      //print(e);
    });
  }

  List<CommentShortModel> _listCommentShort = [];
  List<CommentShortModel> get listCommentShort => _listCommentShort;

  int _loadComment = 0;
  int get loadComment => _loadComment;
  bool loadingC = false;
  getListCommentShort() async {
    if (!loadingC) {
      _userTagSelect = '';
      _usertagList.clear();
      _textEditingController.clear();
      _openTagList = false;
      _listCommentShort = [];
      _loadComment = 0;
      _idCurrentComment = 0;
      _isLoadingUsertag = 1;
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

/***
 * 
 * End  Short Action  
 * 
 */
  disposePLayerAll() {
    // currentReadShortData.controller.dispose();
    if (_controllerShortBoutique != null) {
      _controllerShortBoutique.dispose();
      _controllerShortBoutique = null;
      update();
    }
    if (_isUniqueVideoPlayer != null) {
      _isUniqueVideoPlayer.dispose();
      print('---');
      _isUniqueVideoPlayer = null;
      update();
    }
    if (_controllerForYou != null) {
      _controllerForYou.dispose();
      _controllerForYou = null;

      update();
    }
    if (_controllerSuivis != null) {
      _controllerSuivis.dispose();
      _controllerSuivis = null;

      update();
    }
  }

  pausePlay() {
    if (_controllerForYou != null) {
      _controllerForYou.pause();

      update();
    }
    if (_controllerSuivis != null) {
      _controllerSuivis.pause();

      update();
    }
  }

  cleanListShort() {
    // _listForYouShort = [];
    // _listForYouShort.clear();
    // controller = null;
    // _currentReadShortData = null;
    // indexIncrementForYou = 1;
    // indexShortBoutique = 1;
    // _listForYouShort = _listForYouShortSave;
    update();
  }
}
