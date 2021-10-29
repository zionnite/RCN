// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(
    json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  SliderModel({
    required this.title,
    required this.image,
  });

  String title;
  String image;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        title: json["Title"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Image": image,
      };
}
