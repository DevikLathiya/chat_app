import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_theme_controller.dart';
import '../../../core/constant/image_constants.dart';
import '../../home/screen/blocked_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../model/bottom_navigation_bar_item_model.dart';

class DashboardScreenController extends GetxController {

  var themeController = Get.find<ThemeController>();

  RxInt currentIndex = RxInt(1);

  TextEditingController searchController = TextEditingController();

  List<Widget> tabWidgets = [const ProfileScreen(), const HomeScreen(),const BlockedScreen()];



  /// Chat

  RxBool isOnline = RxBool(false);
  RxBool isMessageDelete = RxBool(false);
  RxBool dataLoad = RxBool(false);
  RxBool isImageLoad= RxBool(false);

  RxInt skip = RxInt(0);

  late ScrollController scrollController;

  TextEditingController messageInputController = TextEditingController();
  RxList<GetMessageData> getMessageList = RxList<GetMessageData>();

  @override
  Future<void> onInit() async {
    super.onInit();
    // scrollController = ScrollController();
    // scrollController.addListener(_scrollListener);
    // update();
    addDummyData();
  }
  scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      skip.value += 10;
      // await getMessageApi(roomId: roomId.value, skip: skip.value, fromReload: true, limit: 20);
    }
  }

  void addDummyData() {
    getMessageList.addAll([
      GetMessageData(
        id: "1",
        senderId: "123",
        receiverId: "456",
        roomId: RoomId(
          id: "room1",
          chatName: "Chat Room 1",
          isGroupChat: false,
          users: [
            GetMessageUser(
              id: "123",
              firstName: "John",
              lastName: "Doe",
              userName: "johndoe",
              profilePic: "https://example.com/profile1.png",
            ),
            GetMessageUser(
              id: "456",
              firstName: "Jane",
              lastName: "Doe",
              userName: "janedoe",
              profilePic: "https://example.com/profile2.png",
            ),
          ],
        ),
        message: "Hello, how are you?",
        createdAt: "2024-12-19T10:30:00Z",
        updatedAt: DateTime.now(),
        seen: ["123"],
      ),
      GetMessageData(
        id: "2",
        senderId: "456",
        receiverId: "123",
        roomId: RoomId(
          id: "room2",
          chatName: "Chat Room 2",
          isGroupChat: true,
          users: [
            GetMessageUser(
              id: "123",
              firstName: "John",
              lastName: "Doe",
              userName: "johndoe",
              profilePic: "https://example.com/profile1.png",
            ),
            GetMessageUser(
              id: "456",
              firstName: "Jane",
              lastName: "Doe",
              userName: "janedoe",
              profilePic: "https://example.com/profile2.png",
            ),
            GetMessageUser(
              id: "789",
              firstName: "Alice",
              lastName: "Smith",
              userName: "alicesmith",
              profilePic: "https://example.com/profile3.png",
            ),
          ],
        ),
        message: "Meeting tomorrow?",
        createdAt: "2024-12-18T12:45:00Z",
        updatedAt: DateTime.now(),
        seen: ["456", "789"],
      ),
      GetMessageData(
        id: "3",
        senderId: "123",
        receiverId: "123",
        roomId: RoomId(
          id: "room3",
          chatName: "Group Chat 1",
          isGroupChat: true,
          users: [
            GetMessageUser(
              id: "123",
              firstName: "John",
              lastName: "Doe",
              userName: "johndoe",
              profilePic: "https://example.com/profile1.png",
            ),
            GetMessageUser(
              id: "456",
              firstName: "Jane",
              lastName: "Doe",
              userName: "janedoe",
              profilePic: "https://example.com/profile2.png",
            ),
            GetMessageUser(
              id: "789",
              firstName: "Alice",
              lastName: "Smith",
              userName: "alicesmith",
              profilePic: "https://example.com/profile3.png",
            ),
          ],
        ),
        message: "Let's catch up this weekend."*3,
        createdAt: "2024-12-18T15:20:00Z",
        updatedAt: DateTime.now(),
        seen: ["123"],
      ),
      GetMessageData(
        id: "4",
        senderId: "123",
        receiverId: "789",
        roomId: RoomId(
          id: "room4",
          chatName: "Chat Room 4",
          isGroupChat: false,
          users: [
            GetMessageUser(
              id: "123",
              firstName: "John",
              lastName: "Doe",
              userName: "johndoe",
              profilePic: "https://example.com/profile1.png",
            ),
            GetMessageUser(
              id: "789",
              firstName: "Alice",
              lastName: "Smith",
              userName: "alicesmith",
              profilePic: "https://example.com/profile3.png",
            ),
          ],
        ),
        message: "See you at the event!",
        createdAt: "2024-12-17T09:10:00Z",
        updatedAt: DateTime.now(),
        seen: [],
      ),
      GetMessageData(
        id: "5",
        senderId: "456",
        receiverId: "789",
        roomId: RoomId(
          id: "room5",
          chatName: "Chat Room 5",
          isGroupChat: true,
          users: [
            GetMessageUser(
              id: "456",
              firstName: "Jane",
              lastName: "Doe",
              userName: "janedoe",
              profilePic: "https://example.com/profile2.png",
            ),
            GetMessageUser(
              id: "789",
              firstName: "Alice",
              lastName: "Smith",
              userName: "alicesmith",
              profilePic: "https://example.com/profile3.png",
            ),
          ],
        ),
        message: "Good morning!"*3,
        createdAt: "2024-12-16T07:00:00Z",
        updatedAt: DateTime.now(),
        seen: ["789"],
      ),
      GetMessageData(
        id: "5",
        senderId: "456",
        receiverId: "789",
        roomId: RoomId(
          id: "room5",
          chatName: "Chat Room 5",
          isGroupChat: true,
          users: [
            GetMessageUser(
              id: "456",
              firstName: "Jane",
              lastName: "Doe",
              userName: "janedoe",
              profilePic: "https://example.com/profile2.png",
            ),
            GetMessageUser(
              id: "789",
              firstName: "Alice",
              lastName: "Smith",
              userName: "alicesmith",
              profilePic: "https://example.com/profile3.png",
            ),
          ],
        ),
        message: "Good morning!",
        createdAt: "2024-12-16T07:00:00Z",
        updatedAt: DateTime.now(),
        seen: ["789"],
      ),
      GetMessageData(
        id: "4",
        senderId: "123",
        receiverId: "789",
        roomId: RoomId(
          id: "room4",
          chatName: "Chat Room 4",
          isGroupChat: false,
          users: [
            GetMessageUser(
              id: "123",
              firstName: "John",
              lastName: "Doe",
              userName: "johndoe",
              profilePic: "https://example.com/profile1.png",
            ),
            GetMessageUser(
              id: "789",
              firstName: "Alice",
              lastName: "Smith",
              userName: "alicesmith",
              profilePic: "https://example.com/profile3.png",
            ),
          ],
        ),
        message: "See you at the event!",
        createdAt: "2024-12-17T09:10:00Z",
        updatedAt: DateTime.now(),
        seen: [],
      ),
    ]);
  }


}


