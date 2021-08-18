import 'dart:developer';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user.dart';

import '/controllers/controller.dart';
import '/constants/constant.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  /// Socket
  late IO.Socket socket;

  final userController = Get.find<UserController>();

  late User currentUser;

  @override
  void onInit() {
    super.onInit();
  }

  void onConnect(String token) {
    currentUser = userController.currentUser!;
    socket = IO.io(
        RestfulConstant.REMOTE_HOST + ':' + RestfulConstant.PORT,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'x-access-token': token}) // optional
            .build());
    if (socket.disconnected) socket.connect();
    _onListen();
  }

  void onDisconnect() {
    socket.disconnect();
  }

  /// Listen socket
  void _onListen() {
    socket.onConnect((_) {
      log('Connected socket');

      /// connect by user information
      socket.emit('user connect', currentUser.toJsonSocket());

      // get all user
      socket.on('get all user', (data) {
        final user = User.fromJson(data);
        userController.addConnectUser(user);
      });

      // new user connect
      socket.on('new user connect', (data) {
        final user = User.fromJson(data);
        userController.addConnectUser(user);
      });

      // listen offline user
      socket.on('user disconnect', (data) {
        final user = User.fromJson(data);
        userController.addConnectUser(user);
      });

      // listen typing
      socket.on('typing', (data) {
        final status = data['status'];
        final sender = User.fromJson(data['sender']);
        userController.setTyping(sender, status);
      });

      // listen message
      socket.on('private message', (data) {
        final message = Message.fromJson(data);
        userController.addMessage(message);
      });
    });
  }

  /// Typing
  void setTyping(User receiver, bool status) {
    final data = {
      "sender": currentUser.toJsonSocket(),
      "receiver": receiver.toJsonSocket(),
      "status": status
    };
    socket.emit('typing', data);
  }

  /// Send message
  void sendMessage(User receiver, String message) {
    final msg = Message(
      message: message,
      sender: currentUser,
      receiver: receiver,
    ).toJson();
    socket.emit('private message', msg);
  }
}
