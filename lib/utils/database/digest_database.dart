/* 
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


Future<void> digestInsert(digests) async {
  var databasePath = await getApplicationDocumentsDirectory();
  String path = join(databasePath.path, 'digest_database.db');
  Database database =
      await openDatabase(path, version: 1, onCreate: (db, version) async {
    await db.execute(
        'CREATE TABLE digests_download (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, description TEXT, dateCreate TEXT, statut TEXT, image TEXT, src TEXT )');
  });
  await database.insert('digests_download', {
    "name": digests.name,
    "description": digests.description,
    "dateCreate": digests.dateCreate.toString(),
    "statut": digests.statut,
    "image": digests.image.toString(),
    "src": digests.src.toString(),
  });

  List<Map<String, dynamic>> download_digests =
      await database.rawQuery('SELECT * FROM digests_download');
  for (var i = 0; i < download_digests.length; i++) {
    print(download_digests[i]["name"]);
  }
  print("---------------------------");
  print(download_digests.length);

  await database.close();
}
 */

/**
 * import 'dart:convert';
import 'dart:io';
import 'package:Digester/model/data/bibiotehque_model.dart';
import 'package:Digester/model/data/category_model.dart';
import 'package:Digester/model/data/digestSellerModel.dart';
import 'package:Digester/utils/api/apiUrl.dart';
import 'package:Digester/utils/functions/formatData.dart';
import 'package:Digester/utils/functions/route.dart';

import 'package:Digester/utils/theme/styleComponent.dart';
import 'package:Digester/utils/theme/theme_provider.dart';
import 'package:Digester/model/data/FavoriteDigest_model.dart';
import 'package:Digester/utils/changeNotifier/ui.dart';
import 'package:Digester/model/provider/auth_provider.dart';
import 'package:Digester/model/provider/refresh_token.dart';
import 'package:Digester/Views/backgroundService.dart';

import 'package:Digester/components/webViewScreen.dart';
import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toast/toast.dart';
import 'package:path_provider/path_provider.dart' as pathPro;

AuthProvider api = AuthProvider();
String baseUrl = ApiUrl.baseUrl;

_backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

@immutable
class DigestePage extends StatefulWidget {
  // final DigestModel digest;
  int idDigesteur;
  bool inRead;
  /*  DigestePage({this.digest, this.idDigesteur, this.inRead}); */
  List category;
  int index;
  DigestePage({this.category, this.index, this.idDigesteur, this.inRead});
  @override
  _DigestePageState createState() => _DigestePageState();
}

class _DigestePageState extends State<DigestePage> {
  bool disponible = false;
  double timeProgress = 0;
  double audioDuration = 0;
  bool rat = false;
  List<DigestSellerModel> listseller;
  List<DigestModel> listDigest = [];
  GetStorage digeste = GetStorage();
  GetStorage categorysave = GetStorage();
  
  GetStorage listDigests = GetStorage();
  var digest;

  GetStorage indexe = GetStorage();
  var index;
  var category;
  DigestModel finalDigest;
  int indexFinal;
  List categoryFinal;

  Future getCategDigest(List category) async {
    var dio = await CustomDio().getApiClient();
    var data = box.read(userKey);
    print("debut get categories");
    print(category[1]);
    Response response = await dio.get(
      "/api/category_digest_peut_avoirs?name=${category[1]}",
    );
    if (response.statusCode == 200) {
      //   print("voici les categories de digeste ${response.data}");
      //   print("fin get categories");

      return CategoriesDigestModel.fromJson(response.data[0]);
    } else {
      throw Exception("Exception occured: ");
    }
  }

  Future returnDigesteWithCategory(category) async {
    CategoriesDigestModel categories;
    await getCategDigest(category).then((value) => {
          setState(() {
            categories = value;
          })
        });
    print("Get by categoeierd");
    for (var y = 0; y < categories.listDigestCategories.length; y++) {
      //     print(categories.listDigestCategories.length);
      setState(() {
        if (categories.listDigestCategories[y].digest.status == true) {
          listDigest.add(categories.listDigestCategories[y].digest);
          print(categories.listDigestCategories[y].digest.name);
        }
      });
    }
  }

