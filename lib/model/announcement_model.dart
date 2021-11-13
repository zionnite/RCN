// To parse this JSON data, do
//
//     final announcementModel = announcementModelFromJson(jsonString);

import 'dart:convert';

List<AnnouncementModel> announcementModelFromJson(String str) =>
    List<AnnouncementModel>.from(
        json.decode(str).map((x) => AnnouncementModel.fromJson(x)));

String announcementModelToJson(List<AnnouncementModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnnouncementModel {
  AnnouncementModel({
    required this.id,
    required this.body,
    required this.date,
    required this.author,
    required this.image,
  });

  String id;
  String body;
  String date;
  String author;
  String image;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json["id"],
        body: json["body"],
        date: json["date"],
        author: json["author"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "date": date,
        "author": author,
        "image": image,
      };
}
