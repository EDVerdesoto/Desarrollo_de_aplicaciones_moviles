import 'package:flutter/material.dart';
import '../Pantallas/pantalla1.dart';
import '../Pantallas/pantalla2.dart';
import '../Pantallas/pantalla3.dart';
import '../Pantallas/pantalla4.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menú Principal")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ElevatedButton( // crea un boton 
            onPressed:
                () => Navigator.push(  //navigator.push hace que el boton sea un link
                  context, 
                  MaterialPageRoute(builder: (_) => Pantalla1()),  //click para la clase que se debe mostrar
                ),
            child: Text("Opción 1"), //texto que se muestra en el boton
          ),
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Pantalla2()),
                ),
            child: Text("Opción 2"),
          ),
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Pantalla3()),
                ),
            child: Text("Opción 3"),
          ),
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Pantalla4()),
                ),
            child: Text("Opción 4"),
          ),
        ],
      ),
    );
  }
}
