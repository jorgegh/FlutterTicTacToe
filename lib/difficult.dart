import 'package:flutter/material.dart';
import 'package:tic_tac_toe/classes/difficulty.dart';

class DifficultScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var difficults = [
      {"title": "Fácil", "difficult": Difficulty.EASY},
      {"title": "Normal", "difficult": Difficulty.NORMAL},
      {"title": "Difícil", "difficult": Difficulty.HARD},
      {"title": "Imposible", "difficult": Difficulty.IMPOSSIBLE}
    ];
    return Scaffold(
        body: Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red]),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Wrap(direction: Axis.vertical, children: [
                for (var d in difficults)
                  ButtonTheme(
                      minWidth: 150.0,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        highlightColor: Colors.red,
                        child: Text(
                          d["title"],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => _eventButton(context, d["difficult"]),
                      )),
              ]),
            )));
  }

  _eventButton(context, difficult) {
    print("Difficult --> $difficult");
    Navigator.of(context)
        .pushNamed('/game', arguments: {'difficulty': difficult});
  }
}
