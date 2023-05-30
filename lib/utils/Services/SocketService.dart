import 'dart:io';
import 'dart:ui';

import 'package:Fahkap/utils/api/apiUrl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'package:web_socket_channel/status.dart' as status;

class SocketService {
  SocketService();
  late IO.Socket socket;

  void connect(canal, Function action) {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true,
    });
    socket.connect();
    // socket.emit("signin", 350);
    // // socket.emit("message", '0000');
    // socket.on('message', (msg) {
    //   print('---nouveau message  ${msg}');
    //   action(msg);
    //   // socket.close();
    //   // setMessage("destination", msg["message"]);
    // });
    socket.onConnect((data) {
      print("Connected");
      print(socket.connected);
      socket.on('message', (msg) {
        print('---nouveau message  ${msg}');
        action(msg);
        // socket.close();
        // setMessage("destination", msg["message"]);
      });
    });
    print(socket.connected);
  }
}
