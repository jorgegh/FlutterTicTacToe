import 'package:flutter/material.dart';

import 'animations/animation.dart';
import 'classes/ficha.dart';
import 'classes/minimax.dart';
import 'classes/tablero.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Tablero _tablero = new Tablero();
  bool _turnoJugador = true;
  int _ganados = 0, _perdidos = 0, _empates = 0;
  bool _finPartida = false;
  Minimax minimax;
  int _difficulty = 0;
  @override
  @override
  Widget build(BuildContext context) {
    if (_difficulty == 0) {
      final Map<String, Object> data =
          ModalRoute.of(context).settings.arguments;
      print("Dificultad elegida $data['difficulty']");
      this._difficulty = data['difficulty'];
      this.minimax =
          Minimax.configure().setBoard(_tablero).setDifficulty(_difficulty);
    }

    if (_tablero.finPartida()) {
      _showToast(context);
      setState(() {
        _ganados = _tablero.ganaPartida() == 0 ? _ganados + 1 : _ganados;
        _perdidos = _tablero.ganaPartida() == 1 ? _perdidos + 1 : _perdidos;
        _empates = _tablero.ganaPartida() == -1 ? _empates + 1 : _empates;
        _finPartida = true;
      });
    }
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red]),
            ),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Text(
                      "Ganadas",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("$_ganados",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ]),
                  SizedBox(width: 35),
                  Column(children: [
                    Text("Empates",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("$_empates",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ]),
                  SizedBox(width: 35),
                  Column(children: [
                    Text("Perdidas",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("$_perdidos",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ])
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Wrap(children: [
                    for (int i = 0; i < _tablero.getCasillas().length; i++)
                      Wrap(
                        children: [
                          Wrap(
                            children: [
                              for (int j = 0;
                                  j < _tablero.getCasillas()[i].length;
                                  j++)
                                GestureDetector(
                                    child: renderButton(i, j),
                                    onTap: () {
                                      onPressCase(i, j);
                                    }),
                            ],
                          )
                        ],
                      )
                  ])),
              SizedBox(
                height: 50,
              ),
              if (_finPartida)
                Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                        color: Colors.blueAccent,
                        highlightColor: Colors.red,
                        child: Text(
                          'Reiniciar',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        onPressed: () => pressReset()))
            ])));
  }

  void onPressCase(int x, int y) {
    if (_turnoJugador && !_finPartida) {
      print("Turno Usuario y ha jugado x $x e y $y");
      _tablero.asignar(new Ficha(Ficha.JUGADOR, x, y));
      setState(() {
        _turnoJugador = false;
      });
      turnoCpu();
    }
  }

  void pressReset() {
    _tablero.reiniciar();
    setState(() {
      _finPartida = false;
      _turnoJugador = true;
    });
  }

  void turnoCpu() {
    print("Turno CPU");
    minimax.makeMovement();
    setState(() {
      _turnoJugador = true;
    });
  }

  Widget renderButton(int x, int y) {
    int value = _tablero.getCasillas()[x][y];
    if (value == -1) {
      return renderBotonVacio();
    }
    if (_finPartida && _tablero.ganaPartida() != -1) {
      print("Tenemos un ganador!");
      if (esCasillaGanadora(x, y)) {
        print("La casilla $x e $y es ganadora");
        Widget child = renderBotonFicha(value, true);
        return CuadradoAnimado(child: child);
      } else {
        print("La casilla $x e $y no es ganadora");
      }
    }
    return renderBotonFicha(value, false);
  }

  Widget renderBotonFicha(int value, bool isWinner) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: isWinner
                ? (value == 1)
                    ? Colors.redAccent
                    : Colors.lightGreen
                : Colors.blueAccent,
            border: Border.all(),
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/" + ((value == 1) ? "o.png" : "x.png")),
            )));
  }

  bool esCasillaGanadora(int x, int y) {
    List<List<int>> ganadoras = _tablero.getCasillasGanadoras();
    bool esGanadora = false;
    for (int i = 0; i < ganadoras.length && !esGanadora; i++) {
      if (x == ganadoras[i][0] && y == ganadoras[i][1]) {
        esGanadora = true;
      }
    }
    return esGanadora;
  }

  Widget renderBotonVacio() {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          border: Border.all(),
        ));
  }

  void _showToast(BuildContext context) {
    int result = _tablero.ganaPartida();
    final String resultado = result == 0
        ? "Has ganado!"
        : result == 1
            ? "Has perdido!"
            : "Empate!";

    print("Resultado $result ---> $resultado");
  }
}
