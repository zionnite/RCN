// To parse this JSON data, do
//
//     final seeKGod = seeKGodFromJson(jsonString);

import 'dart:convert';

List<SeeKGod> seeKGodFromJson(String str) =>
    List<SeeKGod>.from(json.decode(str).map((x) => SeeKGod.fromJson(x)));

String seeKGodToJson(List<SeeKGod> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeeKGod {
  SeeKGod({
    required this.id,
    required this.title,
    required this.desc,
    required this.image,
    required this.author,
    required this.authorImage,
    required this.status,
    required this.statusMsg,
    required this.time,
  });

  String id;
  String title;
  String desc;
  String image;
  String author;
  String authorImage;
  String status;
  String statusMsg;
  String time;

  factory SeeKGod.fromJson(Map<String, dynamic> json) => SeeKGod(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        image: json["image"],
        author: json["author"],
        authorImage: json["author_image"],
        status: json["status"],
        statusMsg: json["status_msg"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "image": image,
        "author": author,
        "author_image": authorImage,
        "status": status,
        "status_msg": statusMsg,
        "time": time,
      };
}
