import '../models/cliente.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/calculadora_servicio.dart';

final clientesProvider = Provider<List<Cliente>>(
  (_) => [
    Cliente(
      id: '1',
      nombre: 'Ana',
      saldoAnterior: 500,
      compras: 200,
      pagoAnterior: 100,
    ),
    Cliente(
      id: '2',
      nombre: 'Luis',
      saldoAnterior: 800,
      compras: 100,
      pagoAnterior: 50,
    ),
    Cliente(
      id: '3',
      nombre: 'María',
      saldoAnterior: 300,
      compras: 150,
      pagoAnterior: 80,
    ),
    Cliente(
      id: '4',
      nombre: 'Carlos',
      saldoAnterior: 1000,
      compras: 400,
      pagoAnterior: 200,
    ),
    Cliente(
      id: '5',
      nombre: 'Sofía',
      saldoAnterior: 600,
      compras: 250,
      pagoAnterior: 120,
    ),
  ],
);

final resultadosProvider = Provider<List<ResultadoCliente>>((ref) {
  final lista = ref.read(clientesProvider);
  return lista.map((c) => CalculadoraServicio.calcular(c)).toList();
});
