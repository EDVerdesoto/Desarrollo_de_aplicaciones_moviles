import 'package:flutter/material.dart';

class Amigos extends StatefulWidget {
  @override
  State<Amigos> createState() => AmigosState();
}

class AmigosState extends State<Amigos> {
  //logica
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String _resultado = "";

  //iniciar variables
  @override
  void initState() {
    super.initState();
  }

  //Funcion para verificar si un numero es amigo
  void _esAmigo() {
    int sumNum1 = 0;
    int sumNum2 = 0;
    double num1 = double.parse(num1Controller.text);
    double num2 = double.parse(num2Controller.text);

    if (num1 > 0) {
      for (int i = 1; i < num1; i++) {
        if (num1 % i == 0) {
          sumNum1 += i;
        }
      }
    }

    if (num2 > 0) {
      for (int j = 1; j < num2; j++) {
        if (num2 % j == 0) {
          sumNum2 += j;
        }
      }
    }
    setState(() {
      if (sumNum1 == num2 && sumNum2 == num1) {
        _resultado = "El número $num1 es amigo del número $num2";
      } else {
        _resultado = "El número $num1 no es amigo del número $num2";
      }
    });
  }

  // Diseño
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ejercicio 18"),
        backgroundColor: const Color.fromARGB(255, 155, 183, 206),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingrese el primer número",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingrese el segundo número",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => _esAmigo(),
              child: Text("Comprobar si son amigos"),
            ),

            SizedBox(height: 15),

            Text(
              _resultado,
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 8, 0, 20),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
