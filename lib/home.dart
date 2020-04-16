import 'package:flutter/material.dart';
import 'package:mangas_siferlu/pages/all_page.dart';
import 'pages/manga_page.dart';
import 'pages/mangaka_pages.dart';
import 'pages/usuario_page.dart';


class Home extends StatefulWidget{
  HomeState createState() => HomeState();
}


class HomeState extends State <Home>{

  int _selectDrawerItem =0;
    _getDraweItemWidget(int pos){
      switch(pos){
        case 0: return All_page(); 
        case 1: return Usuario_page();
        case 2: return Manga_page();
        case 3: return Mangaka_page(); 
      }
    }

    _onSelectItem(int pos){
      Navigator.of(context).pop();
      setState(() {
        _selectDrawerItem = pos;
      });
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Mangas siferlu'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Usuario'),
              accountEmail: Text('All@utpuebla.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFFCE93D8),
                child:Text('All',style: TextStyle(fontSize: 40.0),),
                ),
              ),
            ListTile(
              title: Text('Bienvenidos :3'),
              leading: Icon(Icons.home),
              selected: (0 == _selectDrawerItem),
              onTap: (){
                _onSelectItem(0);
              },
            ),  
            ListTile(
              title: Text('Usuario'),
              leading: Icon(Icons.supervised_user_circle),
              selected: (1 == _selectDrawerItem),
              onTap: (){
                _onSelectItem(1);
              },
            ),
               ListTile(
              title: Text('Manga'),
              leading: Icon(Icons.book),
              selected: (2 == _selectDrawerItem),
              onTap: (){
                 _onSelectItem(2);
              },
            ),
               ListTile(
              title: Text('Mangaka'),
              leading: Icon(Icons.home),
              selected: (3  == _selectDrawerItem),
              onTap: (){
                _onSelectItem(3);
              },
            ),
          ],
        ),
      ),
      body: _getDraweItemWidget(_selectDrawerItem),
    );
  }
}