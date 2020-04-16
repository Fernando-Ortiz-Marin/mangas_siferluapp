import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mangas_siferlu/src/models/manga.models.dart';
import 'package:mangas_siferlu/src/providers/mangas_providers.dart';
import 'package:mangas_siferlu/src/utils/utils.dart' as utils;

class Manga extends StatefulWidget {
  @override
  _MangaState createState() => _MangaState();
}

class _MangaState extends State<Manga> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Video

  MangaModel manga = new MangaModel();
  final mangasProviders = new MangasProviders();
  bool _guardando = false;
  File foto;
  @override
  Widget build(BuildContext context) {
    final MangaModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      manga = proData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registro del Manga'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
               onPressed: _seleccionarFoto,
               ),
          IconButton(icon: Icon(Icons.camera_alt),
           onPressed: _tomarFoto,
           ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearGenero(),
                _crearTomos(),
                _crearCorreo(),
                _crearTarjeta(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      //video
      initialValue: manga.nombre,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre del Manga'),
      onSaved: (value) => manga.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del Manga';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearGenero() {
    return TextFormField(
      //video
      initialValue: manga.genero,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Genero del Manga'),
      onSaved: (value) => manga.genero = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el Genero del Manga';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearTomos() {
    return TextFormField(
      initialValue: manga.tomos.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Tomos del Manga'),
      onSaved: (value) => manga.tomos = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

   Widget _crearCorreo() {
    return TextFormField(
      //video
      initialValue: manga.correo,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Correo del Manga'),
      onSaved: (value) => manga.correo = value,
      validator: (value) {
        if (value.length < 8) {
          return 'Ingrese el correo del Manga';
        } else {
          return null;
        }
      },
    );
  }

   Widget _crearTarjeta() {
    return TextFormField(
      initialValue: manga.tarjeta.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Tarjeta del Usuario'),
      onSaved: (value) => manga.tarjeta = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
        value: manga.disponible,
        title: Text('disponible'),
        activeColor: Color(0xFFBA68C8),
        onChanged: (value) => setState(() {
              manga.disponible = value;
            }));
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed:(_guardando)?null: _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto != null){
      manga.fotoUrl = await mangasProviders.subirImagen(foto);
    }

    if (manga.id == null) {
      
      mangasProviders.crearManga(manga);
    } else {
      mangasProviders.editarManga(manga);
    }
    setState(() {
         _guardando = false;

    });

    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2000),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

Widget _mostrarFoto(){
  if(manga.fotoUrl != null){
    return FadeInImage(
      image: NetworkImage(manga.fotoUrl),
      placeholder: AssetImage('assets/jar.gif'),
      height: 300.0,
      fit: BoxFit.contain,
    );
  }else{
    return Image(
      image: AssetImage(foto?.path ?? 'assets/no.png'),
      height: 300.0,
      fit: BoxFit.cover,
    );
  }
}

  _seleccionarFoto() async {
    foto = await ImagePicker.pickImage(
      source:ImageSource.gallery
       );
       if(foto != null){
         manga.fotoUrl = null;
       }
       setState(() {});
  }

 _tomarFoto() async {
   foto = await ImagePicker.pickImage(
      source:ImageSource.camera
       );
       if(foto != null){
        manga.fotoUrl = null;
       }
       setState(() {});
 }



}
