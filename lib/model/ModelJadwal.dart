import 'dart:convert';

List<ModelJadwal> modelJadwalFromJson(String str) => List<ModelJadwal>.from(json.decode(str).map((x) => ModelJadwal.fromJson(x)));

String modelJadwalToJson(List<ModelJadwal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelJadwal {
    ModelJadwal({
        this.idJadwal,
        this.idEvent,
        this.cabor,
        this.teamA,
        this.teamB,
        this.jadwal,
        this.lokasi,
    });

    String idJadwal;
    String idEvent;
    String cabor;
    String teamA;
    String teamB;
    DateTime jadwal;
    String lokasi;

    factory ModelJadwal.fromJson(Map<String, dynamic> json) => ModelJadwal(
        idJadwal: json["id_jadwal"],
        idEvent: json["id_event"],
        cabor: json["cabor"],
        teamA: json["team_a"],
        teamB: json["team_b"],
        jadwal: DateTime.parse(json["jadwal"]),
        lokasi: json["lokasi"],
    );

    Map<String, dynamic> toJson() => {
        "id_jadwal": idJadwal,
        "id_event": idEvent,
        "cabor": cabor,
        "team_a": teamA,
        "team_b": teamB,
        "jadwal": jadwal.toIso8601String(),
        "lokasi": lokasi,
    };
}