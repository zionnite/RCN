// To parse this JSON data, do
//
//     final itinerary = itineraryFromJson(jsonString);

import 'dart:convert';

List<Itinerary> itineraryFromJson(String str) =>
    List<Itinerary>.from(json.decode(str).map((x) => Itinerary.fromJson(x)));

String itineraryToJson(List<Itinerary> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Itinerary {
  Itinerary({
    required this.id,
    required this.title,
    required this.desc,
    required this.image,
    required this.author,
    required this.authorImage,
    required this.status,
    required this.statusMsg,
    required this.time,
    required this.location,
    required this.startTime,
    required this.eventDate,
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
  String location;
  String startTime;
  String eventDate;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        image: json["image"],
        author: json["author"],
        authorImage: json["author_image"],
        status: json["status"],
        statusMsg: json["status_msg"],
        time: json["time"],
        location: json["location"],
        startTime: json["start_time"],
        eventDate: json["event_date"],
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
        "location": location,
        "start_time": startTime,
        "event_date": eventDate,
      };
}
