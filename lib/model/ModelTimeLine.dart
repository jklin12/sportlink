import 'dart:convert';

List<ModelTimeline> modelTimelineFromJson(String str) => List<ModelTimeline>.from(json.decode(str).map((x) => ModelTimeline.fromJson(x)));

String modelTimelineToJson(List<ModelTimeline> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTimeline {
    ModelTimeline({
        this.idPost,
        this.idUser,
        this.gambar,
        this.caption,
        this.tanggalUpload,
        this.likes,
        this.coments,
    });

    String idPost;
    String idUser;
    String gambar;
    String caption;
    DateTime tanggalUpload;
    String likes;
    String coments;

    factory ModelTimeline.fromJson(Map<String, dynamic> json) => ModelTimeline(
        idPost: json["id_post"],
        idUser: json["id_user"],
        gambar: json["gambar"],
        caption: json["caption"],
        tanggalUpload: DateTime.parse(json["tanggal_upload"]),
        likes: json["likes"],
        coments: json["coments"],
    );

    Map<String, dynamic> toJson() => {
        "id_post": idPost,
        "id_user": idUser,
        "gambar": gambar,
        "caption": caption,
        "tanggal_upload": tanggalUpload.toIso8601String(),
        "likes": likes,
        "coments": coments,
    };
}
