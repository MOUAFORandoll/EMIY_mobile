import 'dart:io';

import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/app_button.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class Test extends StatelessWidget {
  final VideoController controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: GetBuilder<VideoController>(
        init: controller,
        builder: (_) {
          return Center(
            child: _.videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_.videoPlayerController),
                  )
                : CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeVideo(),
        child: Icon(Icons.skip_next),
      ),
    );
  }
}

class VideoModel {
  final String videoUrl;

  VideoModel({required this.videoUrl});
}

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late List<VideoModel> videoList;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    videoList = [
      VideoModel(
          videoUrl: 'http://127.0.0.1:8000/videos/shorts/produitWxCZH.mp4'),
      VideoModel(
          videoUrl: 'http://127.0.0.1:8000/videos/shorts/produitWxCZH.mp4'),

      // Ajoutez d'autres vidéos ici
    ];
    loadVideo();
  }

  void loadVideo() {
    final videoUrl = videoList[currentIndex].videoUrl;
    
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        videoPlayerController.play();
        update();
      });
  }

  void changeVideo() {
    currentIndex = (currentIndex + 1) % videoList.length;
    videoPlayerController.pause();
    videoPlayerController.dispose();
    loadVideo();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}
