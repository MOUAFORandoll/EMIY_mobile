import 'dart:convert';

import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
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
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                children: images, // Configurez les hauteurs des tuiles
                mainAxisSpacing: 4.0, // Espace vertical entre les tuiles
                crossAxisSpacing: 4.0, // Espace horizontal entre les tuiles
              ),
            )));
  }
}

// class ObjectBoxManager {
//   /// The Store of this app.
//   late final Store store;

//   ObjectBoxManager._create(this.store) {
//     // Add any additional setup code, e.g. build queries.
//   }

//   /// Create an instance of ObjectBoxManager to use throughout the app.
//   static Future<ObjectBoxManager> create() async {
//     final docsDir = await getApplicationDocumentsDirectory();
//     // Future<Store> openStore() {...} is defined in the generated ObjectBoxManager.g.dart
//     final store =
//         await openStore(directory: p.join(docsDir.path, "obx-example"));
//     return ObjectBoxManager._create(store);
//   }

//   var index = 5;

//   // Create operation
//   void createYourDataModel(YourDataModel newData) {
//     final box = store.box<YourDataModel>();
//     index++;
//     box.put(newData);
//   }

//   // Read operation
//   List<YourDataModel> getAllYourDataModels() {
//     final box = store.box<YourDataModel>();
//     print(box.getAll().length);
//     box.getAll().forEach(
//           (element) => print(element.name),
//         );
//     return box.getAll();
//   }

//   // Update operation
//   void updateYourDataModel(YourDataModel updatedData) {
//     final box = store.box<YourDataModel>();
//     box.put(updatedData);
//   }

//   // Delete operation
//   void deleteYourDataModel(int id) {
//     final box = store.box<YourDataModel>();
//     box.remove(id);
//   }
// }
