import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:EMIY/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'package:web_socket_channel/status.dart' as status;

class SocketService {
  SocketService();
  // late IO.Socket socket;
  IO.Socket socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });
  void commande(canal, Function action) {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );

    // socket.connect();
    // socket.emit("signin", 350);

    // socket.onConnect((data) {
    //   print("Connected");
    //   print(socket.connected);
    socket.on('commande', (msg) {
      print(canal);

      if (jsonDecode(msg)['canal'].toString() == canal.toString()) {
        print('-----------------');
        print(jsonDecode(msg)['data']);
        action(jsonDecode(msg)['data']);
      }
      // socket.close();
      // setMessage("destination", msg["message"]);
    });
    // });
    print(socket.connected);
  }

  void transaction(canal, Function action) {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    // socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": true,
    // });
    // socket.connect();
    // socket.emit("signin", 350);

    // socket.onConnect((data) {
    // print("Connected");
    // print(socket.connected);
    socket.on('transaction', (msg) {
      print(canal);

      if (jsonDecode(msg)['canal'].toString() == canal.toString()) {
        print('-----------------');
        print(jsonDecode(msg)['data']);
        action(jsonDecode(msg)['data']);
      }
      // socket.close();
      // setMessage("destination", msg["message"]);
    });
    // });
    print(socket.connected);
  }

  void boutique(canal, Function action) {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    // socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": true,
    // });
    // // socket.connect();
    // // socket.emit("signin", 350);

    // socket.onConnect((data) {
    //   print("Connected");
    //   print(socket.connected);
    socket.on('boutique', (msg) {
      print(canal);

      if (jsonDecode(msg)['canal'].toString() == canal.toString()) {
        print('-----------boutique------');
        print(jsonDecode(msg)['data']);
        action(jsonDecode(msg)['data']);
      }
      // socket.close();
      // setMessage("destination", msg["message"]);
    });
    // });
    print(socket.connected);
  }

  void negociation(canal, Function action) {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    // socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": true,
    // });
    // // socket.connect();
    // // socket.emit("signin", 350);

    // socket.onConnect((data) {
    print("Connected au canal negociation $canal ");
    //   print(socket.connected);
    socket.on('negociation', (msg) {
      print(canal);
      print('-...............');
      print(jsonDecode(msg)['canal'].toString());

      if (jsonDecode(msg)['canal'].toString() == canal.toString()) {
        print('-----------------');
        print(jsonDecode(msg)['data']);
        action(jsonDecode(msg)['data']);
      }
      // socket.close();
      // setMessage("destination", msg["message"]);
    });
    // });
    print(socket.connected);
  }

  void general(Function action) {
    socket.on('general', (msg) {
      // print('00-----------------');
      // print(jsonDecode(msg));
      action(jsonDecode(msg));
    });
    // });
    // print(socket.connected);
  }
}
