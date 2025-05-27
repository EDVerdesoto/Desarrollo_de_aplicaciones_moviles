import 'package:flutter/material.dart';
import '../services/calculadora_servicio.dart';

class DetalleScreen extends StatelessWidget {
  final ResultadoCliente resultado;
  DetalleScreen({required this.resultado});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle ${resultado.cliente.nombre}')),
      body: Center(
        child: Hero(
          tag: resultado.cliente.id,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.all(24),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resultado.cliente.nombre,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    'Saldo actual: \$${resultado.saldoActual.toStringAsFixed(2)}',
                  ),
                  Text(
                    'Pago mínimo: \$${resultado.pagoMinimo.toStringAsFixed(2)}',
                  ),
                  Text(
                    'Pago sin intereses: \$${resultado.pagoSinIntereses.toStringAsFixed(2)}',
                  ),
                  Text(
                    'Intereses morosos: \$${resultado.interesesMorosos.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Regresar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
