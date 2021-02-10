import 'dart:math';

import 'package:tic_tac_toe/classes/tablero.dart';

import 'ficha.dart';

class Minimax {
  static const int _minInt =
      (double.infinity is int) ? -double.infinity as int : (-1 << 63);
  static const int _maxInt =
      (double.infinity is int) ? double.infinity as int : ~_minInt;

  int _difficulty;
  Tablero _board;

  static Minimax configure() {
    return new Minimax();
  }

  Minimax setBoard(Tablero t) {
    this._board = t;
    return this;
  }

  Minimax setDifficulty(int d) {
    this._difficulty = d;
    return this;
  }

  void makeMovement() {
    if (_choosePerfectMovement()) {
      print("Perfect movement");
      _makePerfectMovement();
    } else {
      print("Random movement");
      _randomMovement();
    }
  }

  void _randomMovement() {
    List<List<int>> casillas = _board.getCasillasVacias();
    List<int> casillaEligida = casillas[new Random().nextInt(casillas.length)];
    _board.asignar(new Ficha(Ficha.CPU, casillaEligida[0], casillaEligida[1]));
  }

  void _makePerfectMovement() {
    if (!_board.finPartida()) {
      int fila = 0;
      int columna = 0;
      int valor = _minInt;
      int valorAuxiliar;
      List<List<int>> casillas = _board.getCasillas();

      for (int i = 0; i < casillas.length; i++) {
        for (int j = 0; j < casillas[i].length; j++) {
          if (casillas[i][j] == Ficha.VACIO) {
            casillas[i][j] = Ficha.CPU;
            valorAuxiliar = _min();
            if (valorAuxiliar > valor) {
              //System.out.println("ElegirMovimiento:"+valorAuxiliar + " mayor a " + valor);
              valor = valorAuxiliar;
              fila = i;
              columna = j;
            }
            casillas[i][j] = Ficha.VACIO;
          }
        }
      }
      _board.asignar(new Ficha(Ficha.CPU, fila, columna));
    }
  }

  int _max() {
    //Representa al jugador maquina
    if (_board.finPartida()) {
      //System.out.println("Maquina:" + ganaPartida());
      if (_board.ganaPartida() != -1) {
        return -1;
      } else {
        return 0;
      }
    }
    int valor = _minInt;
    int valorAuxiliar;
    List<List<int>> casillas = _board.getCasillas();

    for (int i = 0; i < casillas.length; i++) {
      for (int j = 0; j < casillas[i].length; j++) {
        if (casillas[i][j] == Ficha.VACIO) {
          casillas[i][j] = Ficha.CPU;
          valorAuxiliar = _min();
          if (valorAuxiliar > valor) {
            valor = valorAuxiliar;
          }
          casillas[i][j] = Ficha.VACIO;
        }
      }
    }
    return valor;
  }

  int _min() {
    //Representa al jugador humano
    if (_board.finPartida()) {
      //System.out.println("Humano:" + ganaPartida());
      if (_board.ganaPartida() != -1) {
        return 1;
      } else {
        return 0;
      }
    }
    int valor = _maxInt;
    int valorAuxiliar;
    List<List<int>> casillas = _board.getCasillas();

    for (int i = 0; i < casillas.length; i++) {
      for (int j = 0; j < casillas[i].length; j++) {
        if (casillas[i][j] == Ficha.VACIO) {
          casillas[i][j] = Ficha.JUGADOR;
          valorAuxiliar = _max();
          if (valorAuxiliar < valor) {
            valor = valorAuxiliar;
          }
          casillas[i][j] = Ficha.VACIO;
        }
      }
    }

    return valor;
  }

  bool _choosePerfectMovement() {
    Random rnd = new Random();
    int result = 0 + rnd.nextInt(100);
    return result <= this._difficulty;
  }
}
