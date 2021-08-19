import 'package:chat_app/models/user.dart';

class Message {
  Message({
    this.id,
    this.message,
    this.sender,
    this.receiver,
    this.isRead = false,
    this.createdAt,
  });

  int? id;
  String? message;
  User? sender;
  User? receiver;
  String? createdAt;
  bool isRead;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      createdAt: json['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'sender': sender!.toJsonSocket(),
        'receiver': receiver!.toJsonSocket(),
        'createdAt': DateTime.now().toString(),
      };
}
