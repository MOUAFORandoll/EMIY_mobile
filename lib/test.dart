import 'dart:convert';

import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Color>? _colorAnimation;
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;

  StreamSubscription? _sub;

  final _scaffoldKey = GlobalKey();
  final _cmds = getCmds();
  final _cmdStyle = const TextStyle(
      fontFamily: 'Courier', fontSize: 12.0, fontWeight: FontWeight.w700);

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri: $uri');
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    try {
      final uri = await getInitialUri();
      if (uri == null) {
        print('no initial uri');
      } else {
        print('got initial uri: $uri');
      }
      var direction = uri!.path.split('/');
      var type = direction[1];
      if (type == 'produits') {
        var codeProduit = direction[2];
        print('----------codeProduit--------${codeProduit}------');
      }
      print('--${direction}---00-lien----------ici----------------------');
    } on PlatformException {
      // Platform messages may fail but we ignore the exception
      print('falied to get initial uri');
    } on FormatException catch (err) {
      print('malformed initial uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final queryParams = _latestUri?.queryParametersAll.entries.toList();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('uni_links example app'),
        ),
        body: InkWell(child: Text('dfdfdfdf'), onTap: _handleInitialUri));
  }

  Widget _cmdsCard(List<String>? commands) {
    Widget platformCmds;

    if (commands == null) {
      platformCmds = const Center(child: Text('Unsupported platform'));
    } else {
      platformCmds = Column(
        children: [
          const [
            if (kIsWeb)
              Text('Append this path to the Web app\'s URL, replacing `#/`:\n')
            else
              Text('To populate above fields open a terminal shell and run:\n'),
          ],
          intersperse(
              commands.map<Widget>((cmd) => InkWell(
                    onTap: () => _printAndCopy(cmd),
                    child: Text('\n$cmd\n', style: _cmdStyle),
                  )),
              const Text('or')),
          [
            Text(
              '(tap on any of the above commands to print it to'
              ' the console/logger and copy to the device clipboard.)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ]
        ].expand((el) => el).toList(),
      );
    }

    return Card(
      margin: const EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: platformCmds,
      ),
    );
  }

  Future<void> _printAndCopy(String cmd) async {
    print(cmd);

    await Clipboard.setData(ClipboardData(text: cmd));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to Clipboard')),
    );
  }

  void _showSnackBar(String msg) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final context = _scaffoldKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    });
  }
}

List<String>? getCmds() {
  late final String cmd;
  var cmdSuffix = '';

  const plainPath = 'path/subpath';
  const args = 'path/portion/?uid=123&token=abc';
  const emojiArgs =
      '?arr%5b%5d=123&arr%5b%5d=abc&addr=1%20Nowhere%20Rd&addr=Rand%20City%F0%9F%98%82';

  if (kIsWeb) {
    return [
      plainPath,
      args,
      emojiArgs,
      // Cannot create malformed url, since the browser will ensure it is valid
    ];
  }

  if (Platform.isIOS) {
    cmd = '/usr/bin/xcrun simctl openurl booted';
  } else if (Platform.isAndroid) {
    cmd = '\$ANDROID_HOME/platform-tools/adb shell \'am start'
        ' -a android.intent.action.VIEW'
        ' -c android.intent.category.BROWSABLE -d';
    cmdSuffix = "'";
  } else {
    return null;
  }

  // https://orchid-forgery.glitch.me/mobile/redirect/
  return [
    '$cmd "unilinks://host/$plainPath"$cmdSuffix',
    '$cmd "unilinks://example.com/$args"$cmdSuffix',
    '$cmd "unilinks://example.com/$emojiArgs"$cmdSuffix',
    '$cmd "unilinks://@@malformed.invalid.url/path?"$cmdSuffix',
  ];
}

List<Widget> intersperse(Iterable<Widget> list, Widget item) {
  final initialValue = <Widget>[];
  return list.fold(initialValue, (all, el) {
    if (all.isNotEmpty) all.add(item);
    all.add(el);
    return all;
  });
}
