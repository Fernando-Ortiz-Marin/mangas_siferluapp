import 'dart:convert';

MangakaModel mangakaModelFromJson(String str) => MangakaModel.fromJson(json.decode(str));

String mangakaModelToJson(MangakaModel data) => json.encode(data.toJson());

class MangakaModel {

    String id;
    String nombre;
    String genero;
    int edad;
    String nacionalidad;
    String obra;
    bool disponible;
    String fotoUrl;

    MangakaModel({
        this.id,
        this.nombre ='',
        this.genero='',
        this.edad= 0,
        this.nacionalidad='',
        this.obra='',
        this.disponible = true,
        this.fotoUrl,
    });

    factory MangakaModel.fromJson(Map<String, dynamic> json) => MangakaModel(
        id: json["id"],
        nombre: json["nombre"],
        genero: json["genero"],
        edad: json["edad"],
        nacionalidad: json["nacionalidad"],
        obra: json["obra"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "genero":genero,
        "edad": edad,
        "nacionalidad":nacionalidad,
        "obra":obra,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}