/* 

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({this.url, this.title});
  final String url, title;
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool chargement = true;
  String condition = "";

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'orkney',
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: WebView(
          initialUrl: widget.url.toString(),
          onWebViewCreated: (WebViewController webviewController) {
            _controller = webviewController;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (_) async {},
        ));
  }
}



 */