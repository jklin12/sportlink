import 'dart:convert';

List<ModelBerita> modelBeritaFromJson(String str) => List<ModelBerita>.from(json.decode(str).map((x) => ModelBerita.fromJson(x)));

String modelBeritaToJson(List<ModelBerita> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelBerita {
    ModelBerita({
        this.id,
        this.level,
        this.judul,
        this.kategori,
        this.gambar,
        this.vidio,
        this.isi,
        this.pengirim,
        this.tanggal,
    });

    String id;
    String level;
    String judul;
    String kategori;
    String gambar;
    String vidio;
    String isi;
    String pengirim;
    DateTime tanggal;

    factory ModelBerita.fromJson(Map<String, dynamic> json) => ModelBerita(
        id: json["id"],
        level: json["level"],
        judul: json["judul"],
        kategori: json["kategori"],
        gambar: json["gambar"],
        vidio: json["vidio"],
        isi: json["isi"],
        pengirim: json["pengirim"],
        tanggal: DateTime.parse(json["tanggal"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "judul": judul,
        "kategori": kategori,
        "gambar": gambar,
        "vidio": vidio,
        "isi": isi,
        "pengirim": pengirim,
        "tanggal": tanggal.toIso8601String(),
    };
}
