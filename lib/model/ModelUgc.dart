// To parse this JSON data, do
//
//     final modelUgc = modelUgcFromJson(jsonString);

import 'dart:convert';

List<ModelUgc> modelUgcFromJson(String str) =>
    List<ModelUgc>.from(json.decode(str).map((x) => ModelUgc.fromJson(x)));

String modelUgcToJson(List<ModelUgc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelUgc {
  ModelUgc({
    this.dataPost,
    this.dataLike,
    this.dataComent,
  });

  DataPost dataPost;
  DataLike dataLike;
  DataComent dataComent;

  factory ModelUgc.fromJson(Map<String, dynamic> json) => ModelUgc(
        dataPost: DataPost.fromJson(json["data_post"]),
        dataLike: DataLike.fromJson(json["data_like"]),
        dataComent: DataComent.fromJson(json["data_coment"]),
      );

  Map<String, dynamic> toJson() => {
        "data_post": dataPost.toJson(),
        "data_like": dataLike.toJson(),
        "data_coment": dataComent.toJson(),
      };
}

class DataComent {
  DataComent({
    this.jmlcoments,
  });

  String jmlcoments;

  factory DataComent.fromJson(Map<String, dynamic> json) => DataComent(
        jmlcoments: json["jmlcoments"],
      );

  Map<String, dynamic> toJson() => {
        "jmlcoments": jmlcoments,
      };
}

class DataLike {
  DataLike({
    this.jmllikes,
  });

  String jmllikes;

  factory DataLike.fromJson(Map<String, dynamic> json) => DataLike(
        jmllikes: json["jmllikes"],
      );

  Map<String, dynamic> toJson() => {
        "jmllikes": jmllikes,
      };
}

class DataPost {
  DataPost({
    this.idPost,
    this.idUser,
    this.gambar,
    this.caption,
    this.tanggalUpload,
    this.likes,
    this.coments,
    this.username,
    this.email,
    this.password,
    this.avatar,
  });

  String idPost;
  String idUser;
  String gambar;
  String caption;
  DateTime tanggalUpload;
  String likes;
  String coments;
  String username;
  String email;
  String password;
  String avatar;

  factory DataPost.fromJson(Map<String, dynamic> json) => DataPost(
        idPost: json["id_post"],
        idUser: json["id_user"],
        gambar: json["gambar"],
        caption: json["caption"],
        tanggalUpload: DateTime.parse(json["tanggal_upload"]),
        likes: json["likes"],
        coments: json["coments"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id_post": idPost,
        "id_user": idUser,
        "gambar": gambar,
        "caption": caption,
        "tanggal_upload": tanggalUpload.toIso8601String(),
        "likes": likes,
        "coments": coments,
        "username": username,
        "email": email,
        "password": password,
        "avatar": avatar,
      };
}
