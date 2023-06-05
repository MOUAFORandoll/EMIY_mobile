// import 'dart:io';
// import 'dart:convert';

// import 'package:Fahkap/components/Button/AppIconButton.dart';
// import 'package:Fahkap/components/Button/IconButtonF.dart';
// import 'package:Fahkap/components/Button/app_button.dart';
// import 'package:Fahkap/components/Button/button.dart';
// import 'package:Fahkap/components/Button/customBtn.dart';
// import 'package:Fahkap/components/Form/commentForm.dart';
// import 'package:Fahkap/components/Form/formComponent.dart';
// import 'package:Fahkap/components/Form/formComponent2.dart';
// import 'package:Fahkap/components/Form/text_field.dart';
// import 'package:Fahkap/components/Text/bigText.dart';
// import 'package:Fahkap/components/Widget/app_bar_custom.dart';
// import 'package:Fahkap/components/Widget/app_empty.dart';
// import 'package:Fahkap/components/Widget/app_input.dart';
// import 'package:Fahkap/components/Widget/categoryComponent.dart';
// import 'package:Fahkap/components/Text/smallText.dart';
// import 'package:Fahkap/components/Widget/imageComp.dart';
// import 'package:Fahkap/components/Widget/productBoutiqueComponent.dart';
// import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
// import 'package:Fahkap/controller/boutiqueController.dart';
// import 'package:Fahkap/controller/cartController.dart';
// import 'package:Fahkap/controller/categoryController.dart';
// import 'package:Fahkap/model/data/CategoryModel.dart';
// import 'package:Fahkap/styles/colorApp.dart';
// import 'package:Fahkap/styles/textStyle.dart';
// import 'package:Fahkap/utils/Services/SocketService.dart';
// import 'package:Fahkap/utils/Services/validators.dart';
// import 'package:Fahkap/utils/api/apiUrl.dart';
// import 'package:Fahkap/utils/constants/assets.dart';
// import 'package:Fahkap/utils/functions/viewFunctions.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:video_player/video_player.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

import 'dart:convert';

import 'package:Fahkap/components/Button/app_button.dart';
import 'package:Fahkap/controller/negociationController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'package:web_socket_channel/status.dart' as status;

// class Test extends StatefulWidget {
//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   void _dowload() async {
//     try {
//       Directory d = Directory('/storage/emulated/0/Download');

//       final file = File('/storage/emulated/0/Download/facture.pdf');

//       await Dio().download(
//         "${ApiUrl.baseUrl}" + "/download-pdf\/data.pdf",
//         file.path,
//         onReceiveProgress: (rec, total) {
//           print(rec);
//           print(total);
//           if (rec == total) {
//             new ViewFunctions().snackBar('Facture',
//                 'Une facture a ete enregistre dans votre portable', true);
//           }
//         },
//       );

//       // progress.hide();
//     } catch (e) {
//       print(e);
//     }
//   }

//   // late IO.Socket socket;

//   void initState() {
//     super.initState();
//     testSocket();
//     // connectToSocket();
//   }

//   ifNotification(data) {
//     var da = Data.fromJson(data);
//     print(da.a);
//   }

//   void testSocket() {
//     new SocketService().connect('10', ifNotification);
//   }

//   late IO.Socket socket;

//   void connect() {
//     // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
//     socket = IO.io("http://172.20.10.4:3000", <String, dynamic>{
//       "transports": ["websocket"],
//       "autoConnect": false,
//     });
//     socket.connect();
//     socket.emit("signin", 'widget.sourchat.id');
//     socket.onConnect((data) {
//       print("Connected");
//       print(data);
//       socket.on('user-channel:user1', (msg) {
//         print('---nouveau message  ${msg}');
//         // setMessage("destination", msg["message"]);
//       });
//     });
//     print(socket.connected);
//   }

//   void sendMessage(String message, int sourceId, int targetId) {
//     // setMessage("source", message);
//     socket.emit("message",
//         {"message": message, "sourceId": sourceId, "targetId": targetId});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ajouter un statut'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: testSocket, //_pickVideo,
//               child: Text('Add'),
//             ),
//             ElevatedButton(
//               onPressed: () => sendMessage('cxcxcx', 1, 1), //_pickVideo,
//               child: Text('Choisir une vidéo'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _uploadStatus() {
//     // Envoyer la vidéo vers le serveur Symfony
//     // Votre logique d'envoi ici
//     print('Video uploaded successfully!');
//   }
// }

// SocketCommandModel socketCommandModelFromJson(String str) =>
//     SocketCommandModel.fromJson(json.decode(str));

// String socketCommandModelToJson(SocketCommandModel data) =>
//     json.encode(data.toJson());

// class SocketCommandModel {
//   int canal;
//   Data data;

//   SocketCommandModel({
//     required this.canal,
//     required this.data,
//   });

//   factory SocketCommandModel.fromJson(Map<String, dynamic> json) =>
//       SocketCommandModel(
//         canal: json["canal"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "canal": canal,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   String a;
//   String b;

//   Data({
//     required this.a,
//     required this.b,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         a: json["a"],
//         b: json["b"],
//       );

//   Map<String, dynamic> toJson() => {
//         "a": a,
//         "b": b,
//       };
// }
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  var messages = [];

  TextEditingController textEditingController = TextEditingController();

  void initState() {
    super.initState();

    connect();
  }

  late IO.Socket socket;

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://172.20.10.4:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      print("Connected");
      print(data);
      socket.on('chat', (msg) {
        print(msg);
        setState(() {
          messages.add(msg);
        });
        // setMessage("destination", msg["message"]);
      });
    });
    print(socket.connected);
  }

  var code = 0;
  void sendMessage(String message, int sourceId, int targetId) {
    setState(() {
      // setMessage("source", message);
      var sms = {
        "message": message,
        "sourceId": sourceId,
        "targetId": targetId,
        "code": code,
      };
      socket.emit("chat", sms);
      messages.add(sms);
    });
  }

  @override
  Widget build(BuildContext context) {
    return   GetBuilder<NegociationController>(
              builder: (_negociation) =>  Scaffold(
      appBar: AppBar(
        title: Text('Conversation'),
      ),
      body: Column(
        children: [
        Container(
                  margin: EdgeInsets.only(
                      top: Get.size.height * .02,
                      bottom: Get.size.height * .025),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  // padding: EdgeInsets.only(
                  //   top: 25,
                  // ),
                  child: AppButton(
                      size: MainAxisSize.max,
                      bgColor: ColorsApp.black,
                      text: 'Debuter',
                      onTap: () async {
                        _negociation.newNegociation("produit4Snif");
                      }))
        ],
      )),
    );
  }
}
