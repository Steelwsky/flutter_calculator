import 'package:flutter/material.dart';

final List<Color> _listBackground = [Color.fromARGB(255, 165, 165, 165), Color.fromARGB(255, 254, 149, 2) , Color.fromARGB(255, 51, 51, 51)];
final List<Color> _listColorsFonts = [Colors.black54, Colors.white];
final fFontSize = 42.0;
final fHeight = 70.0;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
          child: new Column(
            children: [
              Row(
                children: <Widget>[
                  _btnLgrey('AC'),
                  _btnLgrey('+-'),
                  _btnLgrey('%'),
                  _btnYellow('/')


                ],
              )
            ],
          ),


        ));
  }
}

Widget _btnLgrey  (String str){
  return MaterialButton(
    padding: EdgeInsets.all(16.0),
    height: fHeight,
    child: Text(str,
        style: TextStyle(fontSize: fFontSize)),
    textColor: _listColorsFonts[0],
    color: _listBackground[0],
    shape: CircleBorder(),
    onPressed: null,
  );
}

Widget _btnYellow  (String str, ){
  return MaterialButton(
    padding: EdgeInsets.all(16.0),
    height: fHeight,
    child: Text(str,
        style: TextStyle(fontSize: fFontSize)),
    textColor: _listColorsFonts[1],
    color: _listBackground[1],
    shape: CircleBorder(),
    onPressed: null,
  );
}

Widget _btnDgrey  (String str, Function() f){
  return MaterialButton(
    padding: EdgeInsets.all(16.0),
    height: fHeight,
    child: Text(str,
        style: TextStyle(fontSize: fFontSize)),
    textColor: _listColorsFonts[1],
    color: _listBackground[2],
    shape: CircleBorder(),
    onPressed: f,
  );
}