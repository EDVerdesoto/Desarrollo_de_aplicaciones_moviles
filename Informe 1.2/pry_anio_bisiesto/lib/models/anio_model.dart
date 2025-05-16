class AnioModel {
  final int anio;

  AnioModel(this.anio);

  //aqui va la lógica

  bool esBisiesto() {
    return (anio % 4 == 0 && anio % 100 != 0) || (anio % 400 == 0);
  }
}
