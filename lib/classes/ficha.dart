class Ficha {
  int jugador;
  int fila;
  int columna;

  static const int VACIO = -1;
  static const int JUGADOR = 0;
  static const int CPU = 1;

  Ficha(int jugador, int fila, int columna) {
    if (jugador != JUGADOR && jugador != CPU) {
      throw Exception('Jugador no valido');
    } else {
      this.jugador = jugador;
      this.columna = columna;
      this.fila = fila;
    }
  }

  int getJugador() {
    return jugador;
  }

  void setJugador(int jugador) {
    this.jugador = jugador;
  }

  int getFila() {
    return fila;
  }

  void setFila(int fila) {
    this.fila = fila;
  }

  int getColumna() {
    return columna;
  }

  void setColumna(int columna) {
    this.columna = columna;
  }
}