class GetMessageData {
  String? id;
  String? senderId;
  String? receiverId;
  RoomId? roomId;
  dynamic replyId;
  String? message;
  dynamic fileName;
  List<dynamic>? seen;
  String? createdAt;
  DateTime? updatedAt;
  int? v;
  bool showLongDes = false;

  GetMessageData({
    this.id,
    this.senderId,
    this.receiverId,
    this.roomId,
    this.replyId,
    this.message,
    this.fileName,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.showLongDes = false
  });

  GetMessageData copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    RoomId? roomId,
    dynamic replyId,
    String? message,
    dynamic fileName,
    List<dynamic>? seen,
    String? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      GetMessageData(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        roomId: roomId ?? this.roomId,
        replyId: replyId ?? this.replyId,
        message: message ?? this.message,
        fileName: fileName ?? this.fileName,
        seen: seen ?? this.seen,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory GetMessageData.fromJson(String str) => GetMessageData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetMessageData.fromMap(Map<String, dynamic> json) => GetMessageData(
    id: json["_id"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    roomId: json["roomId"] == null ? null : RoomId.fromMap(json["roomId"]),
    replyId: json["replyId"],
    message: json["message"],
    fileName: json["fileName"],
    seen: json["seen"] == null ? [] : List<dynamic>.from(json["seen"]!.map((x) => x)),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "senderId": senderId,
    "receiverId": receiverId,
    "roomId": roomId?.toMap(),
    "replyId": replyId,
    "message": message,
    "fileName": fileName,
    "seen": seen == null ? [] : List<dynamic>.from(seen!.map((x) => x)),
    "createdAt": createdAt,
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class RoomId {
  String? id;
  String? chatName;
  bool? isGroupChat;
  List<GetMessageUser>? users;
  dynamic logo;
  DateTime? createdAt;
  DateTime? updatedAt;

  RoomId({
    this.id,
    this.chatName,
    this.isGroupChat,
    this.users,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  RoomId copyWith({
    String? id,
    String? chatName,
    bool? isGroupChat,
    List<GetMessageUser>? users,
    dynamic logo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      RoomId(
        id: id ?? this.id,
        chatName: chatName ?? this.chatName,
        isGroupChat: isGroupChat ?? this.isGroupChat,
        users: users ?? this.users,
        logo: logo ?? this.logo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory RoomId.fromJson(String str) => RoomId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomId.fromMap(Map<String, dynamic> json) => RoomId(
    id: json["_id"],
    chatName: json["chatName"],
    isGroupChat: json["isGroupChat"],
    users: json["users"] == null ? [] : List<GetMessageUser>.from(json["users"]!.map((x) => GetMessageUser.fromMap(x))),
    logo: json["logo"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "chatName": chatName,
    "isGroupChat": isGroupChat,
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toMap())),
    "logo": logo,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class GetMessageUser {
  String? id;
  String? profilePic;
  String? firstName;
  String? lastName;
  String? userName;

  GetMessageUser({
    this.id,
    this.profilePic,
    this.firstName,
    this.lastName,
    this.userName,
  });

  GetMessageUser copyWith({
    String? id,
    String? profilePic,
    String? firstName,
    String? lastName,
    String? userName,
  }) =>
      GetMessageUser(
        id: id ?? this.id,
        profilePic: profilePic ?? this.profilePic,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        userName: userName ?? this.userName,
      );

  factory GetMessageUser.fromJson(String str) => GetMessageUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetMessageUser.fromMap(Map<String, dynamic> json) => GetMessageUser(
    id: json["_id"],
    profilePic: json["profilePic"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    userName: json["userName"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "profilePic": profilePic,
    "firstName": firstName,
    "lastName": lastName,
    "userName": userName,
  };
}