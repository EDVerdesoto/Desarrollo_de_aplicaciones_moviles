import 'package:flutter/material.dart';

class Pantalla2 extends StatefulWidget {
  @override
  _Pantalla2State createState() => _Pantalla2State();
}

class _Pantalla2State extends State<Pantalla2> {
  final List<int> numeros = [];
  final TextEditingController controlador = TextEditingController();
  String resultado = "";

  void procesarNumero() {
    final input = controlador.text.trim();
    if (input.isEmpty) return;

    final numero = int.tryParse(input);
    if (numero == null || numero <= 0) {
      mostrarMensaje("Por favor ingresa un número natural válido.");
      return;
    }

    setState(() {
      numeros.add(numero);
      controlador.clear();
    });

    if (numeros.length == 100) {
      calcularResultados();
    }
  }

  void calcularResultados() {
    int menores15 = numeros.where((n) => n < 15).length;
    int mayores50 = numeros.where((n) => n > 50).length;
    int entre25y45 = numeros.where((n) => n >= 25 && n <= 45).length;
    double promedio = numeros.reduce((a, b) => a + b) / numeros.length;

    setState(() {
      resultado = '''
Resultados:
- Menores que 15: $menores15
- Mayores que 50: $mayores50
- Entre 25 y 45: $entre25y45
- Promedio: ${promedio.toStringAsFixed(2)}
''';
    });
  }

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ejercicio 17")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: controlador,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingresa un número natural (${numeros.length + 1}/100)",
              ),
              onSubmitted: (_) => procesarNumero(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: procesarNumero,
              child: Text("Agregar número"),
            ),
            SizedBox(height: 20),
            Text(resultado, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
