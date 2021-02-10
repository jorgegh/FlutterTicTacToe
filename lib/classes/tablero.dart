import 'ficha.dart';

class Tablero {
  List<List<int>> casillas;

  Tablero() {
    reiniciar();
  }

  bool estaLleno() {
    bool estaLleno = true;

    bool encontrado = false;

    for (int i = 0; i < this.casillas.length && !encontrado; i++) {
      for (int j = 0; j < this.casillas[i].length && !encontrado; j++) {
        if (this.casillas[i][j] == Ficha.VACIO) {
          estaLleno = false;
          encontrado = true;
        }
      }
    }

    return estaLleno;
  }

  void asignar(Ficha ficha) {
    if (this.puedoElegir(ficha)) {
      this.casillas[ficha.getFila()][ficha.getColumna()] = ficha.getJugador();
      //System.out.println("Se ha asignado una ficha de jugador " + ficha.getJugador());
      //System.out.println("VALORES: " + ficha.getFila() + ":" + ficha.getColumna());
    }
  }

  void reiniciar() {
    this.casillas = new List.generate(3, (_) => new List(3));
    for (int i = 0; i < this.casillas.length; i++) {
      for (int j = 0; j < this.casillas[i].length; j++) {
        this.casillas[i][j] = Ficha.VACIO;
      }
    }
  }

  bool puedoElegir(Ficha ficha) {
    bool puedoElegir = true;

    if (ficha.getFila() >= this.casillas.length ||
        ficha.getColumna() >= this.casillas[ficha.getFila()].length) {
      throw new Exception("Ficha fuera de rango");
    } else {
      if (this.casillas[ficha.getFila()][ficha.getColumna()] != Ficha.VACIO) {
        throw new Exception("Casilla ya asignada");
      }
    }

    return puedoElegir;
  }

  List<List<int>> getCasillas() {
    return this.casillas;
  }

  int ganaPartida() {
    List<List<int>> nTablero = this.getCasillas();

    if (nTablero[0][0] != -1 &&
        nTablero[0][0] == nTablero[1][1] &&
        nTablero[0][0] == nTablero[2][2]) return nTablero[0][0];
    if (nTablero[0][2] != -1 &&
        nTablero[0][2] == nTablero[1][1] &&
        nTablero[0][2] == nTablero[2][0]) return nTablero[0][2];
    for (int n = 0; n < 3; n++) {
      if (nTablero[n][0] != -1 &&
          nTablero[n][0] == nTablero[n][1] &&
          nTablero[n][0] == nTablero[n][2]) return nTablero[n][0];
      if (nTablero[0][n] != -1 &&
          nTablero[0][n] == nTablero[1][n] &&
          nTablero[0][n] == nTablero[2][n]) return nTablero[0][n];
    }
    return -1;
  }

  List<List<int>> getCasillasGanadoras() {
    List<List<int>> nTablero = this.getCasillas();
    if (nTablero[0][0] == nTablero[1][1] && nTablero[0][0] == nTablero[2][2]) {
      return [
        [0, 0],
        [1, 1],
        [2, 2]
      ];
    }
    if (nTablero[0][2] == nTablero[1][1] && nTablero[0][2] == nTablero[2][0]) {
      return [
        [0, 2],
        [1, 1],
        [2, 0]
      ];
    }
    for (int n = 0; n < 3; n++) {
      if (nTablero[n][0] == nTablero[n][1] &&
          nTablero[n][0] == nTablero[n][2]) {
        return [
          [n, 0],
          [n, 1],
          [n, 2]
        ];
      }
      if (nTablero[0][n] == nTablero[1][n] &&
          nTablero[0][n] == nTablero[2][n]) {
        return [
          [0, n],
          [1, n],
          [2, n]
        ];
      }
    }
  }

  bool finPartida() {
    //System.out.println("Esta lleno : " + this.tablero.estaLleno() + ": Ganador partida " + (this.ganaPartida() != -1));
    return this.estaLleno() || this.ganaPartida() != -1;
  }

  List<List<int>> getCasillasVacias() {
    List<List<int>> l = new List();
    for (int i = 0; i < this.casillas.length; i++) {
      for (int j = 0; j < this.casillas[i].length; j++) {
        if (this.casillas[i][j] == Ficha.VACIO) {
          l.add([i, j]);
        }
      }
    }
    return l;
  }
}
