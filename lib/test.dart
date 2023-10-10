import 'dart:convert';

import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/styles/theme.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:video_player/video_player.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'package:web_socket_channel/status.dart' as status;
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// import 'objectbox.g.dart';
import 'entity.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

bool _initialUriIsHandled = false;
// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   var messages = [];
//   late VideoPlayerController _videoPlayerController;
//   late Future<void> videoPlayerInitializer;
//   void initState() {
//     super.initState();
//     loadController();
//   }

//   loadController() async {
//     //print('**************lectyre');
//     _videoPlayerController = VideoPlayerController.network(
//         "http://172.20.10.8:4000/short?video=test.mp4");
//     videoPlayerInitializer = _videoPlayerController.initialize();

//     _videoPlayerController.setLooping(true);
//   }

//   Future<Stream<List<int>>?> fetchVideoSegment(
//       String url, int startByte, int endByte) async {
//     final connect = Get.find<GetConnect>();

//     final response = await connect.get(
//       url,
//       headers: {'range': 'bytes=$startByte-$endByte'},
//     );

//     return response.bodyBytes;
//   }

//   Future<void> playVideoSegment() async {
//     final startByte = 0;
//     final endByte = 100000; // Exemple de plage de segment

//     final segmentData = await fetchVideoSegment(
//         'http://172.20.10.8:4000/api/video?video=test.mp4', startByte, endByte);

//     // await _videoPlayerController.memory();
//     //   _videoPlayerController = VideoPlayerController.memory(segmentData);

//     await _videoPlayerController.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NegociationController>(
//       builder: (_negociation) => Scaffold(
//           appBar: AppBar(
//             title: Text('Conversation'),
//           ),
//           body: Column(
//             children: [
//               Container(
//                   margin: EdgeInsets.only(
//                       top: Get.size.height * .02,
//                       bottom: Get.size.height * .025),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.white),
//                   // padding: EdgeInsets.only(
//                   //   top: 25,
//                   // ),
//                   child: AppButton(
//                       size: MainAxisSize.max,
//                       bgColor: ColorsApp.black,
//                       text: 'Debuter',
//                       onTap: () async {
//                         _videoPlayerController.play();
//                         // await loadController();
//                       })),
//               FutureBuilder(
//                 future: videoPlayerInitializer,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return AspectRatio(
//                       aspectRatio: 100 / 50,
//                       child: VideoPlayer(
//                         _videoPlayerController,
//                       ),
//                     );
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               ),
//               VideoProgressIndicator(_videoPlayerController,
//                   allowScrubbing: true)
//             ],
//           )),
//     );
//   }
// }

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  List<Widget> images = [];

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  void _getImages() async {
    // Récupère une liste d'URL d'images au hasard

    final imagesData = [
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
      'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
    ];

    // Itère sur la liste d'URL et charge les images
    for (int i = 0; i < imagesData.length; i++) {
      var imageData = imagesData[i];
      var p = (i % 2 == 1); // Check if i is odd (equivalent to p == 1)
      final image = CachedNetworkImage(
        // height: p ? 400.0 : 200.0,
        width: Get.width * .5,
        imageUrl: imageData,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: p ? 300.0 : 200.0,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.transparent, BlendMode.colorBurn)),
            ),
          );
        },
        placeholder: (context, url) {
          return Container(
            child: Center(
                child: CircularProgressIndicator(
              color: ColorsApp.skyBlue,
            )),
          );
        },
        errorWidget: (context, url, error) {
          return CircleAvatar(
              backgroundColor: ColorsApp.skyBlue,
              radius: 50,
              backgroundImage: AssetImage("assets/images/error.gif"));
        },
      );
      images.add(image);
    }

    // Met à jour l'état de la liste d'images
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Pinterest'),
            ),
            body: SingleChildScrollView(
                child: Container(
                    child: Column(children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: kMarginX * 2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text('Bets seller'),
                      ),
                      Container(
                        child: Icon(Icons.arrow_forward),
                      )
                    ]),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: kMarginX * 2, vertical: kMarginY),
                  height: kHeight * .4,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_ctx, index) => index == 4
                          ? Container(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 30,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                // color: ColorsApp.greyTi,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                  // height: kHeight / 2.7,
                                  // margin: EdgeInsets.symmetric(horizontal: 5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    // color: ColorsApp.greyTi,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: kMarginX * 2),
                                          height: kHeight * .25,
                                          width: kHeight * .1,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: AssetImage(Assets.shop2),
                                          )),
                                        ),
                                        Positioned(
                                          top: 2,
                                          right: 2,
                                          child: InkWell(
                                              child: Icon(Icons.handshake),
                                              onTap: () {
                                                Get.find<
                                                        NegociationController>()
                                                    .newNegociation(
                                                        "produit.codeProduit");
                                              }),
                                        ),
                                        Positioned(
                                          bottom: 2,
                                          right: 2,
                                          child: InkWell(
                                              child: Icon(Icons.favorite,
                                                  color: ColorsApp.red),
                                              onTap: () {}),
                                        )
                                      ]),
                                      Container(
                                          width: kWidth / 2,
                                          child: Text("produit.titre",
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.left,
                                              style: TexteStyle()
                                                  .secondaryTextStyle)),
                                      Container(
                                          width: kWidth / 2,
                                          child: Text('XAF ' + '5005',
                                              overflow: TextOverflow.ellipsis,
                                              style: TexteStyle()
                                                  .bprimaryTextStyle)),
                                    ],
                                  )))))
            ])))));
  }
}
