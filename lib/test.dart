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
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:flutter/material.dart';
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

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  File? _videoFile;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoPlaying = false;

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _videoPlayerController = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {
              getModal();
              _videoPlayerController!.play();
              _isVideoPlaying = true;
            });
          });
      });
    }
  }

  void _playPauseVideo() {
    if (_videoPlayerController != null) {
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
        setState(() {
          _isVideoPlaying = false;
        });
      } else {
        _videoPlayerController!.play();
        setState(() {
          _isVideoPlaying = true;
        });
      }
    }
  }

  bool _isVideoDurationValid() {
    if (_videoPlayerController != null) {
      final duration = _videoPlayerController!.value.duration;
      return duration <= Duration(seconds: 30);
    }
    return false;
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  getModal() {
    Get.bottomSheet(
      /* Scaffold(
            appBar: AppBar(
              title: Text("Valider Paiement",
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              leading: InkWell(
                child: Icon(Icons.close, color: Colors.black),
                onTap: () {
                  return Navigator.pop(context);
                },
              ),
            ),
            body: */
      Container(
        height: kHeight,
        child: Stack(
          children: [
            Container(
              // margin: EdgeInsets.only(top: kHeight * .1),
              child: _videoPlayerController != null
                  ? GestureDetector(
                      onTap: _playPauseVideo,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final videoPlayerWidth = constraints.maxWidth;
                          final videoPlayerHeight = videoPlayerWidth /
                              _videoPlayerController!.value.aspectRatio;
   return GestureDetector(
                            onTap: _playPauseVideo,
                            child: Container(
                              width: videoPlayerWidth,
                              height: videoPlayerHeight,
                              color: Colors.black,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController!.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController!),
                              ),
                            ),
                          );
                        },
                      ))
                  : Icon(
                      Icons.videocam,
                      size: 60.0,
                      color: Colors.white,
                    ),
            ),
            Positioned(
                top: 30,
                left: 0,
                child: Container(
                    child: IconButtonF0(
                  color: Colors.black,
                  icon: Icons.close,
                  onTap: () {
                    Get.back();
                  },
                ))),
          ],
        ),
      ),
      isScrollControlled: true,
      isDismissible: true,
    );
  }

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
              onPressed: getModal, //_pickVideo,
              child: Text('Choisir une vidéo'),
            ),
            SizedBox(height: 16.0),
            _videoFile != null && !_isVideoDurationValid()
                ? Text(
                    'La durée maximale autorisée est de 30 secondes.',
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Publier le statut'),
            ),
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
