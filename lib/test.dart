import 'dart:io';

import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/app_button.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/commentForm.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Widget/app_bar_custom.dart';
import 'package:Fahkap/components/Widget/app_empty.dart';
import 'package:Fahkap/components/Widget/app_input.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/imageComp.dart';
import 'package:Fahkap/components/Widget/productBoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/validators.dart';
import 'package:Fahkap/utils/api/apiUrl.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  void _dowload() async {
    try {
      Directory d = Directory('/storage/emulated/0/Download');

      final file = File('/storage/emulated/0/Download/facture.pdf');

      await Dio().download(
        "${ApiUrl.baseUrl}" + "/download-pdf\/data.pdf",
        file.path,
        onReceiveProgress: (rec, total) {
          print(rec);
          print(total);
          if (rec == total) {
            new ViewFunctions().snackBar('Facture',
                'Une facture a ete enregistre dans votre portable', true);
          }
        },
      );

      // progress.hide();
    } catch (e) {
      print(e);
    }
  }

  // late IO.Socket socket;

  void initState() {
    super.initState();
    init();
    connectToSocket();
  }

  var socket;
  void init() async {
    setState(() {
      
    socket = IOWebSocketChannel.connect('ws://172.20.10.4:3000');
    });
  }

  void connectToSocket() async {
    // var socket = await WebSocket.connect('ws://172.20.10.4:3000');

    socket.stream.listen((socket) {
      print(socket);
    });
  }

  void add() async {
    socket.sink.add('Hello, server!');
  }

  // void connectToSocket() {
  //   socket = IO.io('http://172.20.10.4').connect();
  //   print('socket.connected');
  //   print(socket.connected);
  //   socket.onConnect((_) {
  //     print('Connected to Socket.IO server');
  //   });

  //   socket.on('event', (data) {
  //     print('Received event: $data');
  //     // Handle the event data as needed
  //   });

  //   socket.onDisconnect((_) {
  //     print('Disconnected from Socket.IO server');
  //   });

  //   socket.connect();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un statut'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // GestureDetector(
            //   onTap: _playPauseVideo,
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       Container(
            //         width: 300,
            //         height: 300,
            //         decoration: BoxDecoration(
            //           color: Colors.black,
            //           borderRadius: BorderRadius.circular(12.0),
            //         ),
            //         child: _videoPlayerController != null
            //             ? AspectRatio(
            //                 aspectRatio:
            //                     _videoPlayerController!.value.aspectRatio,
            //                 child: VideoPlayer(_videoPlayerController!),
            //               )
            //             : Icon(
            //                 Icons.videocam,
            //                 size: 60.0,
            //                 color: Colors.white,
            //               ),
            //       ),
            //       _isVideoPlaying
            //           ? SizedBox.shrink()
            //           : Icon(
            //               Icons.play_arrow,
            //               size: 60.0,
            //               color: Colors.white,
            //             ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: add, //_pickVideo,
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: connectToSocket, //_pickVideo,
              child: Text('Choisir une vidéo'),
            ),
            // SizedBox(height: 16.0),
            // _videoFile != null && !_isVideoDurationValid()
            //     ? Text(
            //         'La durée maximale autorisée est de 30 secondes.',
            //         style: TextStyle(color: Colors.red),
            //       )
            //     : SizedBox.shrink(),
            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: _pickVideo,
            //   child: Text('Publier le statut'),
            // ),
          ],
        ),
      ),
    );
  }

  void _uploadStatus() {
    // Envoyer la vidéo vers le serveur Symfony
    // Votre logique d'envoi ici
    print('Video uploaded successfully!');
  }
}
