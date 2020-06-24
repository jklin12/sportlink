import 'dart:convert';

Map<String, List<ModelJadwalOlimpiade>> modelJadwalOlimpiadeFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<ModelJadwalOlimpiade>>(k, List<ModelJadwalOlimpiade>.from(v.map((x) => ModelJadwalOlimpiade.fromJson(x)))));

String modelJadwalOlimpiadeToJson(Map<String, List<ModelJadwalOlimpiade>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class ModelJadwalOlimpiade {
    ModelJadwalOlimpiade({
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

    factory ModelJadwalOlimpiade.fromJson(Map<String, dynamic> json) => ModelJadwalOlimpiade(
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
