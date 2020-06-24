import 'dart:convert';

List<ModelMedali> modelMedaliFromJson(String str) => List<ModelMedali>.from(json.decode(str).map((x) => ModelMedali.fromJson(x)));

String modelMedaliToJson(List<ModelMedali> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelMedali {
    ModelMedali({
        this.id,
        this.idKompetisi,
        this.wilayah,
        this.emas,
        this.perak,
        this.perunggu,
    });

    String id;
    String idKompetisi;
    String wilayah;
    String emas;
    String perak;
    String perunggu;

    factory ModelMedali.fromJson(Map<String, dynamic> json) => ModelMedali(
        id: json["id"],
        idKompetisi: json["id_kompetisi"],
        wilayah: json["wilayah"],
        emas: json["emas"],
        perak: json["perak"],
        perunggu: json["perunggu"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_kompetisi": idKompetisi,
        "wilayah": wilayah,
        "emas": emas,
        "perak": perak,
        "perunggu": perunggu,
    };
}
