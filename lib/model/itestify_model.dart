// To parse this JSON data, do
//
//     final itestifyModel = itestifyModelFromJson(jsonString);

import 'dart:convert';

List<ItestifyModel> itestifyModelFromJson(String str) =>
    List<ItestifyModel>.from(
        json.decode(str).map((x) => ItestifyModel.fromJson(x)));

String itestifyModelToJson(List<ItestifyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItestifyModel {
  ItestifyModel({
    required this.id,
    required this.userImage,
    required this.fullName,
    required this.userName,
    required this.counter,
    required this.body,
    required this.isTeskLike,
    required this.status,
    required this.statusMsg,
    required this.time,
  });

  String id;
  String userImage;
  String fullName;
  String userName;
  int counter;
  String body;
  bool isTeskLike;
  String status;
  String statusMsg;
  String time;

  factory ItestifyModel.fromJson(Map<String, dynamic> json) => ItestifyModel(
        id: json["id"],
        userImage: json["user_image"],
        fullName: json["full_name"],
        userName: json["user_name"],
        counter: json["counter"],
        body: json["body"],
        isTeskLike: json["is_teskLike"],
        status: json["status"],
        statusMsg: json["status_msg"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_image": userImage,
        "full_name": fullName,
        "user_name": userName,
        "counter": counter,
        "body": body,
        "is_teskLike": isTeskLike,
        "status": status,
        "status_msg": statusMsg,
        "time": time,
      };
}
