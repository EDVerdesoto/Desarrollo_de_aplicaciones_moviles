import '../models/anio_model.dart';

class AnioController {
  //verificar si es bisiesto

  bool verificarBisiesto(int anio) {
    return AnioModel(anio).esBisiesto();
  }

  //obtener10ultimos años
  List<int> obtenerUltimos(int desde, int cantidad) {
    List<int> lista = []; //crear lista vacia

    int actual = desde;
    while (lista.length < cantidad) {
      if (verificarBisiesto(actual)) {
        lista.add(actual);
        actual--;
      } else {
        actual--;
      }
    }
    return lista;
  }
}
