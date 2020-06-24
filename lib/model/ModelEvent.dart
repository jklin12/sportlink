import 'dart:convert';

List<ModelEvent> modelEventFromJson(String str) => List<ModelEvent>.from(json.decode(str).map((x) => ModelEvent.fromJson(x)));

String modelEventToJson(List<ModelEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelEvent {
    ModelEvent({
        this.idEvent,
        this.level,
        this.judul,
        this.logo,
        this.color,
        this.idFollow,
        this.idUser,
        this.idEvents,
    });

    String idEvent;
    String level;
    String judul;
    String logo;
    String color;
    dynamic idFollow;
    dynamic idUser;
    dynamic idEvents;

    factory ModelEvent.fromJson(Map<String, dynamic> json) => ModelEvent(
        idEvent: json["id_event"],
        level: json["level"],
        judul: json["judul"],
        logo: json["logo"],
        color: json["color"],
        idFollow: json["id_follow"],
        idUser: json["id_user"],
        idEvents: json["id_events"],
    );

    Map<String, dynamic> toJson() => {
        "id_event": idEvent,
        "level": level,
        "judul": judul,
        "logo": logo,
        "color": color,
        "id_follow": idFollow,
        "id_user": idUser,
        "id_events": idEvents,
    };
}
