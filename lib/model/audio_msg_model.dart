// To parse this JSON data, do
//
//     final audioMsg = audioMsgFromJson(jsonString);

import 'dart:convert';

List<AudioMsg> audioMsgFromJson(String str) =>
    List<AudioMsg>.from(json.decode(str).map((x) => AudioMsg.fromJson(x)));

String audioMsgToJson(List<AudioMsg> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AudioMsg {
  AudioMsg({
    required this.id,
    required this.title,
    required this.link,
    required this.album,
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
  String album;
  String image;
  String downloadCounter;
  bool isPlayListed;
  String status;
  String statusMsg;
  String time;

  factory AudioMsg.fromJson(Map<String, dynamic> json) => AudioMsg(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        album: json["album"],
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
        "album": album,
        "image": image,
        "download_counter": downloadCounter,
        "isPlayListed": isPlayListed,
        "status": status,
        "status_msg": statusMsg,
        "time": time,
      };
}
