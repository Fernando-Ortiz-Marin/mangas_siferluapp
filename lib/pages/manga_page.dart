import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mangas_siferlu/pages/manga.dart';
import 'package:mangas_siferlu/main.dart';
import 'package:mangas_siferlu/src/models/manga.models.dart';
import 'package:mangas_siferlu/src/providers/mangas_providers.dart';

class Manga_page extends StatelessWidget {
  final mangasProviders = new MangasProviders();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Mangas'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: mangasProviders.cargarManga(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MangaModel>> snapshot) {
          if (snapshot.hasData) {
            final mangas = snapshot.data;
            return ListView.builder(
              itemCount: mangas.length,
              itemBuilder: (context, i) => _crearItem(context, mangas[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, MangaModel manga) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          //TODO: Borrar manga
          mangasProviders.borrarManga(manga.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (manga.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no.png'))
                  : FadeInImage(
                      image: NetworkImage(manga.fotoUrl),
                      placeholder: AssetImage('assets/jar.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text(
                    'Nombre: ${manga.nombre} - Número de tomos: ${manga.tomos}'),
                subtitle: Text(manga.correo),
                onTap: () =>
                    Navigator.pushNamed(context, 'manga', arguments: manga),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xFFBA68C8),
      onPressed: () => Navigator.pushNamed(context, 'manga'),
    );
  }
}
