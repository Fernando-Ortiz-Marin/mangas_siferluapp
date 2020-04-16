import 'package:flutter/material.dart';
import 'package:mangas_siferlu/src/models/usuario.models.dart';
import 'package:mangas_siferlu/src/providers/usuarios_providers.dart';
import 'package:mangas_siferlu/src/utils/utils.dart' as utils;

class Usuario extends StatefulWidget {
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Video

  UsuarioModel usuario = new UsuarioModel();
  final usuariosProviders = new UsuariosProviders();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final UsuarioModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      usuario = proData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registro del Usuario'),
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
                _crearApellido(),
                _crearEdad(),
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
      initialValue: usuario.nombre,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre del usuario'),
      onSaved: (value) => usuario.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del usuario';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellido() {
    return TextFormField(
      //video
      initialValue: usuario.apellido,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellidos del usuario'),
      onSaved: (value) => usuario.apellido = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el apellido del usuario';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEdad() {
    return TextFormField(
      initialValue: usuario.edad.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Edad del usuario'),
      onSaved: (value) => usuario.edad = int.parse(value),
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
      initialValue: usuario.correo,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Correo del usuario'),
      onSaved: (value) => usuario.correo = value,
      validator: (value) {
        if (value.length < 8) {
          return 'Ingrese el correo del usuario';
        } else {
          return null;
        }
      },
    );
  }

   Widget _crearTarjeta() {
    return TextFormField(
      initialValue: usuario.tarjeta.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Tarjeta del usuario'),
      onSaved: (value) => usuario.tarjeta = int.parse(value),
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
        value: usuario.disponible,
        title: Text('disponible'),
        activeColor: Color(0xFFBA68C8),
        onChanged: (value) => setState(() {
              usuario.disponible = value;
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

    if (usuario.id == null) {
      
      usuariosProviders.crearUsuario(usuario);
    } else {
      usuariosProviders.editarUsuario(usuario);
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
