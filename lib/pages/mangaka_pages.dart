import 'package:flutter/material.dart';
import 'package:mangas_siferlu/pages/mangaka.dart';
import 'package:mangas_siferlu/main.dart';
import 'package:mangas_siferlu/src/models/mangaka.models.dart';
import 'package:mangas_siferlu/src/providers/mangakas_providers.dart';

class Mangaka_page extends StatelessWidget {
  
  final mangakasProviders = new MangakasProviders();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Mangakas Disponibles'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: mangakasProviders.cargarMangaka(),
        builder: (BuildContext context,
            AsyncSnapshot<List<MangakaModel>> snapshot) {
          if (snapshot.hasData) {
            final mangakas = snapshot.data;
            return ListView.builder(
              itemCount: mangakas.length,
              itemBuilder: (context, i) => _crearItem(context, mangakas[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      );
  }

  Widget _crearItem(BuildContext context, MangakaModel mangakas){

    
    return Dismissible
    (key: UniqueKey(),
    background: Container(
      color: Colors.red,
    ),
    onDismissed: (direccion){
      mangakasProviders.borrarMangaka(mangakas.id);

    },
    child: ListTile(
      title: Text('Genero: ${mangakas.genero} - Obra mas notable: ${mangakas.obra}'),
      subtitle: Text('Nombre: ${mangakas.nombre}'),
      onTap: () =>Navigator.pushNamed(context, 'mangakas',arguments: mangakas),
    ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xFFBA68C8),
      onPressed: () => Navigator.pushNamed(context, 'mangakas'),
    );
  }
}
