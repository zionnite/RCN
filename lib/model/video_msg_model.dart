// To parse this JSON data, do
//
//     final videoMsg = videoMsgFromJson(jsonString);

import 'dart:convert';

List<VideoMsg> videoMsgFromJson(String str) =>
    List<VideoMsg>.from(json.decode(str).map((x) => VideoMsg.fromJson(x)));

String videoMsgToJson(List<VideoMsg> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoMsg {
  VideoMsg({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
    required this.downloadCounter,
    required this.isPlayListed,
    required this.status,
    required this.statusMsg,
    required this.time,
  });

  String id;
  String title;
  String link;
  String image;
  String downloadCounter;
  bool isPlayListed;
  String status;
  String statusMsg;
  String time;

  factory VideoMsg.fromJson(Map<String, dynamic> json) => VideoMsg(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        image: json["image"],
        downloadCounter: json["download_counter"],
        isPlayListed: json["isPlayListed"],
        status: json["status"],
        statusMsg: json["status_msg"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "image": image,
        "download_counter": downloadCounter,
        "isPlayListed": isPlayListed,
        "status": status,
        "status_msg": statusMsg,
        "time": time,
      };
}
