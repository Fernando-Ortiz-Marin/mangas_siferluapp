import 'package:flutter/material.dart';
import 'package:mangas_siferlu/src/models/mangaka.models.dart';
import 'package:mangas_siferlu/src/providers/mangakas_providers.dart';
import 'package:mangas_siferlu/src/utils/utils.dart' as utils;

class Mangaka extends StatefulWidget {
  @override
  _MangakaState createState() => _MangakaState();
}

class _MangakaState extends State<Mangaka> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Video

  MangakaModel mangaka = new MangakaModel();
  final mangakasProviders = new MangakasProviders();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final MangakaModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      mangaka = proData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registro del mangaka'),
       /* actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],*/
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[

                _crearNombre(),
                _crearGenero(),
                _crearEdad(),
                _crearNacionalidad(),
                _crearObra(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
//-------------------------------------------------------//
  Widget _crearNombre() {
    return TextFormField(
      //video
      initialValue: mangaka.nombre,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'nombre'),
      onSaved: (value) => mangaka.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearGenero() {
    return TextFormField(
      //video
      initialValue: mangaka.genero,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Genero'),
      onSaved: (value) => mangaka.genero = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el genero';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEdad() {
    return TextFormField(
      initialValue: mangaka.edad.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Edad'),
      onSaved: (value) => mangaka.edad = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

   Widget _crearNacionalidad() {
    return TextFormField(
      //video
      initialValue: mangaka.nacionalidad,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nacionalidad del mangaka'),
      onSaved: (value) => mangaka.nacionalidad = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la nacionalidad';
        } else {
          return null;
        }
      },
    );
  }

   Widget _crearObra() {
    return TextFormField(
      //video
      initialValue: mangaka.obra,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Obra'),
      onSaved: (value) => mangaka.obra = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la obra';
        } else {
          return null;
        }
      },
    );
  }

//-------------------------------------------------------//

  Widget _crearDisponible() {
    return SwitchListTile(
        value: mangaka.disponible,
        title: Text('disponible'),
        activeColor: Color(0xFFBA68C8),
        onChanged: (value) => setState(() {
              mangaka.disponible = value;
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

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (mangaka.id == null) {
      
      mangakasProviders.crearMangaka(mangaka);
    } else {
      mangakasProviders.editarMangaka(mangaka);
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
}
