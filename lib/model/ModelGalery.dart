// To parse this JSON data, do
//
//     final modelGalery = modelGaleryFromJson(jsonString);

import 'dart:convert';

List<ModelGalery> modelGaleryFromJson(String str) => List<ModelGalery>.from(
    json.decode(str).map((x) => ModelGalery.fromJson(x)));

String modelGaleryToJson(List<ModelGalery> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelGalery {
  ModelGalery({
    this.gambar,
  });

  String gambar;

  factory ModelGalery.fromJson(Map<String, dynamic> json) => ModelGalery(
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "gambar": gambar,
      };
}
