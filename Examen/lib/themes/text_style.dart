import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle alerta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.redAccent,
  );

  static const TextStyle aviso = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: Colors.black54, // tono un poco transparente
  );

  static const TextStyle titulo = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle resultado = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    fontFamily:
        'RobotoRounded', // Usa una fuente redondeada, si no está, agrega Roboto Rounded a tu proyecto
  );
}
