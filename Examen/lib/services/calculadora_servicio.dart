import '../models/cliente.dart';

class ResultadoCliente {
  final Cliente cliente;
  final double saldoActual;
  final double pagoMinimo;
  final double pagoSinIntereses;
  final double interesesMorosos;
  ResultadoCliente({
    required this.cliente,
    required this.saldoActual,
    required this.pagoMinimo,
    required this.pagoSinIntereses,
    required this.interesesMorosos,
  });
}

class CalculadoraServicio {
  static ResultadoCliente calcular(Cliente c) {
    // saldo actual = saldoAnterior + compras - pagoAnterior
    double base = c.saldoAnterior + c.compras - c.pagoAnterior;
    // intereses morosos = 12% de base + 200 de multa
    double intereses = base * 0.12 + 200;
    double saldoActual = base + intereses;
    double pagoMinimo = saldoActual * 0.15;
    double pagoSinIntereses = saldoActual * 0.85;
    return ResultadoCliente(
      cliente: c,
      saldoActual: saldoActual,
      pagoMinimo: pagoMinimo,
      pagoSinIntereses: pagoSinIntereses,
      interesesMorosos: intereses,
    );
  }
}
