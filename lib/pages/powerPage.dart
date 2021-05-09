import 'package:flutter/material.dart';

class Power extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('power'),),
      body: new Column(
        children: <Widget>[
          new Text('estamos en power')
        ],
      ),

    );
  }

}