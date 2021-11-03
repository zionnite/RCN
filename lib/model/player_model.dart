// To parse this JSON data, do
//
//     final playerModel = playerModelFromJson(jsonString);

import 'dart:convert';

List<PlayerModel> playerModelFromJson(String str) => List<PlayerModel>.from(
    json.decode(str).map((x) => PlayerModel.fromJson(x)));

String playerModelToJson(List<PlayerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlayerModel {
  PlayerModel({
    required this.id,
    required this.audioUrl,
    required this.album,
    required this.title,
    required this.artUri,
  });

  String id;
  String audioUrl;
  String album;
  String title;
  String artUri;

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"],
        audioUrl: json["audio_url"],
        album: json["album"],
        title: json["title"],
        artUri: json["artUri"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "audio_url": audioUrl,
        "album": album,
        "title": title,
        "artUri": artUri,
      };
}
