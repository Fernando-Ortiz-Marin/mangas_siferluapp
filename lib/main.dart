import 'package:flutter/material.dart';
import 'package:mangas_siferlu/pages/usuario.dart';
import 'package:mangas_siferlu/pages/manga.dart';
import 'package:mangas_siferlu/pages/mangaka.dart';

import 'home.dart';

void main() => runApp(mangasapp());

class mangasapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title:'Mangas siferlu',
      home: Home(),
      routes: {
        'usuario':(BuildContext context) => Usuario(),
        'manga':(BuildContext context) => Manga(),
        'mangakas':(BuildContext context) => Mangaka()

      },
      theme: ThemeData(
        primaryColor: Color(0xFFCE93D8),
        accentColor: Color(0xFFCE93D8)
      )
    );
  }
}