import 'package:flutter/material.dart';


class All_page extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Fernando OM-Israel GH-Luis N. CP'),
        brightness: Brightness.light,
      ),
      //body: _crearSlider(),
      body: Container(
        decoration: new BoxDecoration(color: Colors.yellowAccent),
        padding: EdgeInsets.only(top: 190.0, left: 40.0, right: 40.0),
        child: Column(
          children: <Widget>[
            Image.network('https://res.cloudinary.com/drdntpcar/image/upload/v1586985408/uq8bmid2ixm3f8elw6ma.png',)
          ],
        ),
      ),
    );
  }

}