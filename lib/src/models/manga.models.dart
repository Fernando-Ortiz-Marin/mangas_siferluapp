import 'dart:convert';

MangaModel mangaModelFromJson(String str) => MangaModel.fromJson(json.decode(str));

String mangaModelToJson(MangaModel data) => json.encode(data.toJson());

class MangaModel {
    String id;
    String nombre;
    String genero;
    int tomos;
    String correo;
    int tarjeta;
    bool disponible;
    String fotoUrl;

    MangaModel({
        this.id,
        this.nombre ='',
        this.genero="",
        this.tomos= 0,
        this.correo='',
        this.tarjeta=0,
        this.disponible = true,
        this.fotoUrl,
    });

    factory MangaModel.fromJson(Map<String, dynamic> json) => MangaModel(
        id: json["id"],
        nombre: json["nombre"],
        genero: json["genero"],
        tomos: json["tomos"],
        correo: json["correo"],
        tarjeta: json["tarjeta"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "genero":genero,
        "tomos": tomos,
        "correo":correo,
        "tarjeta":tarjeta,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}