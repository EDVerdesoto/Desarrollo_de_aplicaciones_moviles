import 'dart:math';

import 'package:flutter/material.dart';

class PowerSeries extends StatefulWidget {
  @override
  PowerSeriesState createState() {
    print('1. Ej 24. - createState');
    return PowerSeriesState();
  }
}

class PowerSeriesState extends State<PowerSeries> {
  // Declarar y mapear objetos

  TextEditingController numXController = TextEditingController();
  TextEditingController numNController = TextEditingController();
  String result = '';

  // Inicializar variables, cargar datos, iniciar animaciones
  @override
  void initState() {
    super.initState();
    print('2. Ej 24. initState()');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('3. Ej 24. didChangeDependencies()');
  }

  @override
  void didUpdateWidget(covariant PowerSeries oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('4. Ej 24. didUpdateWidget()');
  } // Comparar y reaccionar a cambios

  //Detección de salida temporal

  @override
  void deactivate() {
    super.deactivate();
    print('5. Ej 24. deactivate()');
  }

  @override
  void dispose() {
    print('6. Ej 24. dispose()');
    numXController.dispose();
    numNController.dispose();
    super.dispose();
  }

  //logica
  int calcFactorial(int number){
    if(number<0){
      throw Exception("Invalid Parameter");
    }
    int factorial=1;
    for(int i=number; i>1; i--){
      factorial *= i;
    }

    return factorial;
  }

  void calcPowerSerie() {

    double? x = double.tryParse(numXController.text);
    int? n = int.tryParse(numNController.text);
    String msg = '';
    
    if(n==null){
      msg = 'n debe ser un número entero positivo';
    }
    else if(x==null){
      msg = 'x debe ser un número real';
    }
    else{
      double sum = 0;
      for(int i=0; i<n; i++){
        sum += (pow(x, i))/calcFactorial(i);
      }
      msg = sum.toString();
    }

    setState(() {
      result = msg;
    });
  }

  // Diseño
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de la Serie de Potencia\n1 + x + (x^2/2!) + (x^3/3!) + ... + (x^n/n!)"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: numXController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingrese el parametro x de la serie (Núm. Real).",
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: numNController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingrese el parametro n de la serie (Núm. Entero).",
              ),
            ),

            SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => calcPowerSerie(),
                  child: Text("Calcular"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text(result, style: TextStyle(fontSize: 20)),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Volver"),
            ),

            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
