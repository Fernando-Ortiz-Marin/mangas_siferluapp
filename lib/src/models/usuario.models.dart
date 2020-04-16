import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    String id;
    String nombre;
    String apellido;
    int edad;
    String correo;
    int tarjeta;
    bool disponible;
    String fotoUrl;

    UsuarioModel({
        this.id,
        this.nombre ='',
        this.apellido,
        this.edad= 0,
        this.correo='',
        this.tarjeta=0,
        this.disponible = true,
        this.fotoUrl,
    });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        edad: json["edad"],
        correo: json["correo"],
        tarjeta: json["tarjeta"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "apellido":apellido,
        "edad": edad,
        "correo":correo,
        "tarjeta":tarjeta,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}