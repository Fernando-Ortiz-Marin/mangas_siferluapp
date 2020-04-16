import 'package:flutter/material.dart';
import 'package:mangas_siferlu/pages/usuario.dart';
import 'package:mangas_siferlu/main.dart';
import 'package:mangas_siferlu/src/models/usuario.models.dart';
import 'package:mangas_siferlu/src/providers/usuarios_providers.dart';

class Usuario_page extends StatelessWidget {
  
  final usuariosProviders = new UsuariosProviders();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuario'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: usuariosProviders.cargarUsuario(),
        builder: (BuildContext context,
            AsyncSnapshot<List<UsuarioModel>> snapshot) {
          if (snapshot.hasData) {
            final usuarios = snapshot.data;
            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, i) => _crearItem(context, usuarios[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      );
  }

  Widget _crearItem(BuildContext context, UsuarioModel usuario){

    
    return Dismissible
    (key: UniqueKey(),
    background: Container(
      color: Colors.red,
    ),
    onDismissed: (direccion){
      //TODO: Borrar usuario
      usuariosProviders.borrarUsuario(usuario.id);

    },
    child: ListTile(
      title: Text('Nombre: ${usuario.nombre} - Edad: ${usuario.edad}'),
      subtitle: Text(usuario.correo),
      onTap: () =>Navigator.pushNamed(context, 'usuario',arguments: usuario),
    ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xFFBA68C8),
      onPressed: () => Navigator.pushNamed(context, 'usuario'),
    );
  }
}
