// To parse this JSON data, do
//
//     final nearestRcnModel = nearestRcnModelFromJson(jsonString);

import 'dart:convert';

List<NearestRcnModel> nearestRcnModelFromJson(String str) =>
    List<NearestRcnModel>.from(
        json.decode(str).map((x) => NearestRcnModel.fromJson(x)));

String nearestRcnModelToJson(List<NearestRcnModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NearestRcnModel {
  NearestRcnModel({
    required this.id,
    required this.title,
    required this.pointMan,
    required this.location,
    required this.phoneNo,
    required this.website,
    required this.lat,
    required this.lon,
    required this.isLatLon,
  });

  String id;
  String title;
  String pointMan;
  String location;
  String phoneNo;
  String website;
  String lat;
  String lon;
  String isLatLon;

  factory NearestRcnModel.fromJson(Map<String, dynamic> json) =>
      NearestRcnModel(
        id: json["id"],
        title: json["title"],
        pointMan: json["point_man"],
        location: json["location"],
        phoneNo: json["phone_no"],
        website: json["website"],
        lat: json["lat"],
        lon: json["lon"],
        isLatLon: json["is_lat_lon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "point_man": pointMan,
        "location": location,
        "phone_no": phoneNo,
        "website": website,
        "lat": lat,
        "lon": lon,
        "is_lat_lon": isLatLon,
      };
}
