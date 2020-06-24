// To parse this JSON data, do
//
//     final modelPemain = modelPemainFromJson(jsonString);

import 'dart:convert';

List<ModelPemain> modelPemainFromJson(String str) => List<ModelPemain>.from(json.decode(str).map((x) => ModelPemain.fromJson(x)));

String modelPemainToJson(List<ModelPemain> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPemain {
    ModelPemain({
        this.idPemaian,
        this.idEvent,
        this.nama,
        this.asal,
        this.foto,
    });

    String idPemaian;
    String idEvent;
    String nama;
    String asal;
    String foto;

    factory ModelPemain.fromJson(Map<String, dynamic> json) => ModelPemain(
        idPemaian: json["id_pemaian"],
        idEvent: json["id_event"],
        nama: json["nama"],
        asal: json["asal"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id_pemaian": idPemaian,
        "id_event": idEvent,
        "nama": nama,
        "asal": asal,
        "foto": foto,
    };
}
