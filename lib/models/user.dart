import 'package:chat_app/models/message.dart';

class User {
  User({
    this.id,
    this.name,
    this.lastName,
    this.phone,
    this.password,
    this.profileImage,
    this.isOnline = true,
    this.typing = false,
    this.lastSeen,
  });

  int? id;
  String? name;
  String? lastName;
  String? phone;
  String? password;
  String? profileImage;
  bool isOnline;
  bool typing;
  String? lastSeen;
  List<Message> messages = [];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      phone: json['phone'],
      password: json['password'],
      profileImage: json['profileImage'],
      isOnline: json['isOnline'] ?? true,
      lastSeen: json['lastSeen']?.toString(),
    );
  }

  Map<String, dynamic> toJsonDb() => {
        'id': id,
        'name': name,
        'phone': phone,
        'lastName': lastName,
        'password': password,
        'profileImage': profileImage,
      };

  Map<String, dynamic> toJsonSocket() => {
        'name': name,
        'lastName': lastName,
        'phone': phone,
        'isOnline': isOnline,
        'lastSeen': DateTime.now().toString(),
      };
}
