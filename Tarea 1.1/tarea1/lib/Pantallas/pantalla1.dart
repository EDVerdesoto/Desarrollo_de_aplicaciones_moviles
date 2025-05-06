import 'package:flutter/material.dart';

class Pantalla1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ejercicio 16")),
      body: Center(
        child: Text("Contenido de la pantalla 1"),
      ), //texto que se muestra en el centro
    );
  }
}
