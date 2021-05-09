import 'package:flutter/material.dart';
class Vendedor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('ventas'),),
      body: new Column(
        children: <Widget>[
          new Text('estamos en ventas')
        ],
      ),

    );
  }

}