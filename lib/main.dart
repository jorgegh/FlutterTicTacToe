import 'package:flutter/material.dart';
import 'package:tic_tac_toe/difficult.dart';
import 'package:tic_tac_toe/game.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My first app",
        routes: <String, WidgetBuilder>{
          '/title': (BuildContext context) => Titlecreen(),
          '/difficult': (BuildContext context) => DifficultScreen(),
          '/game': (BuildContext context) => GameScreen(),
        },
        home: Titlecreen());
  }
}

class Titlecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue, Colors.red])),
            child: Align(
              alignment: Alignment.center,
              child: Center(
                  child: Wrap(children: [
                Align(
                    child: Text("Tic Tac Toe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white))),
                SizedBox(
                  height: 150,
                ),
                Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                        color: Colors.blueAccent,
                        highlightColor: Colors.red,
                        child: Text(
                          'Jugar',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        onPressed: _eventButton(context)))
              ])),
            )));
  }

  _eventButton(context) {
    return () {
      print("Button pushed");
      String nombre = "Jorge";
      Navigator.of(context)
          .pushNamed('/difficult', arguments: {'title': 'This is a String'});
    };
  }
}