  Future getAllDigeste() async {
    var dio = await CustomDio().getApiClient();
    List<DigestModel> allD = [];
    try {
      // print("debut get  digest");
      Response response = await dio.get("/api/digests");
      if (response.statusCode == 200) {
        var digestList = (response.data as List)
            .map((e) => DigestModel.fromJson(e))
            .toList();
        if (response.statusCode == 200) {
          for (var digest in digestList) {
            if (digest.status == true) {
              print(digest.status);
              allD.add(digest);
            }
          }
        }
        for (var a in allD) {
          print(a.name);
        }
        return allD;
      }
    } catch (error, stacktrace) {
      print("voici error: $error");
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  /* 
@override
// ignore: must_call_super
void dispose()   {
    //(!mounted) ? AudioService.stop() : 0;
    print("bbbbbbbbbbbbbbbbbbbbbbb");
    AudioService.stop();
    AudioService.disconnect();
    /* Future(() async {
      print("aaaaaaaaaaaaaaa");
      await AudioService.stop();
      await AudioService.disconnect();
    }); */
    super.dispose();
  } */
  Future returnAllDigeste() async {
    await getAllDigeste().then((value) {
      setState(() {
        listDigest = value;
      });
    });
  }

  Future getFavoriteDigest() async {
    var dio = await CustomDio().getApiClient();
    List<DigestModel> allD = [];
    try {
      final response = await dio.get(
        "/api/favory_digests?digesteur=${widget.idDigesteur}",
      );
      var listfavoris = (response.data as List)
          .map((e) => FavoriteDigestModel.fromJson(e))
          .toList();
      if (response.statusCode == 200) {
        for (var digest in listfavoris) {
          if (digest.digest.status == true) {
            allD.add(digest.digest);
          }
        }

        return allD;
      }
    } catch (error, stacktrace) {
      print("Erreur favorit digestss: $error");

      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future returnFavoriteDigeste() async {
    await getFavoriteDigest().then((value) {
      setState(() {
        listDigest = value;
      });
    });
  }

  Future getDigestLue() async {
    var dio = await CustomDio().getApiClient();
    List<DigestModel> allD = [];
    try {
      final digestlu = await dio.get(
        "/api/bibiotheques?digesteur=${widget.idDigesteur}",
      );

      final lu = (digestlu.data as List)
          .map((e) => BibiothequeModels.fromJson(e))
          .toList();
      // print("Voici lu $lu");
      if (digestlu.statusCode == 200) {
        for (var biblio in lu) {
          if (biblio.digest.status == true) {
            allD.add(biblio.digest);
          }

          return allD;
        }
      }
    } catch (error, stacktrace) {
      print("voici error de list category_digest_peut_avoirs: $error");

      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future returnLueDigeste() async {
    await getDigestLue().then((value) {
      setState(() {
        listDigest = value;
      });
    });
  }

  digestByProvenace(List category) async {
    listDigest.clear();
    print(category[0].toString().toUpperCase());
    switch (category[0].toString().toUpperCase()) {
      case "HOME":
        return returnDigesteWithCategory(category);
      case "SEARCH":
        return returnAllDigeste();
      case "DBC":
        return returnDigesteWithCategory(category);
      case "BIBLIOTHEQUE":
        var categorysecond = category[0].toString().toUpperCase();
        if (categorysecond == "ALL") {
          return returnAllDigeste();
        } else if (categorysecond == "LUE") {
          return returnLueDigeste;
        } else if (categorysecond == "FAVORIE") {
          return returnFavoriteDigeste;
        }
        break;
      default:
    }
/* 
    if (widget.category[0].toString().toUpperCase() == "HOME") {
      print(widget.category);
      return returnAllDigeste();
    } else if (widget.category[0].toString().toUpperCase() == "SEARCH") {
      print(widget.category);
      return getAllDigeste();
    } else if (widget.category[0].toString().toUpperCase() == "DBC") {
      print(widget.category);
      return returnDigesteWithCategory();
    } else if (widget.category[0].toString().toUpperCase() == "BIBLIOTHEQUE") {
      print(widget.category);
      return;
    } */
  }

  @override
  void initState() {
    GetStorage.init();
    print("------------------------a");
    if (widget.index != null && widget.category != null) {
      indexe.remove("index");
      categorysave.remove("category");
      categorysave.write("category", category);
      indexe.write("index", index);
      setState(() {
        categorysave.write("category", category);
        listDigests.write("lisDigest", category);
        indexe.write("index", index);
        indexFinal = widget.index;
        categoryFinal = widget.category;
      });
    } else {
      setState(() {
        indexFinal = indexe.read("index");
        categoryFinal = categorysave.read("category");
      });
    }

    inComme(indexFinal, categoryFinal, widget.inRead);

    requestPermission();

    loading = false;
    print("asdfghj   final digest ");

    super.initState();
  }

  inComme(int index, List category, bool read) async {
    await GetStorage.init();
    print("voici index $index");
    print("voici category $category");

    await digestByProvenace(category);
    setState(() {
      //   digeste.remove("digest");
      categorysave.remove("category");
      indexe.remove("index");

      categorysave.write("category", category);
      indexe.write("index", index);
    });
    if (read) {
      print("EN lecture ");
      /* print(index);
      print(listDigest[index].name); */
      setState(() {
        finalDigest = digeste.read("digest");
        disponible = true;
      });
      if (listDigest[index].id == finalDigest.id) {
        print("Digest Identique");
        setState(() {
          finalDigest = digeste.read("digest");
          disponible = true;
        });
      } else {
        print("Digest differents jsuquaaaaaaaaaaaaaaa");
        digeste.remove("digest");
        digeste.write("digest", listDigest[index]);
        setState(() {
          finalDigest = digeste.read("digest");
          disponible = true;
        });
        /*  start(finalDigest.src.contentUrl, finalDigest.name, finalDigest.author,
            finalDigest.image.contentUrl);   */
        start(listDigest, index);
      }
      //  print("Voici l\'id boroooooooo ${finalDigest.id}");
    } else {
      print("Nouvelle lecture");
      digeste.remove("digest");
      digeste.write("digest", listDigest[index]);
      setState(() {
        finalDigest = digeste.read("digest");
        disponible = true;
      });
     /*  start(finalDigest.src.contentUrl, finalDigest.name, finalDigest.author,
          finalDigest.image.contentUrl); */
           start(listDigest, index);
    }

    if (finalDigest != null) {
      getRating(finalDigest.id).then((value) => {
            if (mounted)
              {
                setState(() {
                  rating = value;
                })
              }
          });
      getDigestSellerModel(finalDigest.id).then((value) => {
            //  print(value),
            setState(() {
              listseller = value;
            })
          });
    }
  }

  void requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  start(
      /* url, title, author, img */
      List<DigestModel> listDigest,
      int index) async {
    startReadDigest();
    AudioService.stop();
    try {
      return await AudioService.start(
          backgroundTaskEntrypoint: _backgroundTaskEntrypoint,
          androidResumeOnClick: true,
          androidShowNotificationBadge: true,
          androidNotificationChannelName: listDigest[index].name,
          androidNotificationOngoing: true,
          androidNotificationColor: 0xff1A90FF,
          androidNotificationIcon: "mipmap/launcher_icon",
          androidEnableQueue: true,
          androidNotificationClickStartsActivity: true,
          androidStopForegroundOnPause: true,
          params: {
            "listdigest": listDigest,
            "index": index

            /* 
            "url": baseUrl + url,
            "title": title,
            "auteur": author,
            "img": img, */
            //    "duration": finalDigest.duration
          });
    } catch (e) {
      print("** Error on start : $e");
    }
  }

  Future<List<DigestSellerModel>> getDigestSellerModel(int id) async {
    var dio = await CustomDio().getApiClient();
    try {
      final response = await dio.get(
        "/api/list_book_sellers?livrepanier.digest=$id",
      );

      var seller = (response.data as List)
          .map((e) => DigestSellerModel.fromJson(e))
          .toList();

      return seller;
    } catch (error, stacktrace) {
      ///  print("voici error de list category_digest_peut_avoirs: $error");

      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  startReadDigest() async {
    var dio = await CustomDio().getApiClient();

    Response dejaLue = await dio.get(
        "/api/bibiotheques?digest=${finalDigest.id}&digesteur=${widget.idDigesteur}");
    var result =
        (dejaLue.data as List).map((e) => FavoriteDigestModel.fromJson(e));
    //  print(result);
    if (result.isEmpty) {
      try {
        var data = {
          "duration": finalDigest.duration,
          "digest": "/api/digests/${finalDigest.id}",
          "digesteur": "/api/digesteurs/${widget.idDigesteur}"
        };
        //  print(data);
        Response response = await dio.post("/api/bibiotheques", data: data);

        //   print("Digests ajoute avec succes : ${response.statusCode}");
      } catch (error, stacktrace) {
        print("voici error: $error");

        throw Exception("Exception occured: $error stackTrace: $stacktrace");
      }
    } else {
      //_showDejaFavorite(context);
    }
  }

  void _toggleFavorite() async {
    var dio = await CustomDio().getApiClient();
    Response dejaFavorit = await dio.get(
        "/api/favory_digests?digest=${finalDigest.duration}&digesteur=${widget.idDigesteur}");
    var result =
        (dejaFavorit.data as List).map((e) => FavoriteDigestModel.fromJson(e));
    // print(result);
    if (result.isEmpty) {
      var data = {
        "digest": "/api/digests/${finalDigest.duration}",
        "digesteur": "/api/digesteurs/${widget.idDigesteur}"
      };
      // print(finalDigest.id);
      // print(widget.idDigesteur);
      await dio
          .post(
            "/api/favory_digests",
            data: jsonEncode(data),
          )
          .then((value) => {
                print(value),
                setState(() {
                  isPostLiked = !isPostLiked;
                  _showToastFavorite(context);
                })
              })
          .onError(
            (error, stackTrace) => {
              setState(() => {error = error}),
              print(error)
            },
          );
    } else {
      setState(() {
        _showDejaFavorite(context);
      });
    }
  }

  List _downloadDigest;
  bool _isDownloading = false;

  String progressDowloading;

  String _fileFullPath;
  GetStorage box = GetStorage();

  bool loading = true;
  double rating;

  getRating(int idDigest) async {
    var dio = await CustomDio().getApiClient();
    try {
      Response response = await dio.get("/api/note_digests?digest=$idDigest");

      if (response.statusCode == 200) {
        var rep = (response.data as List).toList();
        // print(rep);
        if (rep.isNotEmpty) {
          rat = true;
          return double.parse(response.data[0]['note'].toString());
        } else {
          return double.parse("0");
        }
      }
      if (response.statusCode != 200) {
        return 0;
      }
    } catch (error, stacktrace) {
      print("voici error: $error");

      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  void _showToast(BuildContext context) {
    Toast.show(
      "Télechargement reussi ",
      context,
      backgroundColor: ColorsApp.skyBlue,
      duration: 5,
      gravity: Toast.BOTTOM,
    );
  }

  void _showToastFavorite(BuildContext contexte) {
    Toast.show(
      "Digest Ajouté aux favoris",
      context,
      backgroundColor: ColorsApp.skyBlue,
      duration: 5,
      gravity: Toast.BOTTOM,
    );
  }

  void _showDejaFavorite(BuildContext contexte) {
    Toast.show(
      "Digest Deja Ajouté aux favoris",
      context,
      backgroundColor: ColorsApp.skyBlue,
      duration: 5,
      gravity: Toast.BOTTOM,
    );
  }

  void _showToastRating(BuildContext contexte, note) {
    Toast.show(
      "Bravo! vous avez donné une noté de $note à ce digest ",
      context,
      backgroundColor: ColorsApp.skyBlue,
      duration: 5,
      gravity: Toast.BOTTOM,
    );
  }

  void _note_digest(note, id) async {
    final item = "/api/digests/$id";
    print(item);
    var dio = await CustomDio().getApiClient();
    var data = {
      "note": note,
      "digest": item,
      "digesteur": "/api/digesteurs/${widget.idDigesteur}"
    };
    try {
      var rep = await dio.post(
        '/api/note_digests',
        data: jsonEncode(data),
      );

      _showToastRating(context, note);
    } catch (e) {
      print("err46456454uerSDFTYCFU456AS4DVFGDH4ASD56FSGD4565SDFG4H");
    }
  }

  var duree = 0.0;
  PanelController panelController = new PanelController();

  bool isPostLiked = false;
  bool open = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userInfo = box.read(userKey);
    print(userInfo);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: ColorsApp.skyBlue,
          elevation: 0.0,
          title: Text(
            "Detail",
            style: TextStyle(
              fontFamily: 'orkney',
              // color: Colors.white,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: ColorsApp.skyBlue,

        // extendBodyBehindAppBar: true,
        body: (disponible)
            ? SlidingUpPanel(
                parallaxEnabled: true,
                // backdropEnabled: true,
                parallaxOffset: 1,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      (finalDigest != null)
                          ? Container(
                              decoration: BoxDecoration(
                                color: ColorsApp.skyBlue,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.26,
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    margin:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(baseUrl +
                                            (finalDigest.image.contentUrl)
                                                .toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: StreamBuilder<MediaItem>(
                                              stream: AudioService
                                                  .currentMediaItemStream,
                                              builder: (_, snapshot) {
                                                return Text((finalDigest.name),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18));
                                              })),
                                      Text(
                                        (finalDigest.author).toUpperCase(),
                                        style: TextStyle(
                                            fontFamily: 'orkney', fontSize: 12
                                            // fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: (rating == null)
                                                  ? Transform.scale(
                                                      scale: 0.5,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            ColorsApp.skyBlue,
                                                      ))
                                                  : RatingBar(
                                                      initialRating: rating,
                                                      filledIcon: Icons.star,
                                                      emptyIcon:
                                                          Icons.star_border,
                                                      halfFilledIcon:
                                                          Icons.star_half,
                                                      isHalfAllowed: true,
                                                      filledColor:
                                                          Colors.yellow,
                                                      emptyColor: Colors.yellow,
                                                      halfFilledColor:
                                                          Colors.yellow,
                                                      size: 20,
                                                      onRatingChanged:
                                                          (double rating) {},
                                                    )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              child: Column(children: [
                                                IconButton(
                                                  tooltip: "Acheter le livre",
                                                  icon: Icon(
                                                    FontAwesomeIcons
                                                        .shoppingCart,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    showModalBottomSheet<void>(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30),
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return (listseller !=
                                                                null)
                                                            ? (listseller
                                                                    .isEmpty)
                                                                ? Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.4,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Aucun Seller a afficher")))
                                                                : Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.4,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            "Acheter sur ..."),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Expanded(
                                                                            child: SizedBox(
                                                                                child: ListView.builder(
                                                                                    physics: ScrollPhysics(),
                                                                                    itemCount: listseller.length,
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    itemBuilder: (context, index) {
                                                                                      return GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                    builder: (context) => WebViewScreen(
                                                                                                          url: listseller[index].link,
                                                                                                          title: "Buy in ${listseller[index].name}",
                                                                                                        )));
                                                                                          },
                                                                                          child: Container(
                                                                                              width: MediaQuery.of(context).size.width / 1.7,
                                                                                              margin: EdgeInsets.only(
                                                                                                top: 10,
                                                                                                bottom: 10,
                                                                                                right: 20,
                                                                                              ),
                                                                                              decoration: BoxDecoration(boxShadow: [
                                                                                                BoxShadow(
                                                                                                  color: Colors.grey[100],
                                                                                                  blurRadius: 5.0,
                                                                                                  spreadRadius: 8.0,
                                                                                                  offset: Offset(0.0, 1.0),
                                                                                                )
                                                                                              ], color: Colors.white, border: Border.all(color: Colors.transparent), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                                                                                              child: Column(children: [
                                                                                                CachedNetworkImage(
                                                                                                  imageUrl: "${ApiUrl.baseUrl + listseller[index].logo.contentUrl}" ?? "",
                                                                                                  imageBuilder: (context, imageProvider) {
                                                                                                    return Container(
                                                                                                      height: 200,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.white,
                                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                  placeholder: (context, url) {
                                                                                                    return Container(
                                                                                                        height: 200,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: Colors.white,
                                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                                        ),
                                                                                                        child: Center(child:    CircularProgressIndicator(
                                                        backgroundColor:
                                                            ColorsApp.skyBlue,
                                                      ),));
                                                                                                  },
                                                                                                  errorWidget: (context, url, error) {
                                                                                                    return Icon(Icons.error);
                                                                                                  },
                                                                                                ),
                                                                                                Container(
                                                                                                    child: Expanded(
                                                                                                        child: Column(children: [
                                                                                                  Container(
                                                                                                      width: MediaQuery.of(context).size.width * 0.9,
                                                                                                      padding: EdgeInsets.only(top: 10, bottom: 5, left: 7),
                                                                                                      child: Text(
                                                                                                        listseller[index].name,
                                                                                                        style: TextStyle(fontFamily: 'orkney', fontWeight: FontWeight.bold),
                                                                                                      )),
                                                                                                ])))
                                                                                              ])));
                                                                                    })))
                                                                      ],
                                                                    ),
                                                                  )
                                                            : Container(
                                                                child: Center(
                                                                widthFactor: 10,
                                                                heightFactor:
                                                                    10,
                                                                child:
                                                                    CircularProgressIndicator(
                                                        backgroundColor:
                                                            ColorsApp.skyBlue,
                                                      ),
                                                              ));
                                                      },
                                                    );
                                                  },
                                                ),
                                                Text("Acheter le livre",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: (themeProvider
                                                                  .themeMode ==
                                                              ThemeMode.dark)
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ))
                                              ]))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ))
                          : Container(
                              /*  padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2), */
                              child:    CircularProgressIndicator(
                                                        backgroundColor:
                                                            ColorsApp.skyBlue,
                                                      ),),
                      Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: (themeProvider.themeMode == ThemeMode.dark)
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                (finalDigest != null)
                                    ? getTimeString(finalDigest.duration)
                                    : getTimeString(0),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'orkney',
                                  color: ColorsApp.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                                child: StreamBuilder<Duration>(
                                    stream: AudioService.positionStream,
                                    builder: (_, snapshot) {
                                      final mediaState = snapshot.data;

                                      return (snapshot.hasData)
                                          ? (mediaState.inSeconds.toDouble() <
                                                  (finalDigest.duration)
                                                      .toDouble())
                                              ? Text(
                                                  getTimeString(mediaState
                                                      ?.inSeconds
                                                      ?.toDouble()),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'orkney',
                                                      fontSize: 13,
                                                      color: ColorsApp.blue))
                                              : Text(getTimeString(0),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'orkney',
                                                      fontSize: 13,
                                                      color: ColorsApp.blue))
                                          : Text(getTimeString(0),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'orkney',
                                                  fontSize: 13,
                                                  color: ColorsApp.blue));
                                    })),
                            Container(
                                child: StreamBuilder<Duration>(
                                    stream: AudioService.positionStream,
                                    builder: (_, snapshot) {
                                      final mediaState = snapshot.data;

                                      if (mediaState != null) {
                                        if (mediaState.inSeconds.toDouble() >=
                                            finalDigest.duration) {
                                          if (indexFinal < listDigest.length &&
                                              indexFinal > 0) {
                                            setState(() {
                                              indexFinal = indexFinal + 1;
                                              inComme(indexFinal, categoryFinal,
                                                  false);
                                            });
                                          } else {
                                            setState(() {
                                              indexFinal = 0;

                                              inComme(indexFinal, categoryFinal,
                                                  false);
                                            });

                                            //  await inComme(indexFinal, categoryFinal, false);
                                          }

                                          print(indexFinal);
                                        } else {}
                                      } else {}
                                      return (mediaState != null)
                                          ? Slider(
                                              activeColor: ColorsApp.skyBlue,
                                              inactiveColor: ColorsApp.blue,
                                              value: (snapshot.hasData)
                                                  ? (mediaState.inSeconds
                                                              .toDouble() <
                                                          (finalDigest.duration)
                                                              .toDouble())
                                                      ? mediaState?.inSeconds
                                                          ?.toDouble()
                                                      : 0
                                                  : 0,
                                              min: 0,
                                              max: (finalDigest.duration)
                                                  .toDouble(),
                                              onChanged: (val) async {
                                                /*    (val <
                                                        (finalDigest.duration)
                                                            .toDouble())
                                                    ? */
                                                AudioService.seekTo(Duration(
                                                    seconds: val.toInt()));
                                              })

                                          /* 
     
                                          ) */

                                          : Center(
                                              child: SpinKitWave(
                                              color: ColorsApp.blue,
                                              size: 6,
                                            ));
                                    })),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print((finalDigest.id).toDouble());
                                        setState(() {
                                          _toggleFavorite();
                                        });
                                      },
                                      child: Icon(
                                        isPostLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isPostLiked
                                            ? ColorsApp.blue
                                            : Colors.grey,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                      "J'aime",
                                      style: TextStyle(
                                        fontFamily: 'orkney',
                                        color: ColorsApp.skyBlue,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Notez le Digest",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'orkney')),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  RatingBar(
                                                    filledIcon: Icons.star,
                                                    emptyIcon:
                                                        Icons.star_border,
                                                    halfFilledIcon:
                                                        Icons.star_half,
                                                    isHalfAllowed: true,
                                                    filledColor: Colors.yellow,
                                                    emptyColor: Colors.yellow,
                                                    halfFilledColor:
                                                        Colors.yellow,
                                                    size: 30,
                                                    onRatingChanged:
                                                        (double rating) {
                                                      print(rating);
                                                      _note_digest(
                                                          rating,
                                                          (finalDigest.id)
                                                              .toDouble());
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.star,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Evaluer",
                                      style: TextStyle(
                                        fontFamily: 'orkney',
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print("nothing");
                                        // Share.share(
                                        //     "Merci de télécharger notre  application sur play store grace au liens ",
                                        //     subject: 'Look what I made!');

                                        share(context, "",
                                            listDigest[widget.index]);
                                      },
                                      child: Icon(
                                        Icons.share,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Partager",
                                      style: TextStyle(
                                        fontFamily: 'orkney',
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _downlaodAndSaveDigestToStorage(
                                            context,
                                            finalDigest.src.contentUrl,
                                            finalDigest.name);
                                      },
                                      child: Icon(
                                        Icons.download_rounded,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      _isDownloading
                                          ? "Telecharger $progressDowloading"
                                          : "Telecharger",
                                      style: TextStyle(
                                        fontFamily: 'orkney',
                                        color: _isDownloading
                                            ? ColorsApp.skyBlue
                                            : Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Divider(
                                color: Colors.black.withOpacity(.4),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 5),
                                IconButton(
                                  iconSize: 30,
                                  onPressed: () async {
                                    if (indexFinal < listDigest.length &&
                                        indexFinal > 0) {
                                      setState(() {
                                        indexFinal = indexFinal - 1;
                                      });
                                      await inComme(
                                          indexFinal, categoryFinal, false);
                                    } else {
                                      setState(() {
                                        indexFinal = listDigest.length - 1;
                                      });
                                      await inComme(
                                          indexFinal, categoryFinal, false);
                                    }
                                    print(indexFinal);
                                  },
                                  icon: Icon(Icons.skip_previous_rounded,
                                      color: (themeProvider.themeMode ==
                                              ThemeMode.dark)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: ColorsApp.blue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: (finalDigest != null)
                                              ? (finalDigest.duration != null)
                                                  ? StreamBuilder<
                                                          PlaybackState>(
                                                      stream: AudioService
                                                          .playbackStateStream,
                                                      builder:
                                                          (context, snapshot) {
                                                        final playing = snapshot
                                                                .data
                                                                ?.playing ??
                                                            false;
                                                        final disp =
                                                            snapshot.hasData;

                                                        return (disp)
                                                            ? Consumer<IsRead>(
                                                                builder:
                                                                    (context,
                                                                        isRead,
                                                                        child) {
                                                                return (playing)
                                                                    ? InkWell(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .pause,
                                                                          size:
                                                                              30,
                                                                          color: (themeProvider.themeMode == ThemeMode.dark)
                                                                              ? Colors.black
                                                                              : Colors.white,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            isRead.changeState =
                                                                                false;
                                                                          });
                                                                          AudioService
                                                                              .pause();
                                                                        })
                                                                    : InkWell(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .play_arrow_rounded,
                                                                          size:
                                                                              30,
                                                                          color: (themeProvider.themeMode == ThemeMode.dark)
                                                                              ? Colors.black
                                                                              : Colors.white,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            isRead.changeState =
                                                                                true;
                                                                          });
                                                                          AudioService
                                                                              .play();
                                                                        });
                                                              })
                                                            : SpinKitWave(
                                                                color: (themeProvider
                                                                            .themeMode ==
                                                                        ThemeMode
                                                                            .dark)
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white,
                                                                size: 20,
                                                              );
                                                      })
                                                  : Text('erreur',
                                                      style: TextStyle(
                                                          fontFamily: 'orkney',
                                                          color: (themeProvider
                                                                      .themeMode ==
                                                                  ThemeMode
                                                                      .dark)
                                                              ? Colors.white
                                                              : Colors.black))
                                              : SpinKitWave(
                                                  color: (themeProvider
                                                              .themeMode ==
                                                          ThemeMode.dark)
                                                      ? Colors.black
                                                      : Colors.white,
                                                  size: 20,
                                                )),
                                    )),
                                IconButton(
                                  iconSize: 30,
                                  onPressed: () async {
                                    setState(() {
                                      indexFinal = indexFinal + 1;
                                    });
                                    if (indexFinal < listDigest.length &&
                                        indexFinal > 0) {
                                      print("1");
                                      await inComme(
                                          indexFinal, categoryFinal, false);
                                    } else {
                                      print("2");
                                      setState(() {
                                        indexFinal = 0;
                                      });
                                      await inComme(
                                          indexFinal, categoryFinal, false);
                                    }

                                    print(indexFinal);
                                  },
                                  icon: Icon(Icons.skip_next_rounded,
                                      color: (themeProvider.themeMode ==
                                              ThemeMode.dark)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                collapsed: Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * .12),
                  decoration: BoxDecoration(
                      /*  color: ColorsApp.skyBlue, */ /*  borderRadius: radius */
                      ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.angleUp,
                          color: (themeProvider.themeMode == ThemeMode.dark)
                              ? Colors.white
                              : Colors.black,
                        ),
                        Text(
                          'Découvrez la description',
                          style: TextStyle(
                            color: (themeProvider.themeMode == ThemeMode.dark)
                                ? Colors.white
                                : Colors.black,
                            fontFamily: 'orkney',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*   InkWell(
                          child: Icon(FontAwesomeIcons.angleDown),
                          onTap: () {
                            print("ss");
                          },
                        ), */
                      ]),
                ),
                minHeight: MediaQuery.of(context).size.height * 0.20,
                maxHeight: MediaQuery.of(context).size.height * 0.65,
                controller: panelController,
                panel: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          child: Center(
                              child: (panelController.isAttached)
                                  ? (panelController.isPanelOpen)
                                      ? InkWell(
                                          child:
                                              Icon(FontAwesomeIcons.angleDown),
                                          onTap: () => panelController.close())
                                      : InkWell(
                                          child:
                                              Icon(FontAwesomeIcons.angleDown),
                                          onTap: () => panelController.close())
                                  : Text(""))),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.09,
                            left: MediaQuery.of(context).size.width * .05,
                            right: MediaQuery.of(context).size.width * .05),
                        child: Stack(
                          children: <Widget>[
                            SingleChildScrollView(
                                child: Text(
                                    (finalDigest != null)
                                        ? parse(parse((finalDigest.description))
                                                .body
                                                .text)
                                            .documentElement
                                            .text
                                        : "",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontFamily: 'orkney',
                                        color: (themeProvider.themeMode ==
                                                ThemeMode.dark)
                                            ? Colors.white
                                            : Colors.black))),

                            /*  InkWell(
                              child: flag
                                  ? Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.arrow_drop_up,
                                      size: 30,
                                    ),
                              onTap: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                            ), */
                          ],
                        ),
                      ),
                    ])))
            : Center(child:    CircularProgressIndicator(
                                                        backgroundColor:
                                                            ColorsApp.skyBlue,
                                                      ),));
  }

  void share(BuildContext context, String subjets, DigestModel digest) {
    final RenderBox box = context.findRenderObject();

    final String text =
        "Ecoutez le digest ${digest.name} ici \n ${ApiUrl.baseUrl + digest.src.contentUrl}";
    final String subjet = subjets;
    Share.share(text,
        subject: subjet,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  var token = Variable.token;

  void _save(digests) async {
    DigestModel item = DigestModel(
      id: digests.id,
      name: digests.name,
      description: digests.description,
      status: digests.status,
      dateCreate: digests.dateCreate,
      image: digests.image,
      src: digests.src,
    );

    /* digestInsert(digests); */
  }

  var chemin;

  Future<List<Directory>> _getExternalStoragePath() {
    return pathPro.getExternalStorageDirectories(
        type: pathPro.StorageDirectory.downloads);
  }

  Future _downlaodAndSaveDigestToStorage(
      BuildContext context, String urlPath, String fileName) async {
    print("${ApiUrl.baseUrl}" + urlPath);
    print("----------------------------");
    print(fileName);

    try {
      ProgressDialog progress;
      progress = new ProgressDialog(context, type: ProgressDialogType.Download);
      progress.style(message: "Téléchargement en du fichier ...");

      Directory d = Directory('/storage/emulated/0/Android/media/digester');

      final file = File('${d.path}/$fileName.mp3');
      print('${d.path}/$fileName.mp3');
      await Dio().download(
        "${ApiUrl.baseUrl}" + urlPath,
        file.path,
        onReceiveProgress: (rec, total) {
          setState(() {
            _isDownloading = true;
            progressDowloading = ((rec / total) * 100).toStringAsFixed(0) + "%";
            print(progressDowloading);
            progress.update(message: "svp veillez patienter ");
          });
        },
      );
      _showToast(context);
      _save(listDigest[widget.index]);
      _fileFullPath = file.path;
      progress.hide();
      print(_fileFullPath);
      setState(() {
        _isDownloading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

 */